import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/img.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/app_bar/back_leading.dart';
import 'package:bk_3d_view/widgets/button/my_button.dart';
import 'package:bk_3d_view/widgets/images/net_image.dart';
import 'package:bk_3d_view/widgets/user/choose_item.dart';
import 'package:flutter/material.dart';

class RoomDetail extends StatelessWidget {
  final String roomId;

  const RoomDetail({Key? key, required this.roomId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildThumbnail(Img thumbnail) =>
        NetImage(imageUrl: thumbnail.imgUrl ?? "", width: 380, height: 100);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Phòng 0",
        ),
        backgroundColor: AppColors.primary,
        leading: BackLeading(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Danh sách thumbnails',
              style: TextStyles.buttonText.copyWith(
                color: AppColors.darkSecondary,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  buildThumbnail(Img.fromJson(thumbnailss[index])),
              itemCount: thumbnailss.length,
              separatorBuilder: (context, index) => const SizedBox(width: 4),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.pageMarginHorizontal, vertical: 8),
            child: MyButton(
              'Đặt vật thể',
              onClick: () {},
              bgColor: AppColors.primary,
            ),
          )
        ],
      ),
    );
  }
}
