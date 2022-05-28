import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../models/models.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  TextEditingController area = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController address = TextEditingController();

  final NewPostRepository _repository;

  NewPostBloc({required NewPostRepository repository})
      : _repository = repository,
        super(const NewPostInitial(currentStep: 0)) {
    on<NewPostNextEvent>(onNextStep);
    on<NewPostBackEvent>(onPreviousStep);
    on<NewPostDoneEvent>(onConmpleteStep);
    on<NewPostJumpToEvent>(onJumpToStep);

    on<NewPostCreateEvent>(onCreatePost);
    on<NewPostUploadThumbnailEvent>(uploadThumbnail);
    on<NewPostUploadThumbnailsEvent>(uploadListThumbnail);
    on<NewPostDiscardEvent>(discardPost);
  }

  onNextStep(NewPostNextEvent event, Emitter<NewPostState> emit) {
    int next = state.currentStep + 1;
    debugPrint('next');
    emit(NewPostInitial(currentStep: next, post: state.post));
  }

  onPreviousStep(NewPostBackEvent event, Emitter<NewPostState> emit) {
    int prev = state.currentStep - 1;
    debugPrint('back');
    emit(NewPostInitial(currentStep: prev, post: state.post));
  }

  onConmpleteStep(NewPostDoneEvent event, Emitter<NewPostState> emit) {
    debugPrint('done');
  }

  onJumpToStep(NewPostJumpToEvent event, Emitter<NewPostState> emit) {
    emit(NewPostInitial(currentStep: event.index, post: state.post));
  }

  onCreatePost(NewPostCreateEvent event, Emitter<NewPostState> emit) async {
    debugPrint('create');
    emit(NewPostLoading(currentStep: state.currentStep, post: state.post));
    List<MapEntry<String, Uint8List>> images = [];
    for (Room room in event.rooms) {
      Uint8List data = await File(room.imgUrl ?? '').readAsBytes();
      images
          .add(MapEntry('${room.name}.${room.imgUrl?.split(".").last}', data));
    }

    var response = await _repository.createPost(
      images: images,
      imageDescription:
          event.rooms.map((room) => 'Phòng ${room.name}').toList(),
      landInfo: event.post.toFormData(),
    );
    debugPrint(response.object.id);
    response.object.rooms?.forEach((room) => print(room.name));
    emit(NewPostInitial(currentStep: state.currentStep, post: response.object));

    // await Future.delayed(const Duration(seconds: 2));
    add(NewPostNextEvent());
  }

  uploadThumbnail(
      NewPostUploadThumbnailEvent event, Emitter<NewPostState> emit) async {
    debugPrint('upload thumbnail');
    // emit(NewPostLoading(currentStep: state.currentStep, post: state.post));
    List<MapEntry<String, Uint8List>> images = [];
    // for (ui.Image img in event.images) {
    //    ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    //   Uint8List? data = byteData?.buffer.asUint8List();
    //   if (data != null) {
    //     images.add(MapEntry('thumbnail.jpg', data));
    //   }
    // }
    for (Uint8List img in event.images) {
      images.add(MapEntry('thumbnail.jpg', img));
    }

    if (images.isNotEmpty) {
      var response = await _repository.uploadThumbnail(
          roomId: event.roomId, images: images);
      debugPrint(response.toString());
      // emit(NewPostInitial(currentStep: state.currentStep, post: state.post));
    }
  }

  uploadListThumbnail(
      NewPostUploadThumbnailsEvent event, Emitter<NewPostState> emit) async {
    emit(NewPostLoading(currentStep: state.currentStep, post: state.post));
    for (String roomId in event.thumbnails.keys) {
      List<MapEntry<String, Uint8List>> images = [];

      for (Uint8List img in event.thumbnails[roomId] ?? []) {
        images.add(MapEntry('thumbnail.jpg', img));
      }

      if (images.isNotEmpty) {
        var response =
            await _repository.uploadThumbnail(roomId: roomId, images: images);
        debugPrint(response.toString());
        // emit(NewPostInitial(currentStep: state.currentStep, post: state.post));
      }
    }

    emit(NewPostInitial(currentStep: state.currentStep, post: state.post));
    add(NewPostNextEvent());
  }

  discardPost(NewPostDiscardEvent event, Emitter<NewPostState> emit) async {
    if (state.post?.id != null) {
      emit(NewPostLoading(currentStep: state.currentStep, post: state.post));

      try {
        await _repository.deletePost(id: state.post!.id!);
        emit(NewPostDiscard(currentStep: state.currentStep, post: state.post));
      } catch (e) {
        emit(NewPostError(currentStep: state.currentStep, post: state.post));
      }
    }
  }
}
