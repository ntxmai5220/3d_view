import 'package:bk_3d_view/pages/new_post/blocs.dart';
import 'package:bk_3d_view/pages/pages.dart';

import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class RemoveView extends StatelessWidget {
//   const RemoveView({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

class RemoveView extends StatelessWidget {
  const RemoveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageViewBloc imageViewBloc = context.read<ImageViewBloc>();

    return ListRoom(
      onTapItem: (room) {
        openDrawMask(context, url: room.imgUrl ?? '', roomId: room.id ?? '');
        // List<ui.Image> capture = await Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => CaptureThumbnail(
        //       imgUrl: room.imgUrl ?? '',
        //     ),
        //   ),
        // );
        // debugPrint(capture.length.toString());
        // thumbnailViewBloc
        //     .add(ThumbnailViewReceivedCapturesEvent(capture: capture));

        // context.read<NewPostBloc>().add(NewPostUploadThumbnail(images: capture));
        // SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   // DeviceOrientation.landscapeLeft,
        // ]);
      },
    );

    // BlocBuilder<ImageViewBloc, ImageViewState>(
    //   builder: (context, state) {
    //     return ListView.separated(
    //         padding: const EdgeInsets.symmetric(
    //             horizontal: AppConstants.pageMarginHorizontal / 2,
    //             vertical: AppConstants.pageMarginHorizontal / 2),
    //         itemBuilder: itemBuilder,
    //         separatorBuilder: (context, index) => const SizedBox(height: 8),
    //         itemCount: imageViewBloc.state.rooms.length);
    //   },
    // );
  }

  openDrawMask(BuildContext context,
      {required String url, required String roomId}) async {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (_) => RemoveObjectPage(
                  url: url,
                  roomId: roomId,
                ),
            fullscreenDialog: true))
        .then(
          (value) => SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp]),
        );
  }
}

// class RemoveView extends StatefulWidget {
//   const RemoveView({Key? key}) : super(key: key);

//   @override
//   State<RemoveView> createState() => _RemoveViewState();
// }

// class _RemoveViewState extends State<RemoveView> {
//   static const Color drawColor = AppColors.white;

//   ui.Image? backgroundImage;
//   late final ui.Image image;
//   Paint shapePaint = Paint()
//     ..strokeWidth = 5
//     ..color = drawColor
//     ..style = PaintingStyle.stroke
//     ..strokeCap = StrokeCap.round;

//   FocusNode textFocusNode = FocusNode();

//   late PainterController controller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = PainterController(
//       settings: const PainterSettings(
//         freeStyle: FreeStyleSettings(
//           color: drawColor,
//           strokeWidth: 5,
//         ),
//         scale: ScaleSettings(
//           enabled: true,
//           minScale: 1,
//           maxScale: 5,
//         ),
//       ),
//     );
//     initBackground();
//   }

//   void initBackground() async {
//     // Extension getter (.image) to get [ui.Image] from [ImageProvider]
//     // final image =
//     //     await const NetworkImage('https://picsum.photos/1920/1080/').image;

//     // final image = await FileImage(File(imgUrl)).image;
//     image = await const AssetImage('assets/images/photo.jpg').image;
//     setState(() {
//       backgroundImage = image;
//       controller.background = image.backgroundDrawable;
//     });
//   }

