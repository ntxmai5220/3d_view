
import 'package:flutter/cupertino.dart';

class Hotspot {
  Hotspot({
    this.name,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.orgin = const Offset(0.5, 0.5),
    this.width = 32.0,
    this.height = 32.0,
    this.widget,
  });

  /// The name of this hotspot.
  String? name;

  /// The initial latitude, in degrees, between -90 and 90.
  final double latitude;

  /// The initial longitude, in degrees, between -180 and 180.
  final double longitude;

  /// The local orgin of this hotspot. Default is Offset(0.5, 0.5).
  final Offset orgin;

  // The width of widget. Default is 32.0
  double width;

  // The height of widget. Default is 32.0
  double height;

  Widget? widget;
  Map<String, dynamic> mapAttributeToMap() {
    return {"name": name, "latitude": latitude, "longitude": longitude};
  }
}