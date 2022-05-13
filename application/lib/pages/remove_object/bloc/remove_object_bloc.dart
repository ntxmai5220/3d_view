import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'dart:ui' as ui;
part 'remove_object_event.dart';
part 'remove_object_state.dart';

class RemoveObjectBloc extends Bloc<RemoveObjectEvent, RemoveObjectState> {
  RemoveObjectRepository _repository;
  PainterController painterController;

  RemoveObjectBloc({
    required RemoveObjectRepository repository,
    required this.painterController,
  })  : _repository = repository,
        super(RemoveObjectInitial()) {
    on<RemoveObjectSendMaskEvent>(sendMask);
    on<RemoveObjectInitEvent>(init);
    on<ToggleDrawEvent>(toggleFreeStyleDraw);
    on<ToggleEraseEvent>(toggleFreeStyleErase);
    on<UndoEvent>(undo);
    on<RedoEvent>(redo);
    on<RemoveObjectGenMaskEvent>(genMask);
    on<RemoveObjectResetEvent>(reset);
    on<RemoveObjectUploadImageEvent>(uploadImage);
  }

  sendMask(
      RemoveObjectSendMaskEvent event, Emitter<RemoveObjectState> emit) async {
    // final ui.Image send = await event.painterController.renderImage(event.size);
    // ByteData? byteData = await send.toByteData(format: ui.ImageByteFormat.png);
    debugPrint('start');
    try {
      // await _repository.inpainting(image: event.image, mask: event.mask);
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('done');
    // MultipartFile.fromBytes(byteData?.buffer.asInt64List().cast<int>() ?? []);
  }

  init(RemoveObjectInitEvent event, Emitter<RemoveObjectState> emit) async {
    try {
      emit(RemoveObjectLoading());
      final image = await CachedNetworkImageProvider(event.url).image;
      painterController.background = image.backgroundDrawable;
      emit(RemoveObjectLoaded(background: image));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toggleFreeStyleDraw(ToggleDrawEvent event, Emitter<RemoveObjectState> emit) {
    debugPrint('draw');
    painterController.freeStyleMode =
        painterController.freeStyleMode != FreeStyleMode.draw
            ? FreeStyleMode.draw
            : FreeStyleMode.none;
  }

  toggleFreeStyleErase(
      ToggleEraseEvent event, Emitter<RemoveObjectState> emit) {
    painterController.freeStyleMode =
        painterController.freeStyleMode != FreeStyleMode.erase
            ? FreeStyleMode.erase
            : FreeStyleMode.none;
  }

  undo(UndoEvent event, Emitter<RemoveObjectState> emit) {
    painterController.undo();
    if (painterController.drawables.isEmpty &&
        painterController.freeStyleMode == FreeStyleMode.erase) {
      painterController.freeStyleMode = FreeStyleMode.none;
    }
  }

  redo(RedoEvent event, Emitter<RemoveObjectState> emit) {
    painterController.redo();
  }

  genMask(
      RemoveObjectGenMaskEvent event, Emitter<RemoveObjectState> emit) async {
    Size size = Size(state.background!.width.toDouble(),
        state.background!.height.toDouble());
    emit(RemoveObjectLoading(background: state.background));
    painterController.background =
        const ColorBackgroundDrawable(color: Colors.black);

    final mask = await painterController
        .renderImage(size)
        .then((value) => value.toByteData(format: ui.ImageByteFormat.png));
    // Future.wait([
    //   state.background!.toByteData(format: ui.ImageByteFormat.png), //img
    //   painterController.renderImage(size).then(
    //       (value) => value.toByteData(format: ui.ImageByteFormat.png)) //mask
    // ]).then((value) => list.addAll(value));
    final image =
        await state.background!.toByteData(format: ui.ImageByteFormat.png);
    painterController.background = state.background!.backgroundDrawable;
    if (image != null && mask != null) {
      Uint8List dataImage = image.buffer.asUint8List();
      String base64Image = base64Encode(dataImage);

      Uint8List dataMask = mask.buffer.asUint8List();
      String base64Mask = base64Encode(dataMask);

      var response = await _repository.sendMask(
          base64Image: base64Image, base64Mask: base64Mask);

      if (response.object != null) {
        emit(RemoveObjectReceivedMask(
            background: state.background, mask: response.object!));
      } else {
        debugPrint('error');
        emit(RemoveObjectError(background: state.background));
        // emit(RemoveObjectLoaded(background: state.background!));
      }
    }
  }

  reset(RemoveObjectResetEvent event, Emitter<RemoveObjectState> emit) {
    debugPrint('reset');
    emit(RemoveObjectLoaded(background: state.background!));
  }

  uploadImage(RemoveObjectUploadImageEvent event,
      Emitter<RemoveObjectState> emit) async {
    var currentState = state;
    if (currentState is RemoveObjectReceivedMask) {
      emit(RemoveObjectLoading(background: state.background));
      MapEntry<String, Uint8List> removeImage =
          MapEntry('removeImage.jpg', base64Decode(currentState.mask));

      var response = await _repository.uploadRemoveImage(
          roomId: event.roomId, removeImage: removeImage);
      if (response.object != null) {
        emit(RemoveObjectUploadCompleted(background: state.background));
      } else {
        add(RemoveObjectResetEvent());
      }
    }
  }
}
