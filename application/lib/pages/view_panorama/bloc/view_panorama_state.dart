part of 'view_panorama_bloc.dart';

abstract class ViewPanoramaState {
  int currentRoom;
  List<Room> rooms;
  ViewPanoramaState({
    required this.currentRoom,
    required this.rooms,
  });
}

class ViewPanoramaInitial extends ViewPanoramaState {
  ViewPanoramaInitial({
    required int currentRoom,
    required List<Room> rooms,
  }) : super(
          currentRoom: currentRoom,
          rooms: rooms,
        );
}

class ViewPanoramaLoading extends ViewPanoramaState {
  ViewPanoramaLoading({
    required int currentRoom,
    required List<Room> rooms,
  }) : super(
          currentRoom: currentRoom,
          rooms: rooms,
        );
}

class ViewPanoramaLoaded extends ViewPanoramaState {
  ViewPanoramaLoaded({
    required int currentRoom,
    required List<Room> rooms,
  }) : super(
          currentRoom: currentRoom,
          rooms: rooms,
        );
}

class ViewPanoramaError extends ViewPanoramaState {
  ViewPanoramaError({
    required int currentRoom,
    required List<Room> rooms,
  }) : super(
          currentRoom: currentRoom,
          rooms: rooms,
        );
}
