library panorama;

import 'dart:async';
import 'dart:collection';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Delete/ExtFABDel.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Delete/FABDel.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Fab/ExtFAB.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Fab/FAB.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Hotspot/Hotspot.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Image/DetailImage.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Model/ModalBottomSheet.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/Model/ModalObjectSheet.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/ObjectAdding/ExtObjectFAB.dart';
import 'package:bk_3d_view/panorama/add_object/panaroma/Widgets/ObjectAdding/ObjectFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../add_object/panaroma/flutter_cube/flutter_cube.dart';

import 'package:uuid/uuid.dart';

import '../../add_object/panaroma/Widgets/Hotspot/HotspotButton.dart';

class AddHotspots extends StatefulWidget {
  AddHotspots({
    Key? key,
    this.latitude = 0,
    this.longitude = 0,
    this.zoom = 1.0,
    this.minLatitude = -90.0,
    this.maxLatitude = 90.0,
    this.minLongitude = -180.0,
    this.maxLongitude = 180.0,
    this.minZoom = 1.0,
    this.maxZoom = 5.0,
    this.sensitivity = 1.0,
    this.animSpeed = 0.0,
    this.animReverse = true,
    this.latSegments = 32,
    this.lonSegments = 64,
    this.interactive = true,
    this.croppedArea = const Rect.fromLTWH(0.0, 0.0, 1.0, 1.0),
    this.croppedFullWidth = 1.0,
    this.croppedFullHeight = 1.0,
    this.onViewChanged,
    this.child,
    this.hotspots,
    this.onHotspotChange,
  }) : super(key: key);

  /// The initial latitude, in degrees, between -90 and 90. default to 0 (the vertical center of the image).
  final double latitude;

  /// The initial longitude, in degrees, between -180 and 180. default to 0 (the horizontal center of the image).
  final double longitude;

  /// The initial zoom, default to 1.0.
  final double zoom;

  /// The minimal latitude to show. default to -90.0
  final double minLatitude;

  /// The maximal latitude to show. default to 90.0
  final double maxLatitude;

  /// The minimal longitude to show. default to -180.0
  final double minLongitude;

  /// The maximal longitude to show. default to 180.0
  final double maxLongitude;

  /// The minimal zomm. default to 1.0
  final double minZoom;

  /// The maximal zomm. default to 5.0
  final double maxZoom;

  /// The sensitivity of the gesture. default to 1.0
  final double sensitivity;

  /// The Speed of rotation by animation. default to 0.0
  final double animSpeed;

  /// Reverse rotation when the current longitude reaches the minimal or maximum. default to true
  final bool animReverse;

  /// The number of vertical divisions of the sphere.
  final int latSegments;

  /// The number of horizontal divisions of the sphere.
  final int lonSegments;

  /// Interact with the panorama. default to true
  final bool interactive;

  /// Area of the image was cropped from the full sized photo sphere.
  final Rect croppedArea;

  /// Original full width from which the image was cropped.
  final double croppedFullWidth;

  /// Original full height from which the image was cropped.
  final double croppedFullHeight;

  /// This event will be called when the view direction has changed, it contains latitude and longitude about the current view.
  final Function(double longitude, double latitude, double tilt)? onViewChanged;

  /// Pass hostpot data when changing
  Function(Map<int, List<Hotspot>> listHotspot)? onHotspotChange;

  /// Specify an Image(equirectangular image) widget to the panorama.
  final List<DetailImage>? child;

  /// Place widgets in the panorama.

  final List<Hotspot>? hotspots;

  // final Widget

  @override
  _AddHotspotsState createState() => _AddHotspotsState();
}

