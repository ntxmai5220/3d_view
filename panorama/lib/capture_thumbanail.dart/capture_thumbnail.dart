import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:panorama/panorama.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    GlobalKey globalKey = GlobalKey();

    Future<void> _capturePng() async {
      final RenderRepaintBoundary boundary = globalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 5);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      print('length ${pngBytes.length}');
      print(image.height);
      print(image.width);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            // appBar: AppBar(
            //   title: const Text('Crop Result'),
            //   centerTitle: true,
            // ),
            body: Row(
              children: [
                Container(
                    color: Colors.black,
                    child: FloatingActionButton(
                        onPressed: () async {
                          if (pngBytes != null) {
                            final directory =
                                await getApplicationDocumentsDirectory();
                            final imagePath = await File(
                                    '${directory.path}/container_image.png')
                                .create();
                            await imagePath.writeAsBytes(pngBytes);
                          }
                        },
                        child: const Icon(
                          Icons.save_rounded,
                          color: Colors.white,
                        ))),
                Expanded(
                  child: RawImage(
                    image: image,
                  ),
                ),
              ],
            ),
          ),
          fullscreenDialog: true,
        ),
      );
    }

    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                RepaintBoundary(
                  key: globalKey,
                  child: Panorama(
                    zoom: 0.1,
                    // child: Image.file(
                    //   File(imgUrl),
                    //   fit: BoxFit.cover,
                    // )

                    child: Image.asset(
                      'assets/images/photo.jpg',
                      filterQuality: FilterQuality.none,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 50,
                  child: FloatingActionButton(
                      onPressed: _capturePng, child: const Icon(Icons.crop)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
