part of 'add_image_bs_bloc.dart';

abstract class AddImageBSState {
  double percentDownloaded;

  AddImageBSState({this.percentDownloaded = 0});
}

class AddImageBSInitial extends AddImageBSState {}

class AddImageBSDownloadingCamera extends AddImageBSState {
  AddImageBSDownloadingCamera({double percentDownloaded = 0})
      : super(percentDownloaded: percentDownloaded);
}

class AddImageBSDownloadedCamera extends AddImageBSState {
  AddImageBSDownloadedCamera({double percentDownloaded = 1})
      : super(percentDownloaded: percentDownloaded);
}

class AddImageDownloadCameraError extends AddImageBSState {}