//   void onFocus() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ValueListenableBuilder<PainterControllerValue>(
//             valueListenable: controller,
//             child: const Text("Flutter Painter Example"),
//             builder: (context, _, child) {
//               return AppBar(
//                 title: child,
//                 actions: [
//                   // Delete the selected drawable
//                   IconButton(
//                     icon: const Icon(
//                       Icons.delete,
//                     ),
//                     onPressed: controller.selectedObjectDrawable == null
//                         ? null
//                         : removeSelectedDrawable,
//                   ),
//                   // Delete the selected drawable
//                   IconButton(
//                     icon: const Icon(
//                       Icons.flip,
//                     ),
//                     onPressed: controller.selectedObjectDrawable != null &&
//                             controller.selectedObjectDrawable is ImageDrawable
//                         ? flipSelectedImageDrawable
//                         : null,
//                   ),
//                   // Redo action
//                   IconButton(
//                     icon: const Icon(
//                       Icons.redo,
//                     ),
//                     onPressed: controller.canRedo ? redo : null,
//                   ),
//                   // Undo action
//                   IconButton(
//                     icon: const Icon(
//                       Icons.undo,
//                     ),
//                     onPressed: controller.canUndo ? undo : null,
//                   ),
//                 ],
//               );
//             }),
//         Expanded(
//             child: Stack(
//           children: [
//             if (backgroundImage != null)
//               // Enforces constraints
//               Positioned.fill(
//                 child: Center(
//                   child: AspectRatio(
//                     aspectRatio:
//                         backgroundImage!.width / backgroundImage!.height,
//                     child: FlutterPainter(
//                       controller: controller,
//                     ),
//                   ),
//                 ),
//               ),
//             Positioned(
//               right: 0,
//               bottom: 100,
//               child: FloatingActionButton(
//                 child: const Icon(
//                   Icons.image,
//                 ),
//                 onPressed: renderAndDisplayImage,
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               right: 0,
//               left: 0,
//               child: ValueListenableBuilder(
//                 valueListenable: controller,
//                 builder: (context, _, __) => Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         decoration: const BoxDecoration(
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(20)),
//                           color: Colors.white54,
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             if (controller.freeStyleMode !=
//                                 FreeStyleMode.none) ...[
//                               const Divider(),
//                               const Text("Free Style Settings"),
//                               // Control free style stroke width
//                               Row(
//                                 children: [
//                                   const Expanded(
//                                       flex: 1, child: Text("Stroke Width")),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Slider.adaptive(
//                                         min: 2,
//                                         max: 25,
//                                         value: controller.freeStyleStrokeWidth,
//                                         onChanged: setFreeStyleStrokeWidth),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                             if (textFocusNode.hasFocus) ...[
//                               const Divider(),
//                               const Text("Text settings"),
//                               // Control text font size
//                               Row(
//                                 children: [
//                                   const Expanded(
//                                       flex: 1, child: Text("Font Size")),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Slider.adaptive(
//                                         min: 8,
//                                         max: 96,
//                                         value:
//                                             controller.textStyle.fontSize ?? 14,
//                                         onChanged: setTextFontSize),
//                                   ),
//                                 ],
//                               ),

//                               // Control text color hue
//                               Row(
//                                 children: [
//                                   const Expanded(flex: 1, child: Text("Color")),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Slider.adaptive(
//                                         min: 0,
//                                         max: 359.99,
//                                         value: HSVColor.fromColor(
//                                                 controller.textStyle.color ??
//                                                     drawColor)
//                                             .hue,
//                                         activeColor: controller.textStyle.color,
//                                         onChanged: setTextColor),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                             if (controller.shapeFactory != null) ...[
//                               const Divider(),
//                               const Text("Shape Settings"),

//                               // Control text color hue
//                               Row(
//                                 children: [
//                                   const Expanded(
//                                       flex: 1, child: Text("Stroke Width")),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Slider.adaptive(
//                                         min: 2,
//                                         max: 25,
//                                         value: controller
//                                                 .shapePaint?.strokeWidth ??
//                                             shapePaint.strokeWidth,
//                                         onChanged: (value) =>
//                                             setShapeFactoryPaint(
//                                                 (controller.shapePaint ??
//                                                         shapePaint)
//                                                     .copyWith(
//                                               strokeWidth: value,
//                                             ))),
//                                   ),
//                                 ],
//                               ),

//                               // Control shape color hue
//                               Row(
//                                 children: [
//                                   const Expanded(flex: 1, child: Text("Color")),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Slider.adaptive(
//                                         min: 0,
//                                         max: 359.99,
//                                         value: HSVColor.fromColor(
//                                                 (controller.shapePaint ??
//                                                         shapePaint)
//                                                     .color)
//                                             .hue,
//                                         activeColor: (controller.shapePaint ??
//                                                 shapePaint)
//                                             .color,
//                                         onChanged: (hue) =>
//                                             setShapeFactoryPaint(
//                                                 (controller.shapePaint ??
//                                                         shapePaint)
//                                                     .copyWith(
//                                               color: HSVColor.fromAHSV(
//                                                       1, hue, 1, 1)
//                                                   .toColor(),
//                                             ))),
//                                   ),
//                                 ],
//                               ),

//                               Row(
//                                 children: [
//                                   const Expanded(
//                                       flex: 1, child: Text("Fill shape")),
//                                   Expanded(
//                                     flex: 3,
//                                     child: Center(
//                                       child: Switch(
//                                           value: (controller.shapePaint ??
//                                                       shapePaint)
//                                                   .style ==
//                                               PaintingStyle.fill,
//                                           onChanged: (value) =>
//                                               setShapeFactoryPaint(
//                                                   (controller.shapePaint ??
//                                                           shapePaint)
//                                                       .copyWith(
//                                                 style: value
//                                                     ? PaintingStyle.fill
//                                                     : PaintingStyle.stroke,
//                                               ))),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ]
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )),
//         ValueListenableBuilder(
//           valueListenable: controller,
//           builder: (context, _, __) => Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               // Free-style eraser
//               // IconButton(
//               //   icon: Icon(
//               //     Icons.signal_cellular_off_rounded,
//               //     color: controller.freeStyleMode == FreeStyleMode.erase
//               //         ? Colors.black
//               //         : null,
//               //   ),
//               //   onPressed: toggleFreeStyleErase,
//               // ),
//               // Free-style drawing
//               IconButton(
//                 icon: Icon(
//                   Icons.loop,
//                   color: controller.freeStyleMode == FreeStyleMode.draw
//                       ? Colors.black
//                       : null,
//                 ),
//                 onPressed: toggleFreeStyleDraw,
//               ),
//               // Add text
//               IconButton(
//                 icon: Icon(
//                   Icons.text_fields,
//                   color: textFocusNode.hasFocus ? Colors.black : null,
//                 ),
//                 onPressed: addText,
//               ),
//               // Add sticker image

