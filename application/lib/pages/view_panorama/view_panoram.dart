import 'package:bk_3d_view/bottom_sheets/bottom_sheets.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:panorama/hotspot.dart/hotspot.dart';
import 'package:panorama/panorama.dart';

class ViewPanorama extends StatelessWidget {
  const ViewPanorama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var type = HotspotType.values;

    List<HotspotModel> lists = [
      HotspotModel(
          title: 'Tranh treo tường ',
          latitude: 11,
          longitude: -17,
          type: 1,
          content: 'Bo 6 tranh treo tường 2 triệu đồng'),
      HotspotModel(
        title: 'Phòng 1',
        latitude: 4,
        longitude: 17,
        type: 0,
      )
    ];
    var rooms = [
      {
        "_id": "62819e31ecb26147eaea244e",
        "name": "Phòng khách",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652661805/Thesis/62819e2aecb26147eaea244a/oxmv9tjtrt0chbaepqex.jpg"
      },
      {
        "_id": "62819e31ecb26147eaea2450",
        "name": "Phòng 1",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652661807/Thesis/62819e2aecb26147eaea244a/agzcmvwjcfgrfkoxfjyo.jpg"
      },
      {
        "_id": "62819e31ecb26147eaea2452",
        "name": "Phòng 3",
        "imgUrl":
            "http://res.cloudinary.com/dtnam302/image/upload/v1652661809/Thesis/62819e2aecb26147eaea244a/gngxmyfzckrwlckr2lsi.jpg"
      }
    ];
    List<Room> listRoom = rooms.map((e) => Room.fromJson(e)).toList();
    listRoom.removeAt(0);
    List<Hotspot> list = lists
        .map((item) => Hotspot(
              name: item.title,
              type: type[item.type ?? 0],
              latitude: item.latitude!,
              longitude: item.longitude!,
              content: item.content,
            ))
        .toList();
    return Scaffold(
      appBar: MyAppBar(
        title: AppBarTextTitle(
          title: rooms[0]['name'] ?? '',
          color: AppColors.white,
        ),
        actions: [
          IconActionButton(
            icon: Icons.change_circle_rounded,
            iconColor: AppColors.white,
            padding: 8,
            onTap: () => ShowBottomSheet.showBS(context,
                child: ChooseRoomBS(
                  rooms: listRoom,
                )),
          )
        ],
      ),
      body: Panorama(
          child: Image(
              image: CachedNetworkImageProvider(rooms[0]['imgUrl'] ?? '')),
          hotspots: []

          // lists
          //     .map((item) => Hotspot(
          //         name: item.title,
          //         type: type[item.type ?? 0],
          //         latitude: item.latitude!,
          //         longitude: item.longitude!,
          //         content: item.content,
          //         onTap: () {
          //           if (type[item.type ?? 0] == HotspotType.infor) {
          //             ShowMyDialog.show(context,
          //                 dialog: InforDialog(
          //                   content: item.content!,
          //                 ));
          //           } else {}
          //         }))
          //     .toList(),
          ),
    );
  }
}
