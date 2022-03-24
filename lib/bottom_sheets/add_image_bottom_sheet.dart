import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddImageBottomSheet extends StatelessWidget {
  const AddImageBottomSheet(
      {Key? key, this.tapToTakePhoto, this.tapToUploadPhoto})
      : super(key: key);

  final VoidCallback? tapToTakePhoto;
  final VoidCallback? tapToUploadPhoto;
  @override
  Widget build(BuildContext context) {
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
                  onTap: tapToTakePhoto,
                  child: item(icon: Icons.camera_rounded, text: 'Chụp ảnh')),
              GestureDetector(
                onTap: tapToUploadPhoto,
                child: item(
                    icon: Icons.drive_folder_upload_rounded,
                    text: 'Tải ảnh lên'),
              ),
            ],
          ),
          const SizedBox(height: 55)
        ],
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
            style: AppStyles.tinyLabel,
          )
        ],
      );
}
