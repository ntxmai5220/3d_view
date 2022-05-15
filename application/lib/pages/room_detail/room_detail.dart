import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/img.dart';
import 'package:bk_3d_view/pages/new_post/view/thumbnail_view/thumbnail_view.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/widgets/images/net_image.dart';
import 'package:bk_3d_view/widgets/user/choose_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomDetail extends StatelessWidget {
  final String roomId;

  const RoomDetail({Key? key, required this.roomId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget buildThumbnail(Img thumbnail) =>  
      NetImage(imageUrl: thumbnail.imgUrl ?? "", width:  300, height: 100);

    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin phòng",),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemBuilder: (context, index) => buildThumbnail(thumbnails[index]),
              itemCount: thumbnails.length,
              separatorBuilder: (context, index) => const SizedBox(width: 4),
              scrollDirection: Axis.horizontal,
          
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppConstants.pageMarginHorizontal, vertical: 8),
            child: ChooseItem("Đặt vật thể", onClick: (){}),
          )
        ],
      ),
    );
  }


}