part of 'thumbnail_view_bloc.dart';

abstract class ThumbnailViewState {
  Map<String, List<Uint8List>> capture;
  ThumbnailViewState({
    required this.capture,
  });
}

class ThumbnailViewInitial extends ThumbnailViewState {
  ThumbnailViewInitial({required Map<String, List<Uint8List>> capture})
      : super(capture: capture);
}
