import 'dart:io';

import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

enum ImageActionType { rename, delete }

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key? key,
    required this.room,
    this.onDeleteImage,
    this.onRenameImage,
  }) : super(key: key);

  // final String? imgUrl;
  // final String? name;
  final Room room;
  final Function(String?)? onDeleteImage;
  final Function(String?)? onRenameImage;
  @override
  Widget build(BuildContext context) {
    String? roomName = room.name ?? room.id;
    return SizedBox(
      width: 380,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: AppColors.lightSecondary45,
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'Phòng $roomName',
                        style: TextStyles.normalContent
                            .copyWith(color: AppColors.darkSecondary),
                      ),
                    ),
                    PopupMenuButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(
                        Icons.more_vert,
                        size: 18,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius / 2)),
                      offset: const Offset(-30, 30),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            height: 30,
                            value: ImageActionType.rename,
                            child: Text(
                              'Đổi tên',
                              style: TextStyles.tinyContent,
                            ),
                          ),
                          PopupMenuItem(
                            height: 30,
                            value: ImageActionType.delete,
                            child: Text(
                              'Xóa',
                              style: TextStyles.tinyContent
                                  .copyWith(color: AppColors.red),
                            ),
                          )
                        ];
                      },
                      onSelected: (ImageActionType action) {
                        debugPrint(action.toString());
                        switch (action) {
                          case ImageActionType.delete:
                            onDeleteImage?.call(room.id);
                            break;
                          case ImageActionType.rename:
                            onRenameImage?.call(room.id);
                            break;
                        }
                      },
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: AppColors.lightPrimary,
              ),
              Container(
                height: 250,
                // color: Colors.amber[index * 100],
                child: Text(room.imgUrl ?? ''),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(room.imgUrl ?? ''),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
