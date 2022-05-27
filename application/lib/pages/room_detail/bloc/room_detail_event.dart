part of 'room_detail_bloc.dart';

@immutable
abstract class RoomDetailEvent {}

class RoomDetailInitEvent extends RoomDetailEvent {
  final String roomId;
  RoomDetailInitEvent({
    required this.roomId,
  });
}