//               // Add shapes
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   void undo() {
//     controller.undo();
//   }

//   void redo() {
//     controller.redo();
//   }

//   void toggleFreeStyleDraw() {
//     controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
//         ? FreeStyleMode.draw
//         : FreeStyleMode.none;
//   }

//   void toggleFreeStyleErase() {
//     controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
//         ? FreeStyleMode.erase
//         : FreeStyleMode.none;
//   }

//   void addText() {
//     if (controller.freeStyleMode != FreeStyleMode.none) {
//       controller.freeStyleMode = FreeStyleMode.none;
//     }
//     controller.addText();
//   }

//   // void addSticker() async {
//   //   final imageLink = await showDialog<String>(
//   //       context: context,
//   //       builder: (context) => const SelectStickerImageDialog(
//   //             imagesLinks: imageLinks,
//   //           ));
//   //   if (imageLink == null) return;
//   //   controller.addImage(
//   //       await NetworkImage(imageLink).image, const Size(100, 100));
//   // }

//   void setFreeStyleStrokeWidth(double value) {
//     controller.freeStyleStrokeWidth = value;
//   }

//   void setFreeStyleColor(double hue) {
//     controller.freeStyleColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
//   }

//   void setTextFontSize(double size) {
//     // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
//     setState(() {
//       controller.textSettings = controller.textSettings.copyWith(
//           textStyle:
//               controller.textSettings.textStyle.copyWith(fontSize: size));
//     });
//   }

//   void setShapeFactoryPaint(Paint paint) {
//     // Set state is just to update the current UI, the [FlutterPainter] UI updates without it
//     setState(() {
//       controller.shapePaint = paint;
//     });
//   }

//   void setTextColor(double hue) {
//     controller.textStyle = controller.textStyle
//         .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
//   }

//   void selectShape(ShapeFactory? factory) {
//     controller.shapeFactory = factory;
//   }

//   void renderAndDisplayImage() {
//     if (backgroundImage == null) return;

//     PainterController renderController = PainterController(
//       settings: controller.settings,
//       drawables: controller.drawables,
//       background: image.backgroundDrawable,
//     );
//     // renderController.drawables= controller.drawables;

//     final backgroundImageSize =
//         Size(image.width.toDouble(), image.height.toDouble());

//     // renderController.background =
//     //     const ColorBackgroundDrawable(color: Colors.black);
//     // Render the image
//     // Returns a [ui.Image] object, convert to to byte data and then to Uint8List
//     final imageFuture = renderController
//         .renderImage(backgroundImageSize)
//         .then<Uint8List?>((ui.Image image) => image.pngBytes);

//     // From here, you can write the PNG image data a file or do whatever you want with it
//     // For example:
//     // ```dart
//     // final file = File('${(await getTemporaryDirectory()).path}/img.png');
//     // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//     // ```
//     // I am going to display it using Image.memory

//     // Show a dialog with the image
//     showDialog(
//         context: context,
//         builder: (context) => RenderedImageDialog(imageFuture: imageFuture));
//   }

//   void removeSelectedDrawable() {
//     final selectedDrawable = controller.selectedObjectDrawable;
//     if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
//   }

//   void flipSelectedImageDrawable() {
//     final imageDrawable = controller.selectedObjectDrawable;
//     if (imageDrawable is! ImageDrawable) return;

//     controller.replaceDrawable(
//         imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
//   }
// }

// class RenderedImageDialog extends StatelessWidget {
//   final Future<Uint8List?> imageFuture;

//   const RenderedImageDialog({Key? key, required this.imageFuture})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text("Rendered Image"),
//       content: FutureBuilder<Uint8List?>(
//         future: imageFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) {
//             return const SizedBox(
//               height: 50,
//               child: Center(child: CircularProgressIndicator.adaptive()),
//             );
//           }
//           if (!snapshot.hasData || snapshot.data == null) {
//             return const SizedBox();
//           }
//           return InteractiveViewer(
//               maxScale: 10, child: Image.memory(snapshot.data!));
//         },
//       ),
//     );
//   }
// }
