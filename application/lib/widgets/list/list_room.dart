import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/new_post/bloc/new_post_bloc.dart';
import 'package:bk_3d_view/pages/new_post/view/image_view/bloc/image_view_bloc.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListRoom extends StatelessWidget {
  const ListRoom({
    Key? key,
    this.onTapItem,
  }) : super(key: key);

  final Function(Room)? onTapItem;
  @override
  Widget build(BuildContext context) {
    ImageViewBloc imageViewBloc = context.read<ImageViewBloc>();

    Widget itemBuilder(BuildContext context, int index) {
      return ChooseItem(
        'Phòng ${imageViewBloc.state.rooms[index].name}',
        onClick: () {
          onTapItem?.call(imageViewBloc.state.rooms[index]);
        },
      );
    }

    return BlocBuilder<ImageViewBloc, ImageViewState>(
      builder: (context, state) {
        return state.rooms.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.pageMarginHorizontal / 2,
                    vertical: AppConstants.pageMarginHorizontal / 2),
                itemBuilder: itemBuilder,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: imageViewBloc.state.rooms.length)
            : EmptyImageList(
                onBackUploadImage: () {
                  context.read<NewPostBloc>().add(NewPostJumpToEvent(
                      NewPostStep.values.indexOf(NewPostStep.image)));
                },
              );
      },
    );
  }
}
