import 'package:bk_3d_view/widgets/dialog/loading_dialog.dart';
import 'package:bk_3d_view/widgets/dialog/my_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:panorama/panorama.dart';
import 'dart:ui' as ui;

// class CaptureThumbnail extends StatefulWidget {
//   const CaptureThumbnail({ Key? key }) : super(key: key);

//   @override
//   State<CaptureThumbnail> createState() => _CaptureThumbnailState();
// }

// class _CaptureThumbnailState extends State<CaptureThumbnail> {
//   @override
//   Widget build(BuildContext context) {
//     return RepaintBoundary(
//       child: Container(

//       ),
//     );
//   }
// }

class CaptureThumbnail extends StatelessWidget {
  const CaptureThumbnail({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    List<ui.Image> capture = [];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    GlobalKey globalKey = GlobalKey();

    Future<void> _capturePng() async {
      final RenderRepaintBoundary boundary = globalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      ShowMyDialog.show(context, dialog: const LoadingDialog());
      // showDialog(
      //   barrierDismissible: false,
      //   context: context,
      //   builder: (_) => Dialog(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 23),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           SizedBox.square(
      //               dimension: 28, child: CircularProgressIndicator()),
      //           const SizedBox(height: 20),
      //           Text('Đang xử lý...',
      //               style: Theme.of(context).textTheme.bodyMedium),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      final ui.Image image = await boundary.toImage(pixelRatio: 1.5);

      // final ByteData? byteData =
      //     await image.toByteData(format: ui.ImageByteFormat.png);
      // final Uint8List pngBytes = byteData!.buffer.asUint8List();
      Navigator.of(context).pop();
      // print('length ${pngBytes.length}');
      print(image.height);
      print(image.width);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Positioned.fill(
                  // key: globalKey,
                  child: Container(
                    // padding: const EdgeInsets.all(15),
                    color: Colors.white12,
                    child: RawImage(
                      image: image,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: SafeArea(
                    child: Column(
                      children: [
                        FloatingActionButton(
                            heroTag: 'discard',
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.close_rounded)),
                        const SizedBox(height: 15),
                        FloatingActionButton(
                            heroTag: 'save',
                            onPressed: () {
                              {
                                capture.add(image);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Icon(Icons.save)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          fullscreenDialog: true,
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Panorama(
                minZoom: 0.5,
                maxZoom: 4,
                // onImageLoad: ,
                child: Image(image: CachedNetworkImageProvider(imgUrl)),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: SafeArea(
                child: Column(
                  children: [
                    FloatingActionButton(
                        heroTag: 'back',
                        onPressed: () => Navigator.of(context).pop(capture),
                        child: const Icon(Icons.arrow_back_ios_rounded)),
                    const SizedBox(height: 15),
                    FloatingActionButton(
                        heroTag: 'capture',
                        onPressed: _capturePng,
                        child: const Icon(Icons.crop)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
