import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'thumbnail_view_event.dart';
part 'thumbnail_view_state.dart';

class ThumbnailViewBloc extends Bloc<ThumbnailViewEvent, ThumbnailViewState> {
  NewPostRepository _repository;
  ThumbnailViewBloc({required NewPostRepository repository})
      : _repository = repository,
        super(ThumbnailViewInitial(capture: {})) {
    on<ThumbnailViewReceivedCapturesEvent>(receivedCaptures);
    on<ThumbnailViewDeleteCaptureEvent>(deleteCapture);
  
  }

  receivedCaptures(ThumbnailViewReceivedCapturesEvent event,
      Emitter<ThumbnailViewState> emit) async {
    // List<ui.Image> newCapture = state.capture;
    // debugPrint(newCapture.length.toString());
    // newCapture.addAll(event.capture);
    // debugPrint(newCapture.length.toString());
    var listTumbnail = state.capture[event.roomId];
    List<Uint8List> images = [];
    for (ui.Image img in event.capture) {
      ByteData? byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? data = byteData?.buffer.asUint8List();
      if (data != null) {
        images.add(data);
      }
    }
    if (listTumbnail != null) {
      state.capture[event.roomId]!.addAll(images);
    } else {
      state.capture[event.roomId] = images;
    }

    emit(ThumbnailViewInitial(capture: state.capture));
  }

  deleteCapture(
      ThumbnailViewDeleteCaptureEvent event, Emitter<ThumbnailViewState> emit) {
    print(state.capture[event.roomId]!.length);
    state.capture[event.roomId]!.removeAt(event.index);
    emit(ThumbnailViewInitial(capture: state.capture));
    // print(state.capture[event.roomId]!.length);
  }
}
