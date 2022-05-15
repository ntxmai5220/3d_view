import 'package:flutter/material.dart';

class Hotspot {
  Hotspot({
    required this.name,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.width = 32.0,
    this.height = 32.0,
    required this.type,
    required VoidCallback onTap,
    this.content,
  }) : widget = HotspotBtn(icon: type.getChild, onPressed: onTap,);

  /// The name of this hotspot.
  String? name;

  /// The initial latitude, in degrees, between -90 and 90.
  final double latitude;

  /// The initial longitude, in degrees, between -180 and 180.
  final double longitude;

  /// The local orgin of this hotspot. Default is Offset(0.5, 0.5).
  final Offset orgin = Offset(0.5, 0.5);

  // The width of widget. Default is 32.0
  double width;

  // The height of widget. Default is 32.0
  double height;

  Widget widget;

  HotspotType type;

  String? content;
}

enum HotspotType {
  changeRoom,
  infor,
}

extension HotspotTypeExtension on HotspotType {
  IconData get getChild {
    switch (this) {
      case HotspotType.changeRoom:
        return Icons.open_in_browser_rounded;
      case HotspotType.infor:
        return Icons.info_outline_rounded;
    }
  }
}

class HotspotBtn extends StatelessWidget {
  const HotspotBtn({
    Key? key,
    this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final String? title;
  final IconData icon;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            backgroundColor: MaterialStateProperty.all(Colors.black38),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Icon(icon),
          onPressed: onPressed,
        ),
        title != null
            ? Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(child: Text(title ?? '')),
              )
            : Container(),
      ],
    );
  }
}

Widget hotspotButton({String? text, IconData? icon, VoidCallback? onPressed}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(CircleBorder()),
          backgroundColor: MaterialStateProperty.all(Colors.black38),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Icon(icon),
        onPressed: onPressed,
      ),
      text != null
          ? Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Center(child: Text(text)),
            )
          : Container(),
    ],
  );
}
