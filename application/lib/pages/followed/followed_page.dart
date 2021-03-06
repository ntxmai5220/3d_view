import 'package:bk_3d_view/drawer/drawer.dart';
import 'package:bk_3d_view/drawer/filter/bloc/filter_drawer_bloc.dart';
import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/followed/bloc/followed_bloc.dart';
import 'package:bk_3d_view/pages/home/bloc/home_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';

import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowedPage extends StatelessWidget {
  const FollowedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    return BlocProvider(
      create: (context) => FilterDrawerBloc()
        ..add(FilterInitEvent(
            params: FilterParam(
                creatorIdNEQ: HelperSharedPreferences.savedUserId))),
      child: Scaffold(
        key: globalKey,
        // endDrawerEnableOpenDragGesture: ,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: BlocBuilder<FollowedBloc, FollowedState>(
          builder: (context, state) {
            return FilterDrawer(
                onTapFilter: (param) => context
                    .read<FollowedBloc>()
                    .add(FollowedLoadEvent(params: param)));
          },
        ),
        appBar: AppBar(
          title: Text('Đang theo dõi',
              style: TextStyles.screenTitle.copyWith(color: AppColors.primary)),
          actions: [
            BlocBuilder<FollowedBloc, FollowedState>(
              builder: (context, state) {
                return state is FollowedLoaded
                    ? IconActionButton(
                        icon: Icons.filter_list_alt,
                        iconColor: AppColors.darkSecondary,
                        padding: 10,
                        onTap: () => globalKey.currentState?.openEndDrawer(),
                      )
                    : const SizedBox();
              },
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<FollowedBloc, FollowedState>(
          listenWhen: (previous, current) {
            return (previous is FollowedLoading &&
                    current is! FollowedLoading) ||
                (previous is! FollowedLoading && current is FollowedLoading);
          },
          listener: (context, state) {
            if (state is FollowedLoading) {
              ShowMyDialog.show(context, dialog: const LoadingDialog());
            } else {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is FollowedInitial) {
              return const Center(
                child: LoadingPlaceHolder(
                    height: double.maxFinite, width: double.maxFinite),
              );
            } else if (state is FollowdNotLogin) {
              return const LoginRequired();
            } else {
              return SmartRefresher(
                key: key,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () =>
                    context.read<FollowedBloc>().add(FollowedRefreshEvent()),
                onLoading: () {
                  debugPrint('load');
                  context.read<FollowedBloc>().add(FollowedLoadMoreEvent());
                },
                controller: context.read<FollowedBloc>().refreshController,
                child: state.post.isEmpty
                    ? const EmptyImageList()
                    : SingleChildScrollView(
                        // controller:
                        //     context.read<FollowedBloc>().scrollController,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal:
                                  AppConstants.pageMarginHorizontal / 1.5,
                              vertical:
                                  AppConstants.pageMarginHorizontal / 1.5),
                          child: Wrap(
                              // alignment: WrapAlignment.center,
                              runSpacing: 15,
                              spacing: 15,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: state.post
                                  .map((post) => PostItem(
                                      post: post,
                                      onTapPost: (id) =>
                                          onClickPost(context, id),
                                      onToggleFavorite: (id) =>
                                          onToggleFavorite(context, id,
                                              isFavorite:
                                                  post.isFavorite ?? false)))
                                  .toList()),
                        ),
                      ),
              );
            }
          },
        ),
      ),
    );
  }

  onClickPost(BuildContext context, String id) {
    debugPrint(id);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PostDetail(id: id)),
    );
  }

  onToggleFavorite(BuildContext context, String id,
      {required bool isFavorite}) {
    //  con
    context
        .read<FollowedBloc>()
        .add(FollowedToggleFavoriteEvent(postId: id, isFavorite: isFavorite));
    context
        .read<HomeBloc>()
        .add(HomeToggleFromOther(postId: id, isFavorite: isFavorite));
    // var home1 = homeState.newPost.indexWhere((element) => element.id == id);
    // var home2 = homeState.hotPost.indexWhere((element) => element.id == id);
    // if (home1 != -1) homeState.newPost[home1].isFavorite = false;
    // homeState.hotPost[home2].isFavorite = false;
  }
}
