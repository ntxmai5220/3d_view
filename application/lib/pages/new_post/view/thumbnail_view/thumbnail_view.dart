import 'package:bk_3d_view/pages/new_post/blocs.dart';
import 'package:bk_3d_view/pages/new_post/view/thumbnail_view/bloc/thumbnail_view_bloc.dart';

import 'package:bk_3d_view/widgets/list/list_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:ui' as ui;

import 'package:panorama/capture_thumbanail/capture_thumbnail.dart';

class ThumbnailView extends StatelessWidget {
  const ThumbnailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<ThumbnailViewBloc, ThumbnailViewState>(
      builder: (context, thumbnailViewState) {
        ThumbnailViewBloc thumbnailViewBloc = context.read<ThumbnailViewBloc>();
        return ListRoom(
          onTapItem: (room) async {
            List<ui.Image> capture = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CaptureThumbnail(
                  imgUrl: room.imgUrl ?? '',
                ),
              ),
            );
            debugPrint(capture.length.toString());
            thumbnailViewBloc.add(
                ThumbnailViewReceivedCapturesEvent(capture: capture));
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              // DeviceOrientation.landscapeLeft,
            ]);
          },
        );
        // return SafeArea(
        //     child: SingleChildScrollView(
        //   child: Center(
        //     child: Container(
        //       color: AppColors.secondary,
        //       child: Padding(
        //           padding: const EdgeInsets.symmetric(
        //               horizontal: AppConstants.pageMarginHorizontal / 1.5,
        //               vertical: AppConstants.pageMarginHorizontal / 1.5),
        //           child: Wrap(
        //               // alignment: WrapAlignment.center,
        //               runSpacing: 15,
        //               runAlignment: WrapAlignment.start,
        //               spacing: 15,
        //               crossAxisAlignment: WrapCrossAlignment.center,
        //               children: imageViewBloc.state.rooms
        //                   .map((room) => SizedBox(
        //                         width: 400,
        //                         child: ExpansionTile(
        //                           title: Text('${room.name}'),
        //                           children: [
        //                             GestureDetector(
        //                               onTap: () async {
        //                                 List<ui.Image> capture =
        //                                     await Navigator.of(context)
        //                                         .push(
        //                                   MaterialPageRoute(
        //                                     builder: (_) =>
        //                                         CaptureThumbnail(
        //                                       imgUrl: room.imgUrl ?? '',
        //                                     ),
        //                                   ),
        //                                 );
        //                                 debugPrint(
        //                                     capture.length.toString());
        //                                 thumbnailViewBloc.add(
        //                                     ThumbnailViewReceivedCapturesEvent(
        //                                         capture: capture));
        //                                 SystemChrome
        //                                     .setPreferredOrientations([
        //                                   DeviceOrientation.portraitUp,
        //                                   // DeviceOrientation.landscapeLeft,
        //                                 ]);
        //                               },
        //                               child: Container(
        //                                 height: 150,
        //                                 width: 150,
        //                                 color: AppColors.green,
        //                                 child: Text(
        //                                     '${thumbnailViewState.capture.length}'),
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                       ))
        //                   .toList())

        //           // List.filled(10, 0)
        //           //     .map((e) => ExpansionTile(title: Text('image'),)
        //           //     .toList()),
        //           ),
        //     ),
        //   ),
        // ));
      },
    ));
  }
}
