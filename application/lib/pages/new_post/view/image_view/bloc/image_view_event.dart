part of 'image_view_bloc.dart';

abstract class ImageViewEvent {}

class ImageViewAddMultipleImagesEvent extends ImageViewEvent {
  final List<XFile> images;

  ImageViewAddMultipleImagesEvent({required this.images});
}

class ImageViewDeleteImageEvent extends ImageViewEvent {
  final String? id;

  ImageViewDeleteImageEvent({required this.id});
}

class ImageViewRenameImageEvent extends ImageViewEvent {
  final String? id;
  final String? name;
  ImageViewRenameImageEvent({
    required this.id,
    required this.name,
  });
}
