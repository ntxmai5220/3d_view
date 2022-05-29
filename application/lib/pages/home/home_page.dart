import 'package:bk_3d_view/pages/home/bloc/home_bloc.dart';
import 'package:bk_3d_view/pages/main_page/bloc/main_page_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => AppWebView(
                                      url: state.banners[index].webUrl ?? ''))),
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
          title: Text(
            AppConstants.appName,
            style: TextStyles.screenTitle.copyWith(color: AppColors.primary),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.more_vert_rounded,
                size: kToolbarHeight - 30,
                color: AppColors.darkSecondary,
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
              child: ListView.builder(
                itemBuilder: getHomeSection,
                itemCount: section.length,
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
}
