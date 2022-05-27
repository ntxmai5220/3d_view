import 'package:bk_3d_view/bottom_sheets/bottom_sheets.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/view_panorama/bloc/view_panorama_bloc.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/module.dart';

import 'package:panorama/panorama.dart';

class ViewPanorama extends StatelessWidget {
  const ViewPanorama({
    Key? key,
    required this.rooms,
  }) : super(key: key);
  final List<Room> rooms;
  @override
  Widget build(BuildContext context) {
    var type = HotspotType.values;

    return RepositoryProvider(
      create: (context) => ViewPanoramaRepository(),
      child: BlocProvider(
        create: (context) => ViewPanoramaBloc(
            repository: RepositoryProvider.of<ViewPanoramaRepository>(context))
          ..add(ViewPanoramInitEvent(rooms: rooms)),
        child: BlocConsumer<ViewPanoramaBloc, ViewPanoramaState>(
          listenWhen: (previous, current) {
            return (previous is ViewPanoramaLoading &&
                    current is! ViewPanoramaLoading) ||
                (previous is! ViewPanoramaLoading &&
                    current is ViewPanoramaLoading);
          },
          listener: (context, state) {
            if (state is ViewPanoramaLoading) {
              ShowMyDialog.show(context, dialog: const LoadingDialog());
            } else {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is ViewPanoramaInitial) {
              return const LoadingPlaceHolder(
                  width: double.maxFinite, height: double.maxFinite);
            }
            return Scaffold(
              appBar: MyAppBar(
                title: AppBarTextTitle(
                  title: state.rooms[state.currentRoom].name ?? '',
                  color: AppColors.white,
                ),
                actions: [
                  IconActionButton(
                    icon: Icons.change_circle_rounded,
                    iconColor: AppColors.white,
                    padding: 8,
                    onTap: () async {
                      Room? nextRoom = await ShowBottomSheet.showBS(context,
                          child: ChooseRoomBS(
                            rooms: [...rooms]..removeAt(state.currentRoom),
                          ));
                      if (nextRoom != null) {
                        context.read<ViewPanoramaBloc>().add(
                            ViewPanoramaChangeByIdEvent(id: nextRoom.id ?? ''));
                      }
                    },
                  )
                ],
              ),
              body: Panorama(
                  animSpeed: 3.5,
                  child: Image(
                      image: CachedNetworkImageProvider(
                          state.rooms[state.currentRoom].imgUrl!)),
                  hotspots: state.rooms[state.currentRoom].hotspots
                          ?.map((item) => Hotspot(
                              name: item.title,
                              type: type[item.type ?? 0],
                              latitude: item.latitude!,
                              longitude: item.longitude!,
                              content: item.content,
                              onTap: () {
                                if (type[item.type ?? 0] == HotspotType.infor) {
                                  ShowMyDialog.show(context,
                                      dialog: InforDialog(
                                        content: item.content!,
                                      ));
                                } else {
                                  context.read<ViewPanoramaBloc>().add(
                                      ViewPanoramaChangeByIdEvent(
                                          id: item.nextRoom ?? ''));
                                }
                              }))
                          .toList() ??
                      []
                  // lists
                  //     .map((item) => Hotspot(
                  //         name: item.title,
                  //         type: type[item.type ?? 0],
                  //         latitude: item.latitude!,
                  //         longitude: item.longitude!,
                  //         content: item.content,
                  //         onTap: () {
                  //           if (type[item.type ?? 0] == HotspotType.infor) {
                  //             ShowMyDialog.show(context,
                  //                 dialog: InforDialog(
                  //                   content: item.content!,
                  //                 ));
                  //           } else {}
                  //         }))
                  //     .toList(),
                  ),
            );
          },
        ),
      ),
    );
  }
}
