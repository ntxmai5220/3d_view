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
        super(ThumbnailViewInitial(capture: [])) {
    on<ThumbnailViewReceivedCapturesEvent>(receivedCaptures);
  }

  receivedCaptures(ThumbnailViewReceivedCapturesEvent event,
      Emitter<ThumbnailViewState> emit) {
    // List<ui.Image> newCapture = state.capture;
    // debugPrint(newCapture.length.toString());
    // newCapture.addAll(event.capture);
    // debugPrint(newCapture.length.toString());
    emit(ThumbnailViewInitial(capture: state.capture..addAll(event.capture)));
  
  }
}
