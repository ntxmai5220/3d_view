import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/pages/room_detail/room_detail.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/app_bar/app_bar_text_title.dart';
import 'package:bk_3d_view/widgets/app_bar/my_app_bar.dart';
import 'package:bk_3d_view/widgets/button/my_button.dart';
import 'package:bk_3d_view/widgets/images/net_image.dart';
import 'package:bk_3d_view/widgets/scroll/custom_scroll.dart';
import 'package:bk_3d_view/widgets/user/choose_item.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  Widget buildDataInfo(String label, dynamic data) => Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$label: ',
                style: TextStyles.normalLabel.copyWith(color: AppColors.black)),
            Expanded(
                child: Wrap(children: [
              Text(
                data.toString(),
                style: TextStyles.normalContent,
              )
            ]))
          ],
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.pageMarginHorizontal, vertical: 10),
      );

  Widget buildRoomItem(List<Img> thumbnails, String name, String roomId) =>
      Builder(
        builder: (context) => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RoomDetail(
                        roomId: roomId,
                      ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NetImage(
                  imageUrl: thumbnails[0].imgUrl ?? "",
                  width: 300,
                  height: 200),
              Text(
                name,
                style: TextStyles.normalContent
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
  Widget buildRoomsCarousel({required List<Room> rooms}) => SizedBox(
        height: 280,
        child: ListView.separated(
          itemBuilder: (context, index) => buildRoomItem(
              rooms[index].thumbnails ?? [],
              rooms[index].name ?? "",
              rooms[index].id ?? ""),
          itemCount: rooms.length,
          physics: const CustomScrollPhysics(itemDimension: 300),
          separatorBuilder: (context, index) => const SizedBox(
            width: 5,
          ),
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget buildViewInPanaroma(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.pageMarginHorizontal),
        child: MyButton(
          "Xem ở chế độ panaroma",
          onClick: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ViewPanorama())),
          bgColor: AppColors.darkPrimary,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          title: const AppBarTextTitle(
        title: '  Thông tin bài đăng',
        color: AppColors.white,
      )),
      // appBar: AppBar(
      //   title: const Text(
      //     "Thông tin bài đăng",
      //   ),
      //   backgroundColor: AppColors.primary,
      // ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        children: [
          buildDataInfo("Giá", postDetail.price.toString() + " triệu"),
          buildDataInfo("Diện tích", postDetail.area.toString() + " m^2"),
          buildDataInfo("Địa chỉ", postDetail.getAddress()),
          buildDataInfo("Mô tả", postDetail.desc),
          buildDataInfo("Tình trạng", postDetail.getPostStatus()),
          buildDataInfo("Người đăng", postDetail.creatorId),
          buildDataInfo("Ngày đăng", postDetail.getCreatedDate()),
          buildRoomsCarousel(rooms: postDetail.rooms!),
          buildViewInPanaroma(context),
        ],
      ),
    );
  }
}
