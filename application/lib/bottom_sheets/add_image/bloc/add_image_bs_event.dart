part of 'add_image_bs_bloc.dart';

@immutable
abstract class AddImageBSEvent {}

class AddImageBSDoneEvent extends AddImageBSEvent {
  final String path;

  AddImageBSDoneEvent({required this.path});
}

class AddImageBSDownloadCameraEvent extends AddImageBSEvent {
  final String savePath;

  AddImageBSDownloadCameraEvent({required this.savePath});
}
