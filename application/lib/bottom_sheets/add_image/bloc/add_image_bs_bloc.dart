import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'add_image_bs_event.dart';
part 'add_image_bs_state.dart';

class AddImageBSBloc extends Bloc<AddImageBSEvent, AddImageBSState> {
  final NewPostRepository _repository = NewPostRepository();
  AddImageBSBloc() : super(AddImageBSInitial()) {
    on<AddImageBSDownloadCameraEvent>(downloadCamera);
  }
  downloadCamera(AddImageBSDownloadCameraEvent event,
      Emitter<AddImageBSState> emit) async {
    emit(AddImageBSDownloadingCamera());

    // String url =
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png';

    // String  savePath = ''

    try {
      await _repository.downloadCamera(
          urlPath: AppConstants.cameraUrl,
          savePath: event.savePath,
          onReceivedData: (int progress, int total) {
            // var currentState = state;
            double percent = (progress / total);

            if (state is AddImageBSDownloadingCamera &&
                percent != state.percentDownloaded) {
              state.percentDownloaded = percent;
              emit(AddImageBSDownloadingCamera(percentDownloaded: percent));
            }
          });
      emit(AddImageBSDownloadedCamera());
    } catch ( e) {
      debugPrint(e.toString());
    }
  }

  updatePercent() {}
}
