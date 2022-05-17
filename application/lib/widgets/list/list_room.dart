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
    NewPostBloc bloc = context.read<NewPostBloc>();

    Widget itemBuilder(BuildContext context, int index) {
      debugPrint(bloc.state.post!.rooms![index].id.toString());
      return ChooseItem(
        '${bloc.state.post?.rooms?[index].name}',
        onClick: () {
          onTapItem?.call(bloc.state.post!.rooms![index]);
        },
      );
    }

    return BlocBuilder<NewPostBloc, NewPostState>(
      builder: (context, state) {
        var list = state.post?.rooms;
        print(list?.length);
        return list != null && list.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.pageMarginHorizontal / 2,
                    vertical: AppConstants.pageMarginHorizontal / 2),
                itemBuilder: itemBuilder,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: list.length)
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
