import 'package:flutter/material.dart';

class Hotspot {
  Hotspot({
    required this.name,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.width = 60.0,
    this.height = 85.0,
    required this.type,
    VoidCallback? onTap,
    this.content,
  }) : widget = HotspotBtn(
          title: name,
          icon: type.getChild,
          onPressed: onTap,
        );

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
        SizedBox(
          height: 40,
          width: 40,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Icon(icon),
            onPressed: onPressed,
          ),
        ),
        title != null
            ? Container(
                margin: EdgeInsets.only(top: 3),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Center(
                  child: Text(title ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: title!.length >= 13 ? 11 : 16)),
                ))
            : Container(
                height: 5,
                color: Colors.black,
              ),
      ],
    );
  }
}
