import 'dart:async';
import 'dart:math' as math;
import 'package:bk_3d_view/panorama/add_hotspot/bloc/add_hotspot_bloc.dart';

import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:panorama/module.dart';

class AddHotspot extends StatefulWidget {
  const AddHotspot({
    Key? key,
    this.latitude = 0,
    this.longitude = 0,
    this.zoom = 1.0,
    this.minLatitude = -90.0,
    this.maxLatitude = 90.0,
    this.minLongitude = -180.0,
    this.maxLongitude = 180.0,
    this.minZoom = 0.7,
    this.maxZoom = 5.0,
    this.sensitivity = 1.0,
    this.animSpeed = 0.0,
    this.animReverse = true,
    this.latSegments = 32,
    this.lonSegments = 64,
    this.interactive = true,
    this.sensorControl = SensorControl.None,
    this.croppedArea = const Rect.fromLTWH(0.0, 0.0, 1.0, 1.0),
    this.croppedFullWidth = 1.0,
    this.croppedFullHeight = 1.0,
    this.onViewChanged,
    this.onTap,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onImageLoad,
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

  /// Control the panorama with motion sensors.
  final SensorControl sensorControl;

  /// Area of the image was cropped from the full sized photo sphere.
  final Rect croppedArea;

  /// Original full width from which the image was cropped.
  final double croppedFullWidth;

  /// Original full height from which the image was cropped.
  final double croppedFullHeight;

  /// This event will be called when the view direction has changed, it contains latitude and longitude about the current view.
  final Function(double longitude, double latitude, double tilt)? onViewChanged;

  /// This event will be called when the user has tapped, it contains latitude and longitude about where the user tapped.
  final Function(double longitude, double latitude, double tilt)? onTap;

  /// This event will be called when the user has started a long press, it contains latitude and longitude about where the user pressed.
  final Function(double longitude, double latitude, double tilt)?
      onLongPressStart;

  /// This event will be called when the user has drag-moved after a long press, it contains latitude and longitude about where the user pressed.
  final Function(double longitude, double latitude, double tilt)?
      onLongPressMoveUpdate;

  /// This event will be called when the user has stopped a long presses, it contains latitude and longitude about where the user pressed.
  final Function(double longitude, double latitude, double tilt)?
      onLongPressEnd;

  /// This event will be called when provided image is loaded on texture.
  final Function()? onImageLoad;

  /// Specify an Image(equirectangular image) widget to the panorama.
  final Image? child;

  /// Place widgets in the panorama.
  final List<Hotspot>? hotspots;

  @override
  _AddHotspotState createState() => _AddHotspotState();
}

class _AddHotspotState extends State<AddHotspot>
    with SingleTickerProviderStateMixin {
  Scene? scene;
  Object? surface;
  late double latitude;
  late double longitude;
  double latitudeDelta = 0;
  double longitudeDelta = 0;
  double zoomDelta = 0;
  late Offset _lastFocalPoint;
  double? _lastZoom;
  final double _radius = 500;
  final double _dampingFactor = 0.05;
  double _animateDirection = 1.0;
  late AnimationController _controller;
  double screenOrientation = 0.0;
  Vector3 orientation = Vector3(0, radians(90), 0);
  StreamSubscription? _orientationSubscription;
  StreamSubscription? _screenOrientSubscription;
  late StreamController<void> _streamController;
  Stream<void>? _stream;
  ImageStream? _imageStream;

  bool isExtendBtn = true;

  void _handleTapUp(TapUpDetails details) {
    final Vector3 o =
        positionToLatLon(details.localPosition.dx, details.localPosition.dy);
    debugPrint(degrees(o.x).toString());
    //show bottomshet to choose
    // widget.onTap!(degrees(o.x), degrees(-o.y), degrees(o.z));
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    final Vector3 o =
        positionToLatLon(details.localPosition.dx, details.localPosition.dy);
    widget.onLongPressStart!(degrees(o.x), degrees(-o.y), degrees(o.z));
  }

  void _handleLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    final Vector3 o =
        positionToLatLon(details.localPosition.dx, details.localPosition.dy);
    widget.onLongPressMoveUpdate!(degrees(o.x), degrees(-o.y), degrees(o.z));
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    final Vector3 o =
        positionToLatLon(details.localPosition.dx, details.localPosition.dy);
    widget.onLongPressEnd!(degrees(o.x), degrees(-o.y), degrees(o.z));
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
    if (widget.sensorControl == SensorControl.None &&
        !_controller.isAnimating) {
      _controller.reset();
      if (widget.animSpeed != 0) {
        _controller.repeat();
      } else {
        _controller.forward();
      }
    }
  }

  void _updateView() {
    if (scene == null) return;
    if (isExtendBtn && (latitude.abs() > 0.07 || longitude.abs() > 0.45)) {
      setState(() {
        isExtendBtn = false;
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
    // stop animation if not needed
    if (latitudeDelta.abs() < 0.001 &&
        longitudeDelta.abs() < 0.001 &&
        zoomDelta.abs() < 0.001) {
      if (widget.sensorControl == SensorControl.None &&
          widget.animSpeed == 0 &&
          _controller.isAnimating) _controller.stop();
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
    q *= Quaternion.axisAngle(Vector3(0, 1, 0), -math.pi * 0.5);
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
    _streamController.add(null);
  }

  void _updateSensorControl() {
    _orientationSubscription?.cancel();
    switch (widget.sensorControl) {
      case SensorControl.Orientation:
        motionSensors.orientationUpdateInterval =
            Duration.microsecondsPerSecond ~/ 60;
        _orientationSubscription =
            motionSensors.orientation.listen((OrientationEvent event) {
          orientation.setValues(event.yaw, event.pitch, event.roll);
        });
        break;
      case SensorControl.AbsoluteOrientation:
        motionSensors.absoluteOrientationUpdateInterval =
            Duration.microsecondsPerSecond ~/ 60;
        _orientationSubscription = motionSensors.absoluteOrientation
            .listen((AbsoluteOrientationEvent event) {
          orientation.setValues(event.yaw, event.pitch, event.roll);
        });
        break;
      default:
    }

    _screenOrientSubscription?.cancel();
    if (widget.sensorControl != SensorControl.None) {
      _screenOrientSubscription = motionSensors.screenOrientation
          .listen((ScreenOrientationEvent event) {
        screenOrientation = radians(event.angle!);
      });
    }
  }

  void _updateTexture(ImageInfo imageInfo, bool synchronousCall) {
    surface?.mesh.texture = imageInfo.image;
    surface?.mesh.textureRect = Rect.fromLTWH(0, 0,
        imageInfo.image.width.toDouble(), imageInfo.image.height.toDouble());
    scene!.texture = imageInfo.image;
    scene!.update();
    widget.onImageLoad?.call();
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
    scene.camera.near = 1.0;
    scene.camera.far = _radius + 1.0;
    scene.camera.fov = 75;
    scene.camera.zoom = widget.zoom;
    scene.camera.position.setFrom(Vector3(0, 0, 0.1));
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
      scene.world.add(surface!);
      _updateView();
    }
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
    _streamController = StreamController<Null>.broadcast();
    _stream = _streamController.stream;

    _updateSensorControl();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 60000), vsync: this)
      ..addListener(_updateView);
    if (widget.sensorControl != SensorControl.None || widget.animSpeed != 0) {
      _controller.repeat();
    }
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
  void didUpdateWidget(AddHotspot oldWidget) {
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
    if (widget.sensorControl != oldWidget.sensorControl) {
      _updateSensorControl();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget pano = RepositoryProvider(
      create: (context) => AddHotspotRepository(),
      child: BlocProvider(
        create: (context) => AddHotspotBloc(
            repository: RepositoryProvider.of<AddHotspotRepository>(context)),
        child: BlocBuilder<AddHotspotBloc, AddHotspotState>(
          builder: (context, state) {
            var bloc = context.read<AddHotspotBloc>();
            return Stack(
              children: [
                Cube(interactive: false, onSceneCreated: _onSceneCreated),
                Positioned(
                  right: 25,
                  bottom: 25,
                  child: Column(
                    children: [
                      ExtendFloatingButton(
                        type: PanoramActionType.add,
                        currentType: state.status,
                        onTap: () => bloc.add(AddHotspotChangeActionEvent(
                            type: PanoramActionType.add)),
                        isExtend: isExtendBtn,
                      ),
                      const SizedBox(height: 20),
                      ExtendFloatingButton(
                        type: PanoramActionType.delete,
                        currentType: state.status,
                        onTap: () => bloc.add(AddHotspotChangeActionEvent(
                            type: PanoramActionType.delete)),
                        isExtend: isExtendBtn,
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: _stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return buildHotspotWidgets(widget.hotspots);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );

    return widget.interactive
        ? GestureDetector(
            onScaleStart: _handleScaleStart,
            onScaleUpdate: _handleScaleUpdate,
            onTapUp: _handleTapUp,
            onLongPressStart:
                widget.onLongPressStart == null ? null : _handleLongPressStart,
            onLongPressMoveUpdate: widget.onLongPressMoveUpdate == null
                ? null
                : _handleLongPressMoveUpdate,
            onLongPressEnd:
                widget.onLongPressEnd == null ? null : _handleLongPressEnd,
            child: pano,
          )
        : pano;
  }
}
