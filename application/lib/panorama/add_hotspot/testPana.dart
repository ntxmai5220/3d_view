

import 'package:bk_3d_view/panorama/add_hotspot/panaroma/AddObject.dart';
import 'package:bk_3d_view/panorama/add_hotspot/panaroma/Widgets/Hotspot/Hotspot.dart';
import 'package:bk_3d_view/panorama/add_hotspot/panaroma/Widgets/Image/DetailImage.dart';
import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    List<DetailImage> panoImages = [
      DetailImage(name: "phòng khách", imageLink: "assets/images/photo.jpg"),
      DetailImage(name: "phòng ngủ", imageLink: "assets/images/room.jpg"),

    ];
    Widget panaroma = AddObject(
      child: panoImages,
      onHotspotChange: (Map<int, List<Hotspot>> hotpost){
        print(hotpost);
      },
      
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Panaroma app"),
      ),
      body: panaroma 
    );
  }
}
