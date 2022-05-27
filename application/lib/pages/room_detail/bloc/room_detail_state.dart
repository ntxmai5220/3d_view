part of 'room_detail_bloc.dart';

abstract class RoomDetailState {}

class RoomDetailInitial extends RoomDetailState {}

class RoomDetailLoading extends RoomDetailState {}

class RoomDetailLoaded extends RoomDetailState {
  final Room room;
  RoomDetailLoaded({required this.room});
}

class RoomDetailError extends RoomDetailState {
  final String? error;
  RoomDetailError({
    this.error,
  });
}
