part of 'new_post_bloc.dart';

@immutable
abstract class NewPostEvent {}

class NewPostNextEvent extends NewPostEvent {}

class NewPostBackEvent extends NewPostEvent {}

class NewPostDoneEvent extends NewPostEvent {}

class NewPostJumpToEvent extends NewPostEvent {
  final int index;

  NewPostJumpToEvent(this.index);
}

class NewPostCreateEvent extends NewPostEvent {
  final Post post;
  final List<Room> rooms;

  NewPostCreateEvent({
    required this.post,
    required this.rooms,
  });
}
