part of 'thumbnail_view_bloc.dart';

@immutable
abstract class ThumbnailViewEvent {}

class ThumbnailViewReceivedCapturesEvent extends ThumbnailViewEvent {
  final List<ui.Image> capture;
  ThumbnailViewReceivedCapturesEvent({
    required this.capture,
  });
}