class _AddHotspotsState extends State<AddHotspots>
    with SingleTickerProviderStateMixin {
  Scene? sceneObj;
  Scene? scene;
  Object? surface;
  late double latitude;
  late double longitude;
  double latitudeDelta = 0;
  double longitudeDelta = 0;
  double zoomDelta = 0;
  late Offset _lastFocalPoint;
  double? _lastZoom;
  double _radius = 500;
  double _dampingFactor = 0.05;
  double _animateDirection = 1.0;
  double rotateY = 0;
  double rotateX = 0;
  late AnimationController _controller;
  double screenOrientation = 0.0;
  Vector3 orientation = Vector3(0, radians(90), 0);
  StreamSubscription? _orientationSubscription;
  StreamSubscription? _screenOrientSubscription;
  late StreamController<Null> _streamController;
  Stream<Null>? _stream;
  ImageStream? _imageStream;
  double zoom = 1;
  int current_index = 0;
  Map<int, List<Hotspot>> listHotspot = new Map<int, List<Hotspot>>();
  List<Hotspot> hotspots = [];
  Object? currentObj;
  bool isFAB = false;
  // 0 for scroll , 1 for add hostpost, 2 for delete
  int mode = 0;
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool objectToolVisible = false;
  // DelTapFunction
  void _toggleDelMode() {
    setState(() {
      this.mode = this.mode != 2 ? 2 : 0;
    });
  }

  void changePrevObject() {
    int length = sceneObj!.world.children.length;
    if (length == 0) {
      currentObj = null;
      return;
    }
    int currentIndex =
        sceneObj!.world.children.indexWhere((element) => element == currentObj);
    int prevObjIndex = (currentIndex - 1 + length) % length;
    currentObj = sceneObj!.world.children.elementAt(prevObjIndex);
  }

  void onAddingFABCLicked() {
    int mode;
    if (this.mode == 3) {
      mode = 0;
    } else
      mode = 3;
    setState(() {
      objectToolVisible = !objectToolVisible;
      this.mode = mode;
    });
  }

  void changeNextObject() {
    int length = sceneObj!.world.children.length;
    if (length == 0) {
      currentObj = null;
      return;
    }
    int currentIndex =
        sceneObj!.world.children.indexWhere((element) => element == currentObj);
    int nextObjIndex = (currentIndex + 1 + length) % length;

    currentObj = sceneObj!.world.children.elementAt(nextObjIndex);
  }

  void rotateObject(Object obj, {double angleY = 0, double angleX = 0}) {
    Vector3 initialRotation = obj.rotation;
    double x = angleX != 0 ? angleX : initialRotation.x;
    double y = angleY != 0 ? angleY : initialRotation.y;
    obj.rotation.setValues(x, y, 0);
    obj.updateTransform();
  }

  // FabTapFunction
  void _toggleFabMode() {
    setState(() {
      this.mode = this.mode != 1 ? 1 : 0;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    final Vector3 o =
        positionToLatLon(details.localPosition.dx, details.localPosition.dy);
    if (mode == 1) _handleAddHospot(degrees(o.x), degrees(-o.y), degrees(o.z));
  }

  void _handleAddObject(double longitude, double latitude, double tilt) async {
    String? objPath = await ModalObjectSheet(context);
    if (objPath == null) return;
    double trueXdeg = -longitude + math.pi / 2;
    double trueYdeg = latitude;
    double trueZdeg = tilt;
    Object newObj = Object(
      name: objPath,
      fileName: objPath,
      lighting: true,
      normalized: true,
      visiable: true,
      backfaceCulling: false,
      scale: Vector3(2, 2, 2),
      parent: surface,
      position: Vector3(0, 0, 0),
    );
    currentObj = newObj;
    // rotate object position
    moveRight(newObj, trueXdeg);
    moveUp(newObj, trueYdeg);
    sceneObj!.world.add(newObj);
    _updateView();
  }

  void _onHotspotChange() {
    widget.onHotspotChange!(listHotspot);
  }

  void _handleAddHospot(double longitude, double latitude, double tilt) async {
    int? index = await roomSheet(context, widget.child!);
    if (index == null) return;
    String uuid = Uuid().v1();
    Hotspot temp = Hotspot(
      name: uuid,
      latitude: latitude,
      longitude: longitude,
      width: 90,
      height: 75,
      widget: hotspotButton(
          text: widget.child![index].name,
          icon: Icons.open_in_browser,
          onPressed: () {
            switch (mode) {
              // transfer to another scene
              case 0:
                current_index = index;
                if (listHotspot[current_index] == null)
                  listHotspot[current_index] = [];
                hotspots = listHotspot[current_index]!;
                _loadTexture(widget.child![index].getImage().image);
                break;
              case 2:
                Hotspot deltmp = listHotspot[current_index]!
                    .firstWhere((element) => element.name == uuid);
                listHotspot[current_index]!.remove(deltmp);
                _onHotspotChange();
            }

            _updateView();
          }),
    );

    setState(() {
      listHotspot[current_index]!.add(temp);
      _onHotspotChange();
    });
  }

  void changeCorlorObjectRec(Object obj, Color color, int index) {
    obj.light.setColor(color, 2, 2, 20);
    if (obj.children.isEmpty) return;
    for (Object child in obj.children) {
      changeCorlorObjectRec(child, color, index + 1);
    }
  }

  void changeColor(Color color) {
    changeCorlorObjectRec(this.currentObj!, color, 1);
    setState(() => pickerColor = color);
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.localFocalPoint;
    _lastZoom = null;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    final offset = details.localFocalPoint - _lastFocalPoint;
    _lastFocalPoint = details.localFocalPoint;
    latitudeDelta += widget.sensitivity *
        0.5 *
        math.pi *
        offset.dy /
        scene!.camera.viewportHeight;
    longitudeDelta -= widget.sensitivity *
        _animateDirection *
        0.5 *
        math.pi *
        offset.dx /
        scene!.camera.viewportHeight;
    if (_lastZoom == null) {
      _lastZoom = scene!.camera.zoom;
    }
    zoomDelta += _lastZoom! * details.scale - (scene!.camera.zoom + zoomDelta);
    if (!_controller.isAnimating) {
      _controller.reset();
      if (widget.animSpeed != 0) {
        _controller.repeat();
      } else
        _controller.forward();
    }
  }

  void zoomIn(Object obj, double scale) {
    Vector3 currentScale = obj.scale;
    obj.scale.setValues(
        currentScale.x * scale, currentScale.y * scale, currentScale.z * scale);
    obj.updateTransform();
    scene!.update();
  }

  void moveRight(Object obj, double angle) {
    Vector3 axis = new Vector3(0, 1, 0);

    Quaternion q = new Quaternion.axisAngle(axis, angle);
    Vector3 camera_point = scene!.camera.position;

    Vector3 obj_position = obj.position;
    Vector3 point = obj_position - camera_point;
    q.rotate(point);
    point += camera_point;
    obj.position.setFrom(point);
    obj.updateTransform();
    scene!.update();
  }

  void moveUp(Object obj, double angle) {
    Vector3 obj_position = obj.position;
    obj.position.add(Vector3(0, angle, 0));
    obj.updateTransform();
    scene!.update();
  }

  void _updateView() {
    if (scene == null) return;
    if (sceneObj == null) return;

    /// update fab
    if (!isFAB)
      setState(() {
        if (latitude.abs() > 0.05 || longitude.abs() > 0.5) isFAB = true;
      });
    // auto rotate
    longitudeDelta += 0.001 * widget.animSpeed;
    // animate vertical rotating
    latitude += latitudeDelta * _dampingFactor * widget.sensitivity;
    latitudeDelta *= 1 - _dampingFactor * widget.sensitivity;
    // animate horizontal rotating
    longitude += _animateDirection *
        longitudeDelta *
        _dampingFactor *
        widget.sensitivity;
    longitudeDelta *= 1 - _dampingFactor * widget.sensitivity;
    // animate zomming
    final double zoom = scene!.camera.zoom + zoomDelta * _dampingFactor;
    zoomDelta *= 1 - _dampingFactor;
    scene!.camera.zoom = zoom.clamp(widget.minZoom, widget.maxZoom);
    sceneObj!.camera.zoom = zoom.clamp(widget.minZoom, widget.maxZoom);
    // stop animation if not needed
    if (latitudeDelta.abs() < 0.001 &&
        longitudeDelta.abs() < 0.001 &&
        zoomDelta.abs() < 0.001) {
      if (widget.animSpeed == 0 && _controller.isAnimating) _controller.stop();
    }

    // rotate for screen orientation
    Quaternion q = Quaternion.axisAngle(Vector3(0, 0, 1), screenOrientation);
    // rotate for device orientation
    q *= Quaternion.euler(-orientation.z, -orientation.y, -orientation.x);
    // rotate to latitude zero
    q *= Quaternion.axisAngle(Vector3(1, 0, 0), math.pi * 0.5);

    // check and limit the rotation range
    Vector3 o = quaternionToOrientation(q);
    final double minLat = radians(math.max(-89.9, widget.minLatitude));
    final double maxLat = radians(math.min(89.9, widget.maxLatitude));
    final double minLon = radians(widget.minLongitude);
    final double maxLon = radians(widget.maxLongitude);
    final double lat = (-o.y).clamp(minLat, maxLat);
    final double lon = o.x.clamp(minLon, maxLon);
    if (lat + latitude < minLat) latitude = minLat - lat;
    if (lat + latitude > maxLat) latitude = maxLat - lat;
    if (maxLon - minLon < math.pi * 2) {
      if (lon + longitude < minLon || lon + longitude > maxLon) {
        longitude = (lon + longitude < minLon ? minLon : maxLon) - lon;
        // reverse rotation when reaching the boundary
        if (widget.animSpeed != 0) {
          if (widget.animReverse)
            _animateDirection *= -1.0;
          else
            _controller.stop();
        }
      }
    }
    o.x = lon;
    o.y = -lat;
    q = orientationToQuaternion(o);

    // rotate to longitude zero
    q *= Quaternion.axisAngle(Vector3(0, 1, 0), -math.pi * 1);
    // rotate around the global Y axis
    q *= Quaternion.axisAngle(Vector3(0, 1, 0), longitude);
    // rotate around the local X axis
    q = Quaternion.axisAngle(Vector3(1, 0, 0), -latitude) * q;

    o = quaternionToOrientation(
        q * Quaternion.axisAngle(Vector3(0, 1, 0), math.pi * 0.5));
    widget.onViewChanged?.call(degrees(o.x), degrees(-o.y), degrees(o.z));

    q.rotate(scene!.camera.target..setFrom(Vector3(0, 0, -_radius)));
    q.rotate(scene!.camera.up..setFrom(Vector3(0, 1, 0)));
    scene!.update();

    q.rotate(sceneObj!.camera.target..setFrom(Vector3(0, 0, -_radius)));
    q.rotate(sceneObj!.camera.up..setFrom(Vector3(0, 1, 0)));
    sceneObj!.update();

    _streamController.add(null);
  }

  void _updateTexture(ImageInfo imageInfo, bool synchronousCall) {
    surface?.mesh.texture = imageInfo.image;
    surface?.mesh.textureRect = Rect.fromLTWH(0, 0,
        imageInfo.image.width.toDouble(), imageInfo.image.height.toDouble());
    scene!.texture = imageInfo.image;

    scene!.update();
  }

  void _loadTexture(ImageProvider? provider) {
    if (provider == null) return;
    _imageStream?.removeListener(ImageStreamListener(_updateTexture));
    _imageStream = provider.resolve(ImageConfiguration());
    ImageStreamListener listener = ImageStreamListener(_updateTexture);
    _imageStream!.addListener(listener);
  }

  void _onSceneCreated(Scene scene) {
    this.scene = scene;
    if (widget.child != null) {
      final Mesh mesh = generateSphereMesh(
          radius: _radius,
          latSegments: widget.latSegments,
          lonSegments: widget.lonSegments,
          croppedArea: widget.croppedArea,
          croppedFullWidth: widget.croppedFullWidth,
          croppedFullHeight: widget.croppedFullHeight);
      surface = Object(name: 'surface', mesh: mesh, backfaceCulling: false);

      _loadTexture(widget.child![current_index].getImage().image);

      scene.world.add(surface!);
    }
  }

  void _onSceneCreatedObj(Scene scene) {
    this.sceneObj = scene;
    scene.light.position.setFrom(Vector3(0, 0, -10));

    _updateView();
  }

  Matrix4 matrixFromLatLon(double lat, double lon) {
    return Matrix4.rotationY(radians(90.0 - lon))..rotateX(radians(lat));
  }

  Vector3 positionToLatLon(double x, double y) {
    // transform viewport coordinate to NDC, values between -1 and 1
    final Vector4 v = Vector4(2.0 * x / scene!.camera.viewportWidth - 1.0,
        1.0 - 2.0 * y / scene!.camera.viewportHeight, 1.0, 1.0);
    // create projection matrix
    final Matrix4 m =
        scene!.camera.projectionMatrix * scene!.camera.lookAtMatrix;
    // apply inversed projection matrix
    m.invert();
    v.applyMatrix4(m);
    // apply perspective division
    v.scale(1 / v.w);
    // get rotation from two vectors
    final Quaternion q =
        Quaternion.fromTwoVectors(v.xyz, Vector3(0.0, 0.0, -_radius));
    // get euler angles from rotation
    return quaternionToOrientation(
        q * Quaternion.axisAngle(Vector3(0, 1, 0), math.pi * 0.5));
  }

  Vector3 positionFromLatLon(double lat, double lon) {
    // create projection matrix
    final Matrix4 m = scene!.camera.projectionMatrix *
        scene!.camera.lookAtMatrix *
        matrixFromLatLon(lat, lon);
    // apply projection matrix
    final Vector4 v = Vector4(0.0, 0.0, -_radius, 1.0)..applyMatrix4(m);
    // apply perspective division and transform NDC to the viewport coordinate
    return Vector3(
      (1.0 + v.x / v.w) * scene!.camera.viewportWidth / 2,
      (1.0 - v.y / v.w) * scene!.camera.viewportHeight / 2,
      v.z,
    );
  }

  Widget buildHotspotWidgets(List<Hotspot>? hotspots) {
    final List<Widget> widgets = <Widget>[];
    if (hotspots != null && scene != null) {
      for (Hotspot hotspot in hotspots) {
        final Vector3 pos =
            positionFromLatLon(hotspot.latitude, hotspot.longitude);
        final Offset orgin = Offset(hotspot.width * hotspot.orgin.dx,
            hotspot.height * hotspot.orgin.dy);
        final Matrix4 transform = scene!.camera.lookAtMatrix *
            matrixFromLatLon(hotspot.latitude, hotspot.longitude);
        final Widget child = Positioned(
          left: pos.x - orgin.dx,
          top: pos.y - orgin.dy,
          child: Transform(
            origin: orgin,
            transform: transform..invert(),
            child: Offstage(
              offstage: pos.z < 0,
              child: hotspot.widget,
            ),
          ),
        );
        widgets.add(child);
      }
    }
    return Stack(children: widgets);
  }

  @override
  void initState() {
    super.initState();
    latitude = degrees(widget.latitude);
    longitude = degrees(widget.longitude);
    _streamController = StreamController<Null>.broadcast();
    _stream = _streamController.stream;

    if (listHotspot[current_index] == null) listHotspot[current_index] = [];
    this.hotspots = listHotspot[current_index]!;

    _controller = AnimationController(
        duration: Duration(milliseconds: 60000), vsync: this)
      ..addListener(_updateView);
    if (widget.animSpeed != 0) _controller.repeat();
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_updateTexture));
    _orientationSubscription?.cancel();
    _screenOrientSubscription?.cancel();
    _controller.dispose();
    _streamController.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(AddHotspots oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (surface == null) return;
    if (widget.latSegments != oldWidget.latSegments ||
        widget.lonSegments != oldWidget.lonSegments ||
        widget.croppedArea != oldWidget.croppedArea ||
        widget.croppedFullWidth != oldWidget.croppedFullWidth ||
        widget.croppedFullHeight != oldWidget.croppedFullHeight) {
      surface!.mesh = generateSphereMesh(
          radius: _radius,
          latSegments: widget.latSegments,
          lonSegments: widget.lonSegments,
          croppedArea: widget.croppedArea,
          croppedFullWidth: widget.croppedFullWidth,
          croppedFullHeight: widget.croppedFullHeight);
    }
    if (widget.child![current_index].getImage().image !=
        oldWidget.child![current_index].getImage().image) {
      _loadTexture(widget.child![current_index].getImage().image);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget pano = Stack(
      children: [
        Cube(interactive: false, onSceneCreated: _onSceneCreated),
        Cube(interactive: false, onSceneCreated: _onSceneCreatedObj),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              isFAB
                  ? buildDel(_toggleDelMode, mode)
                  : buildExtendedDel(_toggleDelMode, mode),
              SizedBox(
                height: 20,
              ),
              isFAB
                  ? buildFAB(_toggleFabMode, mode)
                  : buildExtendedFAB(_toggleFabMode, mode),
            ],
          ),
        ),
        StreamBuilder(
          stream: _stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return buildHotspotWidgets(hotspots);
          },
        )
      ],
    );

    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onTapUp: _handleTapUp,
      child: pano,
    );
  }
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
