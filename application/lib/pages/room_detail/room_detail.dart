import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/pages/room_detail/bloc/room_detail_bloc.dart';

import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomDetail extends StatelessWidget {
  final String roomId;

  const RoomDetail({Key? key, required this.roomId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => RoomDetailRepository(),
      child: BlocProvider(
        create: (context) => RoomDetailBloc(
            repository: RepositoryProvider.of<RoomDetailRepository>(context))
          ..add(RoomDetailInitEvent(roomId: roomId)),
        child: Scaffold(
            appBar: AppBar(
              title: BlocBuilder<RoomDetailBloc, RoomDetailState>(
                builder: (context, state) {
                  return AppBarTextTitle(
                    color: AppColors.white,
                    title:
                        state is RoomDetailLoaded ? state.room.name ?? '' : '',
                  );
                },
              ),
              backgroundColor: AppColors.primary,
              leading: const BackLeading(),
            ),
            body: BlocBuilder<RoomDetailBloc, RoomDetailState>(
                builder: (context, state) {
              if (state is RoomDetailLoaded) {
                return ListView(
                  children: [
                    if (state.room.imgUrl != null &&
                        state.room.imgUrl!.isNotEmpty)
                      buildImg(
                        size,
                        url: state.room.imgUrl!,
                        title: 'Ảnh panorama',
                        onTapImg: (url) =>
                            showImageFullScreen(context, url: url),
                      ),
                    if (state.room.removedImg != null &&
                        state.room.removedImg!.imgUrl!.isNotEmpty)
                      buildImg(
                        size,
                        url: state.room.removedImg!.imgUrl!,
                        title: 'Ảnh khi xóa một số thành phần',
                        onTapImg: (url) =>
                            showImageFullScreen(context, url: url),
                      ),
                    if (state.room.thumbnails != null &&
                        state.room.thumbnails!.isNotEmpty)
                      listThumbnail(
                        thumbnails: state.room.thumbnails!,
                        onTapImg: (index) => showImagesFullScreen(
                          context,
                          images: state.room.thumbnails!
                              .map((thumbnail) => thumbnail.imgUrl ?? '')
                              .toList(),
                          currentPage: index,
                        ),
                      ),
                    // const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.pageMarginHorizontal,
                        vertical: AppConstants.pageMarginHorizontal,
                      ),
                      child: MyButton(
                        'Đặt vật thể',
                        onClick: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) =>
                                    AddObjectPage(room: state.room))),
                        bgColor: AppColors.primary,
                      ),
                    )
                  ],
                );
              } else if (state is RoomDetailError) {
                return const MyErrorWidget();
              } else {
                return const Center(
                  child: LoadingPlaceHolder(
                      height: double.maxFinite, width: double.maxFinite),
                );
              }
            })),
      ),
    );
  }

  Widget buildThumbnail(
    String? thumbnail, {
    Function()? onTapImg,
  }) =>
      Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            if (thumbnail != null) {
              onTapImg?.call();
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            child: NetImage(
                imageUrl: thumbnail ?? AppConstants.noImage,
                width: 320,
                height: 190),
          ),
        ),
      );
      
  Widget listThumbnail({
    required List<Img> thumbnails,
    Function(int)? onTapImg,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              'Danh sách thumbnails',
              style: TextStyles.buttonText.copyWith(
                color: AppColors.darkSecondary,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              physics: const CustomScrollPhysics(itemDimension: 328),
              itemBuilder: (context, index) => buildThumbnail(
                  thumbnails[index].imgUrl,
                  onTapImg: () => onTapImg?.call(index)),
              itemCount: thumbnails.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );

  Widget buildImg(
    Size size, {
    required String url,
    required String title,
    Function(String)? onTapImg,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            title,
            style: TextStyles.buttonText.copyWith(
              color: AppColors.darkSecondary,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onTapImg?.call(url),
          child: SizedBox(
            width: double.maxFinite,
            height: size.width / 2,
            child: NetImage(
              height: double.maxFinite,
              width: double.maxFinite,
              imageUrl: url,
              fit: BoxFit.contain,
            ),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: CachedNetworkImageProvider(url), fit: BoxFit.contain),
            // ),
          ),
        )
      ],
    );
  }

  showImageFullScreen(BuildContext context, {required String url}) {
    debugPrint(url);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: AppColors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  // key: globalKey,
                  child: Container(
                    // padding: const EdgeInsets.all(15),
                    color: Colors.white12,
                    child: InteractiveViewer(
                        child: NetImage(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      imageUrl: url,
                      fit: BoxFit.contain,
                    )),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 20,
                    child: IconActionButton(
                      background: AppColors.black.withOpacity(0.7),
                      padding: 2,
                      size: 30,
                      icon: Icons.fullscreen_exit_rounded,
                      onTap: () {
                        Navigator.of(context).pop();
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);
                      },
                    ))
              ],
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  showImagesFullScreen(
    BuildContext context, {
    required List<String> images,
    int currentPage = 0,
  }) {
    // debugPrint(url);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                      // key: globalKey,
                      child: PageView.builder(
                    controller: PageController(initialPage: currentPage),
                    itemCount: images.length,
                    itemBuilder: (context, index) => InteractiveViewer(
                        child: NetImage(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      imageUrl: images[index],
                      fit: BoxFit.contain,
                    )),
                  )),
                  Positioned(
                      bottom: 15,
                      right: 15,
                      child: IconActionButton(
                        background: AppColors.black.withOpacity(0.7),
                        padding: 2,
                        size: 28,
                        icon: Icons.fullscreen_exit_rounded,
                        onTap: () {
                          Navigator.of(context).pop();
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                          ]);
                        },
                      ))
                ],
              ),
            ),
          );
        },
        fullscreenDialog: true,
      ),
    );
    if (images.length > 1) {
      bool popupIsActive = true;

      Future.delayed(const Duration(seconds: 2), () {
        if (popupIsActive) Navigator.of(context).pop();
      });
      showDialog(
          context: context,
          builder: (context) {
            return DialogWrap(
                bgColor: AppColors.black.withOpacity(0.65),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.swipe_rounded,
                        size: 48,
                        color: AppColors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Trượt sang trái hoặc phải để xem ảnh khác',
                        textAlign: TextAlign.center,
                        style: TextStyles.buttonText
                            .copyWith(color: AppColors.white),
                      ),
                    )
                  ],
                ));
          }).then((_) {
        popupIsActive = false;
      });
    }
  }
}
