part of 'image_view_bloc.dart';

abstract class ImageViewState {
  List<Room> rooms;
  ImageViewState({required this.rooms});
}

class ImageViewInitial extends ImageViewState {
  ImageViewInitial({required List<Room> rooms}) : super(rooms: rooms);
}

class ImageViewDownloadingCamera extends ImageViewState {
  ImageViewDownloadingCamera({
    required List<Room> rooms,
    this.percentDownloaded = 0,
  }) : super(rooms: rooms);

  final int percentDownloaded;

  ImageViewDownloadingCamera downloadingCamera({required int percent}) =>
      ImageViewDownloadingCamera(
        rooms: rooms,
        percentDownloaded: percent,
      );
}
