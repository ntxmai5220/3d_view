import 'dart:io';

import 'package:bk_3d_view/bottom_sheets/add_image/bloc/add_image_bs_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/widgets/camera_dialog.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddImageBS extends StatelessWidget {
  const AddImageBS({Key? key, this.tapToTakePhoto, this.tapToUploadPhoto})
      : super(key: key);

  final VoidCallback? tapToTakePhoto;
  final VoidCallback? tapToUploadPhoto;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddImageBSBloc(),
      child: BlocConsumer<AddImageBSBloc, AddImageBSState>(
        listener: (context, state) {
          if (state is AddImageBSDownloadingCamera) {}
        },
        builder: (context, state) {
          return BottomSheetWrap(
            child: Column(
              children: [
                const BottomSheetBar(
                  title: 'Thêm ảnh',
                ),
                const SizedBox(height: 25),
                //main content
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () async => openCamera(context),
                        // onTap: tapToTakePhoto,
                        child: item(
                            icon: Icons.camera_rounded, text: 'Chụp ảnh')),
                    GestureDetector(
                      onTap: () async =>
                          pickImage(context, source: ImageSource.gallery),
                      // onTap: tapToUploadPhoto,
                      child: item(
                          icon: Icons.drive_folder_upload_rounded,
                          text: 'Tải ảnh lên'),
                    ),
                  ],
                ),
                const SizedBox(height: 55),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget item({double? iconSize, String? text, required IconData icon}) =>
      Column(
        children: [
          SizedBox.square(
            dimension: 55,
            child: CircleAvatar(
              backgroundColor: AppColors.lightSecondary45,
              child: Icon(
                icon,
                color: AppColors.darkPrimary,
                size: iconSize ?? 28,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            text ?? '',
            style: TextStyles.tinyLabel,
          )
        ],
      );

  pickImage(BuildContext context, {required ImageSource source}) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        Navigator.pop(context, image.path);
      } else {
        //snackbar to notify add image failed
      }
      debugPrint(image?.path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  openCamera(BuildContext context) {
    if (Platform.isAndroid) {
      openByAndroid(context);
    } else {
      pickImage(context, source: ImageSource.camera);
    }
  }

  openByAndroid(BuildContext context) async {
    //check if GG-cam has been installed

    bool isInstalled = await LaunchApp.isAppInstalled(
        androidPackageName: AppConstants.cameraPackage);

    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      // Permission.camera,
      //add more permission to request here.
    ].request();

    if (isInstalled) {
      openCameraPackage(context);
    } else {
      Directory dir = await getApplicationSupportDirectory();

      String savePath = '${dir.path}/${AppConstants.cameraName}';

      //open GG-cam apk
      final result = await OpenFile.open(savePath);
      debugPrint(result.type.toString());
      //open GG-cam fail + file not found => download GG-cam
      if (result.type == ResultType.fileNotFound) {
        bool download = await confirmToDownload(context);
        if (download && statuses[Permission.storage]!.isGranted) {
          var bloc = context.read<AddImageBSBloc>();
          bloc.add(AddImageBSDownloadCameraEvent(savePath: savePath));
          bool isSuccess = await downloading(context, bloc);
          if (isSuccess) {
            // await OpenFile.open(savePath);
            openCameraPackage(context);
          }
        } else {
          pickImage(context, source: ImageSource.camera);
        }
      } else if (result.type == ResultType.done) {
        //opened GG-cam

      } else {
        //snackbar notify 'having error, try later or take from origin camera'
        //show dialog
      }

      // if (_result.type == ResultType.fileNotFound) {}
    }
  }

  Future confirmToDownload(BuildContext context) =>
      showDialog(context: context, builder: (context) => const CameraDialog());

  uploadImage(BuildContext context) => showDialog(
      context: context, builder: (context) => const PickImageDialog());

  Future downloading(BuildContext context, AddImageBSBloc bloc) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => bloc,
          child: BlocBuilder<AddImageBSBloc, AddImageBSState>(
            builder: (context, state) {
              return DownloadDialog(
                  title: state.percentDownloaded == 1
                      ? 'Đã tải xong'
                      : 'Đang tải...',
                  percent: state.percentDownloaded);
            },
          ),
        );
      });

  openCameraPackage(BuildContext context) async {
    int openStatus = await LaunchApp.openApp(
        androidPackageName: AppConstants.cameraPackage,
        openStore: false); //open to take photo

    if (openStatus == 0) {
      //notify open failed <> GG-cam is installed
    } else if (openStatus == 1) {
      await Future.delayed(const Duration(seconds: 2));
      uploadImage(context);
    }
  }
}
