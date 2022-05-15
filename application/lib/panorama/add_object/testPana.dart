import 'package:bk_3d_view/panorama/add_object/panaroma/AddObject.dart';
import 'package:flutter/material.dart';
import 'package:panorama/module.dart';

import 'panaroma/Widgets/Image/DetailImage.dart';

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
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Panaroma app"),
        ),
        body: panaroma);
  }
}
