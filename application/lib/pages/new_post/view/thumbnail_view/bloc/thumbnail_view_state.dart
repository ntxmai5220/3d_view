part of 'thumbnail_view_bloc.dart';

abstract class ThumbnailViewState {
  List<ui.Image> capture;
  ThumbnailViewState({
    required this.capture,
  });
}

class ThumbnailViewInitial extends ThumbnailViewState {
  ThumbnailViewInitial({required List<ui.Image> capture})
      : super(capture: capture);
}
