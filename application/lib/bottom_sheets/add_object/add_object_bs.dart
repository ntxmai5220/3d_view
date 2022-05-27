import 'package:bk_3d_view/bottom_sheets/bottom_sheets.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

List<String> objectImagePath = [
  "assets/objects/chair/chair.jpg",
  "assets/objects/table/table.jpg",
  "assets/objects/shelf/Shelving_origin.jpg",
  "assets/objects/bed/Bed_Pic.JPG",
  "assets/objects/frame/frame.jpg",
  "assets/objects/smallLocker/smallLocker.jpg"
];
List<String> objectPath = [
  "assets/objects/chair/chair.obj",
  "assets/objects/table/table.obj",
  "assets/objects/shelf/Shelving_origin.obj",
  "assets/objects/bed/Bed.obj",
  "assets/objects/frame/frame.obj",
  "assets/objects/smallLocker/smallLocker.obj"
];
List<String> objectNames = [
  "Ghế tựa",
  "Bàn làm việc",
  "Kệ sách",
  "Giường ngủ",
  "Gương",
  "Tủ nhỏ"
];

String convertImageObjtoObjPath(String imageObj) {
  int imageIndex = objectPath.indexOf(imageObj);

  return objectPath[imageIndex];
}

Future<String?> modalObjectSheet(context) async {
  itemBuilder(context, {required int index}) => ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        onTap: () {
          Navigator.pop(context, objectPath[index]);
        },
        leading: SizedBox(
            width: 75,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                objectImagePath[index],
                fit: BoxFit.cover,
              ),
            )),
        title: Text(
          objectNames[index],
          style: TextStyles.normalLabel.copyWith(color: AppColors.black),
        ),
      );
  return await ShowBottomSheet.showBS(context,
      child: BottomSheetWrap(
        child: Column(
          children: [
            const BottomSheetBar(
              title: 'Chọn vật thể',
            ),
            const SizedBox(height: 10),
            // ...rooms?.map((room) => itemBuilder(context, room)) ?? [],
            ...objectNames.map((name) =>
                itemBuilder(context, index: objectNames.indexOf(name))),
            const SizedBox(height: 10),
          ],
        ),
      ));
}
