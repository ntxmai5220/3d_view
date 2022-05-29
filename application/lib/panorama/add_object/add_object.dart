import 'dart:async';

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:bk_3d_view/bottom_sheets/bottom_sheets.dart';
import 'package:bk_3d_view/panorama/add_object/widgets/ext_object_fab.dart';
import 'package:bk_3d_view/panorama/add_object/widgets/object_fab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:panorama/module.dart';


class AddObject extends StatefulWidget {
  const AddObject({
    Key? key,
    this.latitude = 0,
    this.longitude = 0,
    this.zoom = 1.0,
    this.minLatitude = -90.0,
    this.maxLatitude = 90.0,
    this.minLongitude = -180.0,
    this.maxLongitude = 180.0,
    this.minZoom = 0.6,
    this.maxZoom = 3.0,
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

  /// Specify an Image(equirectangular image) widget to the panorama.

  final Image? child;

  /// Place widgets in the panorama.

  final List<Hotspot>? hotspots;

  // final Widget

  @override
  _AddObjectState createState() => _AddObjectState();
}

class _AddObjectState extends State<AddObject>
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
  double _dampingFactor = 0.1;
  double _animateDirection = 1.0;
  double rotateY = 0;
  double rotateX = 0;
  late AnimationController _controller;
  double screenOrientation = 0.0;
  Vector3 orientation = Vector3(0, radians(90), 0);
  StreamSubscription? _orientationSubscription;
  StreamSubscription? _screenOrientSubscription;
  late StreamController<void> _streamController;

  ImageStream? _imageStream;
  double zoom = 1;

  List<Hotspot> hotspots = [];
  Object? currentObj;
  bool isFAB = false;
  // 0 for scroll , 1 for add hostpost, 2 for delete
  int mode = 0;
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  bool objectToolVisible = false;
  // DelTapFunction

  //Object scale
  double lastObjectScale=0;

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
    setCurrentColor(currentObj!.light.color);
  }

  void onAddingFABCLicked() {
    int mode;
    if (this.mode == 3) {
      mode = 0;
    } else {
      mode = 3;
    }
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
    setCurrentColor(currentObj!.light.color);
  }

  void rotateObject(Object obj, {double angleY = 0, double angleX = 0}) {
    Vector3 initialRotation = obj.rotation;
    double x = angleX != 0 ? angleX : initialRotation.x;
    double y = angleY != 0 ? angleY : initialRotation.y;
    obj.rotation.setValues(x, y, 0);
    obj.updateTransform();
  }

  void _handleTapUp(TapUpDetails details) {
    final Vector3 o =
        positionToLatLon(details.localPosition.dx, details.localPosition.dy);

    if (mode == 3) _handleAddObject(-o.x, -o.y, o.z);
  }

  void _handleAddObject(double longitude, double latitude, double tilt) async {
    
    String? objPath = await modalObjectSheet(context);
    if (objPath == null) return;
    double trueXdeg = -longitude + math.pi / 2;

    Object newObj = Object(
      name: objPath,
      fileName: objPath,
      lighting: true,
      normalized: true,
      visiable: true,
      backfaceCulling: false,
      scale: Vector3(6, 6, 6),
      parent: surface,
      position: Vector3(0, math.tan(latitude)*10, 0),
    );
    currentObj = newObj;
    // rotate object position
    moveRight(newObj, trueXdeg);
    sceneObj!.world.add(newObj);
    _updateView();
    setCurrentColor(currentObj!.light.color);
  }

  void changeCorlorObjectRec(Object obj, Color color) {
    obj.light.setColor(color, 1, 2, 2);
    obj.light.position.setFrom(Vector3(0, 0, -10));
    if (obj.children.isEmpty) return;
    for (Object child in obj.children) {
      changeCorlorObjectRec(child, color);
    }
  }

  void changeColor(Color color) {
    changeCorlorObjectRec(currentObj!, color);
    setColorPicker(color);
  }

  void setColorPicker(Color color) {
    setState(() => pickerColor = color);
  }

  void setCurrentColor(Color color) {
    setState(() => currentColor = color);
  }

  Vector3 calculateTouchPosition(Vector3 location){
    double coordinate_y = math.tan(-location.y)*10;
    double trueXdeg = location.x+ math.pi / 2;
    return moveRightVector(Vector3(0,coordinate_y,0),trueXdeg);
  }

  bool isCanZoom(Vector3 touchPosition, Object object){
    if (!objectToolVisible) return false;
    Vector3 objectPostion = object.position;
    double distanceDelta = math.sqrt(math.pow(touchPosition.x-objectPostion.x,2)+ math.pow(touchPosition.y-objectPostion.y,2));
    return distanceDelta < 0.5*object.scale.x*(zoom-0.2);
  }

