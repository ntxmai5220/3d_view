part of 'image_view_bloc.dart';

abstract class ImageViewState {
  List<Room> rooms;
  ImageViewState({required this.rooms});
}

class ImageViewInitial extends ImageViewState {
  ImageViewInitial({required List<Room> rooms}) : super(rooms: rooms);
}
