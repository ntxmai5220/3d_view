import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/view/thumbnail_view/bloc/thumbnail_view_bloc.dart';
import 'package:bk_3d_view/panorama/packages.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_styles.dart';

import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui' as ui;

class ListThumbnail extends StatelessWidget {
  const ListThumbnail({
    Key? key,
    required this.room,
  }) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget itemBuilder(BuildContext context, int index) {
      return AspectRatio(
        aspectRatio: size.height / size.width,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              child: Image.memory(
                context
                    .read<ThumbnailViewBloc>()
                    .state
                    .capture[room.id]![index],
                fit: BoxFit.cover,
                width: size.width,
              ),

              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              // physics: CustomScrollPhysics(itemDimension: size.width),
              //   // padding: const EdgeInsets.symmetric(horizontal: 5),
              //   children: [
              //     Image.memory(
              //       context
              //           .read<ThumbnailViewBloc>()
              //           .state
              //           .capture[room.id]![index],
              //       width: size.width,
              //     ),
              //     // NetImage(width: size.width, imageUrl: AppConstants.imgTemp),
              //     Container(
              //       width: 80,
              //       color: AppColors.red,
              //       child: Center(
              //           child: IconActionButton(
              //         icon: Icons.delete_forever_rounded,
              //         iconColor: AppColors.white80,
              //         size: 32,
              //         onTap: () => context.read<ThumbnailViewBloc>().add(
              //             ThumbnailViewDeleteCaptureEvent(
              //                 roomId: room.id ?? '', index: index)),
              //       )),
              //     )
              //   ],
              // ),
            ),
            Positioned(
                right: 8,
                top: 8,
                child: FloatingActionButton.small(
                    heroTag: '$index',
                    backgroundColor: AppColors.red.withOpacity(0.45),
                    child: const Icon(
                      // Icons.delete_forever_rounded,
                      Icons.delete_forever_rounded,
                      color: AppColors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      context.read<ThumbnailViewBloc>().add(
                          ThumbnailViewDeleteCaptureEvent(
                              roomId: room.id ?? '', index: index));

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Đã xóa một thumbnail',
                        style: TextStyles.tinyContent
                            .copyWith(color: AppColors.white),
                      )));
                    }))
          ],
        ),
      );
    }

    return Scaffold(
      appBar: MyAppBar(
        title: AppBarTextTitle(
          title: room.name ?? '',
          color: AppColors.white,
        ),
        actions: [
          IconActionButton(
            icon: Icons.crop_outlined,
            iconColor: AppColors.white,
            onTap: () => onTapCapture(context, roomId: room.id ?? ''),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: BlocBuilder<ThumbnailViewBloc, ThumbnailViewState>(
          //     listenWhen: (previous, current) {
          //   print(previous.capture[room.id]!.length);
          //   print(current.capture[room.id]!.length);
          //   return previous.capture[room.id]!.length >
          //       current.capture[room.id]!.length;
          // }, listener: (context, state) {
          //   print(state.capture[room.id]!.length);
          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(SnackBar(content: Text('Đã xóa một thumbnail')));
          // },
          builder: (context, state) {
        var listThumbnail = state.capture[room.id];
        return listThumbnail != null && listThumbnail.isNotEmpty
            ? ListView.separated(
                itemBuilder: itemBuilder,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: listThumbnail.length,
              )
            : const EmptyImageList();
      }),
    );
  }

  onTapCapture(BuildContext context, {required String roomId}) async {
    List<ui.Image> capture = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CaptureThumbnail(
          imgUrl: room.imgUrl ?? '',
        ),
      ),
    );

    if (capture.isNotEmpty) {
      context.read<ThumbnailViewBloc>().add(
          ThumbnailViewReceivedCapturesEvent(capture: capture, roomId: roomId));
    }

    // context.read<NewPostBloc>().add(NewPostUploadThumbnail(images: capture));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeLeft,
    ]);
  }
}
