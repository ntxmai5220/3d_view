import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/pages/post_detail/bloc/post_detail_bloc.dart';
import 'package:bk_3d_view/pages/room_detail/room_detail.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';

import 'package:bk_3d_view/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  Widget buildDataInfo(String label, {required String data, Widget? widget}) =>
      Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: widget != null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text('$label: ',
                style: TextStyles.normalLabel.copyWith(color: AppColors.black)),
            Expanded(
                child: Wrap(children: [
              Text(
                data.toString(),
                style: TextStyles.normalContent,
              ),
              widget ?? const SizedBox(),
            ]))
          ],
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.pageMarginHorizontal, vertical: 8),
      );

  Widget buildRoomItem(String? thumbnail, String name, String roomId) =>
      Builder(
        builder: (context) => GestureDetector(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => RoomDetail(roomId: roomId))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                child: NetImage(
                    imageUrl: thumbnail ?? AppConstants.noImage,
                    width: 320,
                    height: 190),
              ),
              Text(
                name,
                style: TextStyles.normalLabel,
              ),
            ],
          ),
        ),
      );
  Widget buildRoomsCarousel({required List<Room> rooms}) =>
      BlocBuilder<PostDetailBloc, PostDetailState>(
        builder: (context, state) {
          if (state is PostDetailLoaded) {
            List<Room> rooms = state.post.rooms ?? [];
            return SizedBox(
              height: 250,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, index) => buildRoomItem(
                    rooms[index].thumbnails!.isNotEmpty
                        ? rooms[index].thumbnails!.elementAt(0).imgUrl
                        : rooms[index].imgUrl,
                    rooms[index].name ?? "",
                    rooms[index].id ?? ""),
                itemCount: rooms.length,
                physics: const CustomScrollPhysics(itemDimension: 328),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          return const SizedBox();
        },
      );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostDetailRepository(),
      child: BlocProvider(
        create: (context) => PostDetailBloc(
            repository: RepositoryProvider.of<PostDetailRepository>(context))
          ..add(PostDetailLoadEvent(id: id)),
        child: Scaffold(
          appBar: MyAppBar(
              title: const AppBarTextTitle(
            title: 'Thông tin bài đăng',
            color: AppColors.white,
          )),
          // appBar: AppBar(
          //   title: const Text(
          //     "Thông tin bài đăng",
          //   ),
          //   backgroundColor: AppColors.primary,
          // ),
          body: BlocBuilder<PostDetailBloc, PostDetailState>(
            builder: (context, state) {
              if (state is PostDetailLoaded) {
                Post post = state.post;
                return ListView(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  children: [
                    buildDataInfo("Giá", data: post.price?.checkPrice ?? ''),
                    buildDataInfo(
                      "Diện tích",
                      data: post.area.toString(),
                      widget: const MSquare(style: TextStyles.normalContent),
                    ),
                    buildDataInfo("Địa chỉ", data: post.getAddress()),
                    buildDataInfo("Mô tả", data: post.desc ?? ''),
                    buildDataInfo(
                      "Loại",
                      data: '',
                      widget: buildStatusPost(post: post),
                    ),

                    // buildDataInfo("Người đăng", data: post.creatorId ?? ''),
                    buildDataInfo("Ngày đăng", data: post.getCreatedDate()),
                    UserInfor(
                      user: state.user ?? User(),
                      onTapUser: (id) => toUserProfile(context, id: id),
                    ),
                    buildRoomsCarousel(rooms: post.rooms!),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.pageMarginHorizontal,
                          vertical: 10),
                      child: MyButton(
                        "Xem ở chế độ panaroma",
                        onClick: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => ViewPanorama(rooms: post.rooms??[],))),
                        bgColor: AppColors.darkPrimary,
                      ),
                    ),
                  ],
                );
              } else if (state is PostDetailError) {
                return const MyErrorWidget();
              } else {
                return const Center(
                  child: LoadingPlaceHolder(
                      height: double.maxFinite, width: double.maxFinite),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildStatusPost({required Post post}) => Material(
        borderRadius: BorderRadius.circular(4),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color:
                  post.isRent ?? false ? AppColors.darkPrimary : AppColors.red,
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            post.getPostStatus(),
            style: TextStyles.tinyLabel.copyWith(color: AppColors.white),
          ),
        ),
      );

  toUserProfile(BuildContext context, {required String id}) {
    debugPrint(id);
  }
}
