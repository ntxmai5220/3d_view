import 'package:bk_3d_view/pages/home/bloc/home_bloc.dart';
import 'package:bk_3d_view/pages/main_page/bloc/main_page_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var section = HomeSection.values;
    // Size size = MediaQuery.of(context).size;

    bannerSection(BuildContext context) {
      return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var banners = state.banners;
            return state.banners.isNotEmpty
                ? PageView.builder(
                    controller: PageController(viewportFraction: 0.9),
                    itemCount: banners.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AppWebView(
                                  url: index == 0
                                      ? 'https://www.facebook.com/truongdhbachkhoa/'
                                      : state.banners[index].webUrl ?? ''))),
                          child: Card(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppConstants.borderRadius),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: NetImage(
                                        imageUrl: banners[index].imgUrl ?? '',
                                        width: 150,
                                        height: 150),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //         image: NetworkImage(
                                  //             banners[index].imgUrl ?? ''),
                                  //         fit: BoxFit.cover),
                                  //   ),
                                  // ),
                                  Container(
                                    color: Colors.black54,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // const SizedBox(height: 7),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 5),
                                            child: Text(
                                                banners[index].title ?? '',
                                                style: TextStyles.buttonText
                                                    .copyWith(fontSize: 30)),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  banners[index].content ?? '',
                                                  style: TextStyles
                                                      .normalContent
                                                      .copyWith(
                                                          color:
                                                              AppColors.white)),
                                            ),
                                          )
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppConstants.borderRadius)),
                            elevation: 2,
                          ),
                        ))
                : const LoadingPlaceHolder(width: 150, height: 150);
          },
        ),
      );
    }

    getHomeSection(BuildContext context, int index) {
      switch (section[index]) {
        case HomeSection.banner:
          return bannerSection(context);
        case HomeSection.newest:
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return HorizontalListMiniPost2(
                title: 'Bài đăng mới',
                list: state.newPost,
                // backgroundColor: AppColors.darkSecondary,
                // titleColor: AppColors.lightPrimary,
                onTapPost: (id) => openPostDetail(context, id: id),
                onToggleFavorite: (id, isFavorite) => context
                    .read<HomeBloc>()
                    .add(HomeToggleFavoriteEvent(
                        postId: id, isFavorite: isFavorite)),
                onMoreTap: () =>
                    context.read<MainPageBloc>().add(OnChangePage(1)),
              );
            },
          );
        case HomeSection.recent:
          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return HorizontalListMiniPost2(
                title: 'Được quan tâm',
                list: state.hotPost,
                onTapPost: (id) => openPostDetail(context, id: id),
                onToggleFavorite: (id, isFavorite) => context
                    .read<HomeBloc>()
                    .add(HomeToggleFavoriteEvent(
                        postId: id, isFavorite: isFavorite)),
                // onMoreTap: () {},
              );
            },
          );
      }
    }

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            AppConstants.appName,
            style: TextStyles.screenTitle.copyWith(color: AppColors.primary),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconActionButton(
                icon: Icons.help_outline_rounded,
                size: kToolbarHeight - 30,
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => const AppWebView(
                //         url:
                //             'https://drive.google.com/file/d/1LEsbxco45gztIyKK274tMXUi7UH0q96f/view?usp=sharing'))),
                onTap: () =>
                    showImagesFullScreen(context, images: AppConstants.manual),
                // color: AppColors.darkSecondary,
              ),
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return SmartRefresher(
              key: key,
              enablePullDown: true,
              enablePullUp: false,
              controller: context.read<HomeBloc>().controller,
              onRefresh: () =>
                  context.read<HomeBloc>().add(HomeLoadDataEvent()),
              child: state is! HomeLoadError
                  ? ListView.builder(
                      itemBuilder: getHomeSection,
                      itemCount: section.length,
                    )
                  : MyErrorWidget(
                      onTap: () =>
                          context.read<HomeBloc>().add(HomeLoadDataEvent()),
                    ),
            );
          },
        ));
  }

  openPostDetail(BuildContext context, {required String id}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PostDetail(id: id)));
  }

  toggleFavorite(BuildContext context, {String? id}) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => PostDetail(id: id ?? '')));
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
