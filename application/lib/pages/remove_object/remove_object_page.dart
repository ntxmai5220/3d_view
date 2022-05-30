import 'dart:convert';

import 'package:bk_3d_view/pages/remove_object/bloc/remove_object_bloc.dart';
import 'package:bk_3d_view/repositories/remove_object/remove_object_repository.dart';
import 'package:bk_3d_view/values/values.dart';

import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_painter/flutter_painter.dart';

class RemoveObjectPage extends StatelessWidget {
  const RemoveObjectPage({
    Key? key,
    required this.url,
    this.roomId,
  }) : super(key: key);

  final String url;
  final String? roomId;
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
          listener: (context, state) async {
            var bloc = context.read<RemoveObjectBloc>();
            if (state is RemoveObjectLoading) {
              ShowMyDialog.show(context, dialog: const LoadingDialog());
            } else {
              Navigator.pop(context);
              if (state is RemoveObjectReceivedMask) {
                var result = await showResult(context, img: state.mask);
                if (result == true) {
                  //call api save
                  bloc.add(RemoveObjectUploadImageEvent(roomId: roomId ?? ''));
                } else {
                  bloc.add(RemoveObjectResetEvent());
                }
              } else if (state is RemoveObjectUploadCompleted) {
                Navigator.of(context).pop();
              } else if (state is RemoveObjectError) {
                var result = await ShowMyDialog.show(
                  context,
                  dialog: const NotificationDialog(
                    content: 'Đã xảy ra lỗi, vui lòng thử lại.',
                    type: DialogType.warning,
                  ),
                );
                if (result != null) {
                  bloc.add(RemoveObjectResetEvent());
                }
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
                          : (state.background != null
                              ? Center(
                                  child: AspectRatio(
                                  aspectRatio: state.background!.width /
                                      state.background!.height,
                                  child: state is! RemoveObjectLoading
                                      ? FlutterPainter(
                                          controller: bloc.painterController,
                                        )
                                      : NetImage(
                                          imageUrl: url,
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                        ),
                                ))
                              : Container(
                                  color: AppColors.white80,
                                  child: const Center(
                                    child: LoadingPlaceHolder(
                                        width: 200, height: 200),
                                  ))),
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

  Future<dynamic> showResult(BuildContext context,
          {required String img, String? roomId}) =>
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
                    child: InteractiveViewer(
                        child: Image.memory(base64Decode(img))),
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
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Icon(Icons.close_rounded)),
                        const SizedBox(height: 15),
                        if (roomId != null)
                          FloatingActionButton(
                              heroTag: 'save',
                              onPressed: () => Navigator.of(context).pop(true),
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
