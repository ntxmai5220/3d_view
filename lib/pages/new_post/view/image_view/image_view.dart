import 'dart:io';

import 'package:bk_3d_view/bottom_sheets/add_image_bottom_sheet.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/bloc/image_view_bloc.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    XFile? _image;

    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ImageViewBloc, ImageViewState>(
      builder: (context, state) {
        ImageViewBloc bloc = context.read<ImageViewBloc>();
        Widget itemBuilder(BuildContext context, int index) => Container(
              height: size.width / 2,
              // color: Colors.amber[index * 100],
              child: Text(bloc.state.rooms.elementAt(index).img ?? '$index'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(
                    File(bloc.state.rooms.elementAt(index).img ?? ''),
                  ),
                ),
              ),
            );

        return ListView(
          padding: const EdgeInsets.all(AppConstants.pageMarginHorizontal),
          children: [
            const Text(
              'Step 2',
              style: AppStyles.screenTitle,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  String? path = await showBottomSheet(context);
                  if (path != null) {
                    bloc.add(ImageViewAddEvent(path: path));
                  }
                },
                child: DottedBorder(
                  color: AppColors.secondary,
                  dashPattern: const [5, 2],
                  strokeWidth: 0.8,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(AppConstants.borderRadius),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_circle_rounded,
                        color: AppColors.darkSecondary,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Thêm',
                        style: AppStyles.normalContent,
                      )
                    ],
                  )),
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.rooms.length,
                itemBuilder: itemBuilder)
          ],
        );
      },
    );
  }

  pickImage(BuildContext context, {required ImageSource source}) async {
    try {
      var image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        Navigator.pop(context, image.path);
      }
      // debugPrint(image.path);

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String?> showBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddImageBottomSheet(
          tapToTakePhoto: () async {
            debugPrint('take');
            pickImage(context, source: ImageSource.camera);
          },
          tapToUploadPhoto: () {
            debugPrint('load');

            pickImage(context, source: ImageSource.gallery);
          },
        );
      },
    );
  }
}
