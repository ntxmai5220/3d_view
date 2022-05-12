import 'dart:convert';
import 'dart:typed_data';

import 'package:bk_3d_view/pages/remove_object/bloc/remove_object_bloc.dart';
import 'package:bk_3d_view/repositories/remove_object/remove_object_repository.dart';
import 'package:bk_3d_view/values/values.dart';

import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_painter/flutter_painter.dart';

class RemoveObjectPage extends StatelessWidget {
  const RemoveObjectPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    PainterController controller = PainterController(
      settings: const PainterSettings(
        freeStyle: FreeStyleSettings(
          color: Colors.white,
          strokeWidth: 13,
        ),
        scale: ScaleSettings(
          enabled: true,
          minScale: 1,
          maxScale: 4,
        ),
      ),
    );
    return RepositoryProvider(
      create: (context) => RemoveObjectRepository(),
      child: BlocProvider(
        create: (context) => RemoveObjectBloc(
            repository: RepositoryProvider.of(context),
            painterController: controller)
          ..add(RemoveObjectInitEvent(url: url)),
        child: BlocConsumer<RemoveObjectBloc, RemoveObjectState>(
          listenWhen: (previous, current) {
            return (previous is RemoveObjectLoading &&
                    current is! RemoveObjectLoading) ||
                (previous is! RemoveObjectLoading &&
                    current is RemoveObjectLoading);
          },
          listener: (context, state) {
            if (state is RemoveObjectLoading) {
              ShowMyDialog.show(context, dialog: const LoadingDialog());
            } else {
              Navigator.pop(context);
              if(state is RemoveObjectReceivedMask){
                // showGeneralDialog(context: context, pageBuilder: pageBuilder)
              }
            }
          },
          builder: (context, state) {
            var bloc = context.read<RemoveObjectBloc>();
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
                          valueListenable: bloc.painterController,
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
                                  icon: Icon(
                                    Icons.redo,
                                    color: !bloc.painterController.canRedo
                                        ? AppColors.secondary
                                        : AppColors.darkPrimary,
                                  ),
                                  onPressed: bloc.painterController.canRedo
                                      ? () => bloc.add(RedoEvent())
                                      : null,
                                ),
                                // Undo action
                                IconButton(
                                  icon: Icon(
                                    Icons.undo,
                                    color: !bloc.painterController.canUndo
                                        ? AppColors.secondary
                                        : AppColors.darkPrimary,
                                  ),
                                  onPressed: bloc.painterController.canUndo
                                      ? () => bloc.add(UndoEvent())
                                      : null,
                                ),
                              ],
                            );
                          }),
                    ),
                    Expanded(
                      // child: InteractiveViewer(
                      //     child: Image.memory(base64Decode(img))),
                      child: state is RemoveObjectReceivedMask
                          ? InteractiveViewer(
                              child: Image.memory(base64Decode(state.mask)))
                          : state.background != null
                              ? Center(
                                  child: AspectRatio(
                                  aspectRatio: state.background!.width /
                                      state.background!.height,
                                  child: state is! RemoveObjectLoading
                                      ? FlutterPainter(
                                          controller: bloc.painterController,
                                        )
                                      : Image(
                                          image:
                                              CachedNetworkImageProvider(url)),
                                ))
                              : Container(
                                  color: AppColors.white80,
                                  child: const Center(
                                    child: LoadingPlaceHolder(
                                        width: 200, height: 200),
                                  )),
                    ),
                    Container(
                      width: 48,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      color: AppColors.white,
                      child: ValueListenableBuilder(
                        valueListenable:
                            context.read<RemoveObjectBloc>().painterController,
                        builder: (context, _, __) => Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Free-style eraser
                            IconActionButton(
                              padding: 3,
                              icon: Icons.cleaning_services_rounded,
                              iconColor:
                                  bloc.painterController.drawables.isNotEmpty
                                      ? bloc.painterController.freeStyleMode ==
                                              FreeStyleMode.erase
                                          ? AppColors.darkPrimary
                                          : AppColors.darkSecondary
                                      : AppColors.secondary,
                              onTap: bloc.painterController.drawables.isNotEmpty
                                  ? () => bloc.add(ToggleEraseEvent())
                                  : null,
                            ),
                            // Free-style drawing

                            IconActionButton(
                              padding: 3,
                              icon: Icons.gesture_rounded,
                              iconColor: bloc.painterController.freeStyleMode ==
                                      FreeStyleMode.draw
                                  ? AppColors.darkPrimary
                                  : AppColors.darkSecondary,
                              onTap: () => bloc.add(ToggleDrawEvent()),
                            ),
                            const Spacer(),
                            IconActionButton(
                              icon: Icons.image,
                              iconColor:
                                  bloc.painterController.drawables.isNotEmpty
                                      ? AppColors.darkPrimary
                                      : AppColors.secondary,
                              onTap: bloc.painterController.drawables.isNotEmpty
                                  ? () => renderAndDisplayImage(context)
                                  : null,
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

  void renderAndDisplayImage(BuildContext context) {
     context.read<RemoveObjectBloc>().add(RemoveObjectGenMaskEvent());
   
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

//////////////////////////////////////
