import 'package:bk_3d_view/panorama/add_hotspot/add_hotspot.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HotSpotView extends StatelessWidget {
  const HotSpotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListRoom(
      onTapItem: (room) => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddHotspot(
                child:
                    Image(image: CachedNetworkImageProvider(room.imgUrl ?? '')),
              ))),
    );
  }
}
