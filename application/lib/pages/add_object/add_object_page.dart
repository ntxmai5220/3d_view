import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/add_object/bloc/add_object_bloc.dart';
import 'package:bk_3d_view/panorama/packages.dart';

import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bk_3d_view/widgets/app_bar/app_bar_text_title.dart';
import 'package:bk_3d_view/widgets/app_bar/back_leading.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddObjectPage extends StatelessWidget {
  const AddObjectPage({
    Key? key,
    required this.room,
  }) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddObjectBloc(),
      child: BlocBuilder<AddObjectBloc, AddObjectState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: AppBarTextTitle(title: room.name ?? ''),
                leading: const BackLeading(
                  color: AppColors.primary,
                ),
                actions: room.removedImg != null &&
                        room.removedImg!.imgUrl!.isNotEmpty
                    ? [
                        IconActionButton(
                          icon: Icons.compare_rounded,
                          iconColor: AppColors.primary,
                          onTap: () => context
                              .read<AddObjectBloc>()
                              .add(AddObjectChangeBackgroundEvent()),
                          padding: 8,
                        )
                      ]
                    : null,
              ),
              body: AddObject(
                child: Image(
                    image: CachedNetworkImageProvider(
                        state.background == BackgroundType.origin
                            ? room.imgUrl ?? ''
                            : room.removedImg?.imgUrl ?? '')),
              ));
        },
      ),
    );
  }
}
