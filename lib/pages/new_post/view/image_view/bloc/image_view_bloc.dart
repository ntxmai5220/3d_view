import 'dart:async';

import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'image_view_event.dart';
part 'image_view_state.dart';

class ImageViewBloc extends Bloc<ImageViewEvent, ImageViewState> {
  final NewPostRepository _repository;
  ImageViewBloc({required NewPostRepository repository})
      : _repository = repository,
        super(ImageViewInitial(rooms: [])) {
    on<ImageViewAddEvent>(addNewRoom);
  }

  addNewRoom(ImageViewAddEvent event, Emitter<ImageViewState> emit) {
    Room newRoom = Room(img: event.path);
    var currentState = state;
    currentState.rooms.add(newRoom);
    debugPrint('rooms   ${state.rooms.length}');
    
    // debugPrint('rooms   ${list.length}');
    emit(ImageViewInitial(rooms: currentState.rooms));
    
  }
}
