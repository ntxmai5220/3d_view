import 'dart:io';
import 'dart:typed_data';

import 'package:bk_3d_view/pages/remove_object/bloc/remove_object_bloc.dart';
import 'package:bk_3d_view/repositories/remove_object/remove_object_repository.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/app_bar/back_leading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'dart:ui' as ui;

class RemoveObjectPage extends StatefulWidget {
  const RemoveObjectPage({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);
  final String imgUrl;

  @override
  State<RemoveObjectPage> createState() => _RemoveObjectPageState();
}

class _RemoveObjectPageState extends State<RemoveObjectPage> {
  static const Color drawColor = AppColors.white;

  ui.Image? backgroundImage;
  late final ui.Image image;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = drawColor
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  FocusNode textFocusNode = FocusNode();

  late PainterController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PainterController(
      settings: const PainterSettings(
        freeStyle: FreeStyleSettings(
          color: drawColor,
          strokeWidth: 13,
        ),
        scale: ScaleSettings(
          enabled: true,
          minScale: 1,
          maxScale: 5,
        ),
      ),
    );
    initBackground();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    // final image =
    //     await const NetworkImage('https://picsum.photos/1920/1080/').image;

    image = await FileImage(File(widget.imgUrl)).image;
    // image = await const AssetImage('assets/images/photo.jpg').image;
    setState(() {
      backgroundImage = image;
      controller.background = image.backgroundDrawable;
    });
  }

  void onFocus() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement
    // disposeS
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RemoveObjectRepository(),
      child: BlocProvider(
        create: (context) =>
            RemoveObjectBloc(repository: RepositoryProvider.of(context)),
        child: BlocBuilder<RemoveObjectBloc, RemoveObjectState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.black,
              body: SafeArea(
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: AppColors.white,
                      child: ValueListenableBuilder<PainterControllerValue>(
                          valueListenable: controller,
                          child: const Text("Flutter Painter Example"),
                          builder: (context, _, child) {
                            return Column(
                              // title: child,
                              children: [
                                // Delete the selected drawable
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: BackLeading(
                                    color: AppColors.darkPrimary,
                                  ),
                                ),
                                const Spacer(),
                                // Redo action
                                IconButton(
                                  icon: const Icon(
                                    Icons.redo,
                                    color: AppColors.darkPrimary,
                                  ),
                                  onPressed: controller.canRedo ? redo : null,
                                ),
                                // Undo action
                                IconButton(
                                  icon: const Icon(
                                    Icons.undo,
                                    color: AppColors.darkPrimary,
                                  ),
                                  onPressed: controller.canUndo ? undo : null,
                                ),
                              ],
                            );
                          }),
                    ),
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio:
                              image.width / image.height,
                          child: FlutterPainter(
                            controller: controller,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 48,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: AppColors.white,
                      child: ValueListenableBuilder(
                        valueListenable: controller,
                        builder: (context, _, __) => Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Free-style eraser
                            IconButton(
                              icon: Icon(
                                Icons.cleaning_services_rounded,
                                color: controller.freeStyleMode ==
                                        FreeStyleMode.erase
                                    ? AppColors.darkPrimary
                                    : AppColors.darkSecondary,
                              ),
                              onPressed: toggleFreeStyleErase,
                            ),
                            // Free-style drawing

                            IconButton(
                              icon: Icon(
                                Icons.gesture_rounded,
                                color: controller.freeStyleMode ==
                                        FreeStyleMode.draw
                                    ? AppColors.darkPrimary
                                    : AppColors.darkSecondary,
                              ),
                              onPressed: toggleFreeStyleDraw,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.image,
                              ),
                              onPressed:()=> renderAndDisplayImage(context),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void undo() {
    controller.undo();
  }

  void redo() {
    controller.redo();
  }

  void toggleFreeStyleDraw() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  void toggleFreeStyleErase() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
        ? FreeStyleMode.erase
        : FreeStyleMode.none;
  }

  void renderAndDisplayImage(BuildContext context) async {
    if (backgroundImage == null) return;

    // PainterController renderController = PainterController(
    //   settings: controller.settings,
    //   drawables: controller.drawables,
    //   background: image.backgroundDrawable,
    // );

    // renderController.drawables= controller.drawables;

    final backgroundImageSize = Size(
        image.width.toDouble(), image.height.toDouble());


    // Render the image
    // Returns a [ui.Image] object, convert to to byte data and then to Uint8List
    final mask = await controller
        .renderImage(backgroundImageSize)
        .then((value) => value.toByteData(format: ui.ImageByteFormat.png));
    final img =
        await backgroundImage!.toByteData(format: ui.ImageByteFormat.png);
    // From here, you can write the PNG image data a file or do whatever you want with it
    // For example:
    // ```dart
    // final file = File('${(await getTemporaryDirectory()).path}/img.png');
    // await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    // ```
    // I am going to display it using Image.memory

    // Show a dialog with the image
    var bloc = context.read<RemoveObjectBloc>();
    bloc.add(RemoveObjectSendMaskEvent(image: img!, mask: mask!));
    // showDialog(
    //     context: context,
    //     builder: (context) => RenderedImageDialog(imageFuture: imageFuture));

    //     final ui.Image send =
    //     await renderController.renderImage(backgroundImageSize);
    // ByteData? byteData = await send.toByteData(format: ui.ImageByteFormat.png);
    // byteData?.buffer.asInt64List();
    // MultipartFile.fromBytes(byteData?.buffer.asInt64List().cast<int>()??[]);
  }
}

class RenderedImageDialog extends StatelessWidget {
  final Future<Uint8List?> imageFuture;

  const RenderedImageDialog({Key? key, required this.imageFuture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Rendered Image"),
      content: FutureBuilder<Uint8List?>(
        future: imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              height: 50,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox();
          }
          return InteractiveViewer(
              maxScale: 10, child: Image.memory(snapshot.data!));
        },
      ),
    );
  }
}
