import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';

part 'remove_object_event.dart';
part 'remove_object_state.dart';

class RemoveObjectBloc extends Bloc<RemoveObjectEvent, RemoveObjectState> {
  RemoveObjectRepository _repository;

  RemoveObjectBloc({required RemoveObjectRepository repository})
      : _repository = repository,
        super(RemoveObjectInitial()) {
    on<RemoveObjectSendMaskEvent>(sendMask);
  }

  sendMask(
      RemoveObjectSendMaskEvent event, Emitter<RemoveObjectState> emit) async {
    // final ui.Image send = await event.painterController.renderImage(event.size);
    // ByteData? byteData = await send.toByteData(format: ui.ImageByteFormat.png);
    debugPrint('start');
    try {
      await _repository.inpainting(image: event.image, mask: event.mask);
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('done');
    // MultipartFile.fromBytes(byteData?.buffer.asInt64List().cast<int>() ?? []);
  }
}
