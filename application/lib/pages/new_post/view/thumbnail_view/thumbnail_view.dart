import 'package:bk_3d_view/pages/new_post/blocs.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/capture_thumbanail.dart/capture_thumbnail.dart';

class ThumbnailView extends StatelessWidget {
  const ThumbnailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageViewBloc imageViewBloc = context.read<ImageViewBloc>();
    return BlocBuilder<ImageViewBloc, ImageViewState>(
      builder: (context, state) {
        return SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: AppColors.secondary,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.pageMarginHorizontal / 1.5,
                      vertical: AppConstants.pageMarginHorizontal / 1.5),
                  child: Wrap(
                      // alignment: WrapAlignment.center,
                      runSpacing: 15,
                      runAlignment: WrapAlignment.start,
                      spacing: 15,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: imageViewBloc.state.rooms
                          .map((room) => SizedBox(
                                width: 400,
                                child: ExpansionTile(
                                  title: Text('${room.name}'),
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    CaptureThumbnail(
                                                      imgUrl: room.imgUrl ?? '',
                                                    )));
                                        SystemChrome.setPreferredOrientations([
                                          DeviceOrientation.portraitUp,
                                          // DeviceOrientation.landscapeLeft,
                                        ]);
                                      },
                                      child: Container(
                                        height: 150,
                                        color: AppColors.green,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList())

                  // List.filled(10, 0)
                  //     .map((e) => ExpansionTile(title: Text('image'),)
                  //     .toList()),
                  ),
            ),
          ),
        ));
      },
    );
  }
}
