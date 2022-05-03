import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/new_post/new_post_repository.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'image_view_event.dart';
part 'image_view_state.dart';

class ImageViewBloc extends Bloc<ImageViewEvent, ImageViewState> {
  final NewPostRepository _repository;
  ImageViewBloc({required NewPostRepository repository})
      : _repository = repository,
        super(ImageViewInitial(rooms: [])) {
    on<ImageViewAddImageEvent>(addNewRoom);
    on<ImageViewAddMultipleImagesEvent>(addMultiRooms);
    on<ImageViewDeleteImageEvent>(deleteRoom);
    on<ImageViewRenameImageEvent>(renameRoom);
  }

  addNewRoom(ImageViewAddImageEvent event, Emitter<ImageViewState> emit) {
    String id;
    if (state.rooms.isEmpty) {
      id = '0';
    } else {
      id = (int.parse(state.rooms.last.id!) + 1).toString();
    }
    Room newRoom = Room(imgUrl: event.path, id: id, name: id);
    var currentState = state;
    currentState.rooms.add(newRoom);
    debugPrint('rooms   ${state.rooms.length}');

    // debugPrint('rooms   ${list.length}');
    emit(ImageViewInitial(rooms: currentState.rooms));
  }

  deleteRoom(ImageViewDeleteImageEvent event, Emitter<ImageViewState> emit) {
    var currentState = state;
    currentState.rooms.removeWhere((room) => room.id == event.id);
    debugPrint(currentState.rooms.length.toString());
    emit(ImageViewInitial(rooms: currentState.rooms));
  }

  renameRoom(ImageViewRenameImageEvent event, Emitter<ImageViewState> emit) {
    var currentState = state;

    // var renameRoom =
    currentState.rooms.firstWhere((room) => room.id == event.id).name =
        event.name;
    // int index = currentState.rooms.indexOf(renameRoom);
    // renameRoom.name = event.name;
    // currentState.rooms.elementAt(index).name = event.name;
    emit(ImageViewInitial(rooms: currentState.rooms));
  }

  addMultiRooms(
      ImageViewAddMultipleImagesEvent event, Emitter<ImageViewState> emit) {
    var currentState = state;
    currentState.rooms;

    for (XFile img in event.images) {
      state.rooms.add(createRoom(img.path));
    }
    emit(ImageViewInitial(rooms: state.rooms));
  }

  Room createRoom(String path) {
    String id;
    if (state.rooms.isEmpty) {
      id = '0';
    } else {
      id = (int.parse(state.rooms.last.id!) + 1).toString();
    }
    return Room(imgUrl: path, id: id, name: id);
  }
}