  void _handleScaleObjectUpdate(ScaleUpdateDetails details){
    
    final Vector3 location = positionToLatLon(details.localFocalPoint.dx, details.localFocalPoint.dy);
    
    if (currentObj != null) {
      if (!isCanZoom(calculateTouchPosition(location), currentObj!)) return  _handleScaleUpdate(details);

      if (details.scale != 1) {
        if (details.scale - lastObjectScale > 0) {
          zoomIn(currentObj!, 1.01);
        } else {
          zoomIn(currentObj!, 0.99);
        }
      }
      lastObjectScale = details.scale;
    } else {
      _handleScaleUpdate(details);
    }

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
    _lastZoom ??= scene!.camera.zoom;
    zoomDelta += _lastZoom! * details.scale - (scene!.camera.zoom + zoomDelta);
    if (!_controller.isAnimating) {
      _controller.reset();
      if (widget.animSpeed != 0) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  void zoomIn(Object obj, double scale) {
    Vector3 currentScale = obj.scale;

    double minScale = 2;
    double scale_x  =currentScale.x * scale;
    double scale_y = currentScale.y * scale;
    double scale_z = currentScale.z * scale;
    
    obj.scale.setValues(
        scale_x < minScale ? minScale : scale_x, 
        scale_y < minScale ? minScale: scale_y,  
        scale_z < minScale ? minScale: scale_z);
    obj.updateTransform();
    scene!.update();
  }

  Vector3 moveRightVector(Vector3 vector, double angle){
    Vector3 axis = Vector3(0, 1, 0);

    Quaternion q = Quaternion.axisAngle(axis, angle);
    Vector3 cameraPoint = scene!.camera.position;

    Vector3 objPosition = vector;
    Vector3 point = objPosition - cameraPoint;
    q.rotate(point);
    point += cameraPoint;
    return point;
  }

  void moveRight(Object obj, double angle) {
    Vector3 objPosition = obj.position;
    obj.position.setFrom(moveRightVector(objPosition, angle));
    obj.updateTransform();
    scene!.update();
  }

  void moveUp(Object obj, double angle) {
    Vector3 objPosition = obj.position;
    obj.position.add(Vector3(0, angle, 0));
    obj.updateTransform();
    scene!.update();
  }

  void _updateView() {
    if (scene == null) return;
    if (sceneObj == null) return;

    /// update fab
    if (!isFAB) {
      setState(() {
        if (latitude.abs() > 0.05 || longitude.abs() > 0.5) isFAB = true;
      });
    }
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
          if (widget.animReverse) {
            _animateDirection *= -1.0;
          } else {
            _controller.stop();
          }
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
    _imageStream = provider.resolve(const ImageConfiguration());
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
      _loadTexture(widget.child!.image);
      // _loadTexture(widget.child![current_index].getImage().image);

      scene.world.add(surface!);
    }
  }

  void _onSceneCreatedObj(Scene scene) {
    sceneObj = scene;
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
          width: hotspot.width,
          height: hotspot.height,
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
    _streamController = StreamController<void>.broadcast();
    // _stream = _streamController.stream;

    // if (listHotspot[current_index] == null) listHotspot[current_index] = [];
    // this.hotspots = listHotspot[current_index]!;

    _controller = AnimationController(
        duration: const Duration(milliseconds: 60000), vsync: this)
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
  void didUpdateWidget(AddObject oldWidget) {
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
    if (widget.child?.image != oldWidget.child?.image) {
      _loadTexture(widget.child?.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget moveContainer() => SizedBox(
        width: size.width / 4,
        child: Wrap(
          children: [
            ElevatedButton(
              onPressed: () {
                moveUp(currentObj!, 3.14 / 30);
              },
              child: const Icon(Icons.arrow_upward),
            ),
            ElevatedButton(
              onPressed: () {
                moveRight(currentObj!, -3.14 / 30);
              },
              child: const Icon(Icons.arrow_back),
            ),
            ElevatedButton(
              onPressed: () {
                moveRight(currentObj!, 3.14 / 30);
              },
              child: const Icon(Icons.arrow_forward),
            ),
            ElevatedButton(
              onPressed: () {
                moveUp(currentObj!, -3.14 / 30);
              },
              child: const Icon(Icons.arrow_downward),
            ),
            ElevatedButton(
              onPressed: changePrevObject,
              child: const Text("Trước"),
            ),
            ElevatedButton(
              onPressed: changeNextObject,
              child: const Text("Sau"),
            ),
            ElevatedButton(
              onPressed: () {
                if (currentObj == null) return;
                sceneObj!.world.children.remove(currentObj);
                changePrevObject();
              },
              child: const Text("Xóa"),
            ),
          ],
        ));

    showColorDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Chọn màu'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Đổi'),
                  onPressed: () {
                    setState(() => currentColor = pickerColor);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    Stack objectToolKit = Stack(
      children: [
        Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  child: moveContainer(),
                  visible: objectToolVisible,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Visibility(
                        visible: objectToolVisible,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 15, top: 8),
                                  width: 70,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: currentColor,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                onTap: showColorDialog,
                              ),
                              Slider(
                                value: rotateY,
                                onChanged: (value) {
                                  setState(() {
                                    rotateY = value;
                                    if (currentObj == null) return;
                                    rotateObject(currentObj!, angleY: value);
                                  });
                                },
                                min: 0,
                                max: 360,
                              ),
                              Slider(
                                value: rotateX,
                                onChanged: (value) {
                                  setState(() {
                                    rotateX = value;
                                    if (currentObj == null) return;
                                    rotateObject(currentObj!, angleX: rotateX);
                                  });
                                },
                                min: 0,
                                max: 360,
                              ),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 25),
                      child: isFAB
                          ? objectFAB(onAddingFABCLicked, mode)
                          : extObjectFAB(onAddingFABCLicked, mode),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );

    Widget pano = Stack(
      children: [
        Cube(interactive: false, onSceneCreated: _onSceneCreated),
        Cube(interactive: false, onSceneCreated: _onSceneCreatedObj),
      ],
    );

    return Stack(children: [
      GestureDetector(
        // onScaleStart: _handleScaleStart,
        // onScaleUpdate: _handleScaleUpdate,
        // onTapUp: _handleTapUp,
        child: Cube(interactive: false, onSceneCreated: _onSceneCreated),
      ),
      GestureDetector(
        onScaleStart: _handleScaleStart,
        onScaleUpdate: _handleScaleObjectUpdate,
        onTapUp: _handleTapUp,
        child: Cube(interactive: false, onSceneCreated: _onSceneCreatedObj),
      ),
      objectToolKit
    ]);
  }
}