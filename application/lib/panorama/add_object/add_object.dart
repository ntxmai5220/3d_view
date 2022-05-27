import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/add_object.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/widgets/app_bar/app_bar_text_title.dart';
import 'package:bk_3d_view/widgets/app_bar/back_leading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class AddObjectPage extends StatelessWidget {
  const AddObjectPage({
    Key? key,
    required this.room,
  }) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AppBarTextTitle(title: room.name??''),
          leading: BackLeading(
            color: AppColors.primary,
          ),
        ),
        body: AddObject(child: Image(image: CachedNetworkImageProvider(room.imgUrl??'')),));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     List<DetailImage> panoImages = [
//       DetailImage(name: "phòng khách", imageLink: "assets/images/photo.jpg"),
//       DetailImage(name: "phòng ngủ", imageLink: "assets/images/room.jpg"),
//     ];
//     Widget panaroma = AddObject(
//       // child: panoImages,
//     );
//     return Scaffold(
//         appBar: AppBar(
//           title: AppBarTextTitle(title: widget.title),
//           leading: BackLeading(
//             color: AppColors.primary,
//           ),
//         ),
//         body: panaroma);
//   }
// }
