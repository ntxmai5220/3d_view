import 'package:bk_3d_view/bottom_sheets/bottom_sheets.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/bloc/image_view_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/widgets/edit_image_dialog.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/widgets/image_item.dart';

import 'package:bk_3d_view/values/values.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    ImageViewBloc bloc = context.read<ImageViewBloc>();
    Widget itemBuilder(BuildContext context, int index) => ImageItem(
          room: bloc.state.rooms.elementAt(index),
          onDeleteImage: (id) => bloc.add(ImageViewDeleteImageEvent(id: id)),
          onRenameImage: (id) => showRenameDialog(context,
              room: bloc.state.rooms.elementAt(index)),
        );
    return BlocBuilder<ImageViewBloc, ImageViewState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(AppConstants.pageMarginHorizontal / 1.5),
            child: Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 48,
                      child: GestureDetector(
                        onTap: () async {
                          String? path = await showAddImageOptionsBS(context);
                          if (path != null) {
                            bloc.add(ImageViewAddImageEvent(path: path));
                          }
                        },
                        child: DottedBorder(
                          color: AppColors.secondary,
                          dashPattern: const [5, 2],
                          strokeWidth: 0.9,
                          borderType: BorderType.RRect,
                          radius:
                              const Radius.circular(AppConstants.borderRadius),
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
                                style: TextStyles.normalContent,
                              )
                            ],
                          )),
                        ),
                      ),
                    ),

                    // ListView.separated(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: state.rooms.length,
                    //   itemBuilder: itemBuilder,
                    //   separatorBuilder: (context, index) => const SizedBox(height: 15),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 75),
                  child: Wrap(
                      // alignment: WrapAlignment.center,
                      runSpacing: 15,
                      spacing: 15,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: state.rooms
                          .map((e) =>
                              itemBuilder(context, state.rooms.indexOf(e)))
                          .toList()),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> showAddImageOptionsBS(BuildContext context) =>
      ShowBottomSheet.showBS(context);

  showRenameDialog(BuildContext context, {required Room room}) async {
    String? newName = await showDialog(
        context: context,
        builder: (context) => EditImageDialog(
              name: room.name,
            ));
    if (newName != null) {
      context
          .read<ImageViewBloc>()
          .add(ImageViewRenameImageEvent(id: room.id, name: newName));
    }
  }
}
