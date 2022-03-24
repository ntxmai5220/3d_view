part of 'image_view_bloc.dart';

abstract class ImageViewEvent {}

class ImageViewAddEvent extends ImageViewEvent {
  final String path;

  ImageViewAddEvent({required this.path});
}
