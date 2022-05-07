part of 'thumbnail_view_bloc.dart';

@immutable
abstract class ThumbnailViewEvent {}

class ThumbnailViewReceivedCapturesEvent extends ThumbnailViewEvent {
  final List<ui.Image> capture;
  final String roomId;

  ThumbnailViewReceivedCapturesEvent({
    required this.capture,
    required this.roomId,
  });
}

class ThumbnailViewDeleteCaptureEvent extends ThumbnailViewEvent {
  final String roomId;
  final int index;

  ThumbnailViewDeleteCaptureEvent({
    required this.roomId,
    required this.index,
  });
}
