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

class NewPostUploadThumbnailEvent extends NewPostEvent {
  // final List<ui.Image> images;
  final List<Uint8List> images;
  final String roomId;
  NewPostUploadThumbnailEvent({
    required this.images,
    required this.roomId,
  });
}

class NewPostUploadThumbnailsEvent extends NewPostEvent {
  final Map<String, List<Uint8List>> thumbnails;
  NewPostUploadThumbnailsEvent({
    required this.thumbnails,
  });
}
