import 'package:flutter/material.dart';

import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:panorama/flutter_cube/flutter_cube.dart';

enum SensorControl {
  /// No sensor used.
  None,

  /// Use gyroscope and accelerometer.
  Orientation,

  /// Use magnetometer and accelerometer. The logitude 0 points to north.
  AbsoluteOrientation,
}

Mesh generateSphereMesh(
    {num radius = 1.0,
    int latSegments = 16,
    int lonSegments = 16,
    ui.Image? texture,
    Rect croppedArea = const Rect.fromLTWH(0.0, 0.0, 1.0, 1.0),
    double croppedFullWidth = 1.0,
    double croppedFullHeight = 1.0}) {
  int count = (latSegments + 1) * (lonSegments + 1);
  List<Vector3> vertices = List<Vector3>.filled(count, Vector3.zero());
  List<Offset> texcoords = List<Offset>.filled(count, Offset.zero);
  List<Polygon> indices =
      List<Polygon>.filled(latSegments * lonSegments * 2, Polygon(0, 0, 0));

  int i = 0;
  for (int y = 0; y <= latSegments; ++y) {
    final double tv = y / latSegments;
    final double v =
        (croppedArea.top + croppedArea.height * tv) / croppedFullHeight;
    final double sv = math.sin(v * math.pi);
    final double cv = math.cos(v * math.pi);
    for (int x = 0; x <= lonSegments; ++x) {
      final double tu = x / lonSegments;
      final double u =
          (croppedArea.left + croppedArea.width * tu) / croppedFullWidth;
      vertices[i] = Vector3(radius * math.cos(u * math.pi * 2.0) * sv,
          radius * cv, radius * math.sin(u * math.pi * 2.0) * sv);
      texcoords[i] = Offset(tu, 1.0 - tv);
      i++;
    }
  }

  i = 0;
  for (int y = 0; y < latSegments; ++y) {
    final int base1 = (lonSegments + 1) * y;
    final int base2 = (lonSegments + 1) * (y + 1);
    for (int x = 0; x < lonSegments; ++x) {
      indices[i++] = Polygon(base1 + x, base1 + x + 1, base2 + x);
      indices[i++] = Polygon(base1 + x + 1, base2 + x + 1, base2 + x);
    }
  }

  final Mesh mesh = Mesh(
      vertices: vertices,
      texcoords: texcoords,
      indices: indices,
      texture: texture);
  return mesh;
}

Vector3 quaternionToOrientation(Quaternion q) {
  // final Matrix4 m = Matrix4.compose(Vector3.zero(), q, Vector3.all(1.0));
  // final Vector v = motionSensors.getOrientation(m);
  // return Vector3(v.z, v.y, v.x);
  final storage = q.storage;
  final double x = storage[0];
  final double y = storage[1];
  final double z = storage[2];
  final double w = storage[3];
  final double roll =
      math.atan2(-2 * (x * y - w * z), 1.0 - 2 * (x * x + z * z));
  final double pitch = math.asin(2 * (y * z + w * x));
  final double yaw =
      math.atan2(-2 * (x * z - w * y), 1.0 - 2 * (x * x + y * y));
  return Vector3(yaw, pitch, roll);
}

Quaternion orientationToQuaternion(Vector3 v) {
  final Matrix4 m = Matrix4.identity();
  m.rotateZ(v.z);
  m.rotateX(v.y);
  m.rotateY(v.x);
  return Quaternion.fromRotation(m.getRotation());
}
