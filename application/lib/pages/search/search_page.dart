import 'package:bk_3d_view/drawer/drawer.dart';
import 'package:bk_3d_view/drawer/filter/bloc/filter_drawer_bloc.dart';
import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/filter_param/filter_param.dart';
import 'package:bk_3d_view/pages/home/bloc/home_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/pages/search/bloc/search_bloc.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    return BlocProvider(
      create: (context) =>
          FilterDrawerBloc()..add(FilterInitEvent(params: FilterParam(creatorIdNEQ: HelperSharedPreferences.savedUserId))),
      child: Scaffold(
        key: globalKey,
        // endDrawerEnableOpenDragGesture: ,
        endDrawerEnableOpenDragGesture: false,
        endDrawer: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return FilterDrawer(
              onTapFilter: (param) => context
                  .read<SearchBloc>()
                  .add(SearchLoadEvent(params: param)),
            );
          },
        ),
        appBar: AppBar(
          title: Text('Tìm kiếm',
              style: TextStyles.screenTitle.copyWith(color: AppColors.primary)),
          actions: [
            IconActionButton(
              icon: Icons.filter_list_alt,
              iconColor: AppColors.darkSecondary,
              padding: 10,
              onTap: () => globalKey.currentState?.openEndDrawer(),
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: BlocConsumer<SearchBloc, SearchState>(
          listenWhen: (previous, current) {
            return (previous is SearchLoading && current is! SearchLoading) ||
                (previous is! SearchLoading && current is SearchLoading);
          },
          listener: (context, state) {
            if (state is SearchLoading) {
              ShowMyDialog.show(context, dialog: const LoadingDialog());
            } else {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is SearchInitial) {
              return const Center(
                child: LoadingPlaceHolder(
                    height: double.maxFinite, width: double.maxFinite),
              );
            } else {
              return SmartRefresher(
                key: key,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () =>
                    context.read<SearchBloc>().add(SearchRefreshEvent()),
                onLoading: () {
                  debugPrint('load');
                  context.read<SearchBloc>().add(SearchLoadMoreEvent());
                },
                controller: context.read<SearchBloc>().refreshController,
                child: state.post.isEmpty
                    ? const EmptyImageList()
                    : SingleChildScrollView(
                        // controller:
                        //     context.read<SearchBloc>().scrollController,
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
                                          onClickPost(context, id: id),
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

  onClickPost(BuildContext context, {required String id}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PostDetail(id: id)),
    );
  }

  onToggleFavorite(BuildContext context, String id,
      {required bool isFavorite}) {
    //  con
    context
        .read<SearchBloc>()
        .add(SearchToggleFavoriteEvent(postId: id, isFavorite: isFavorite));
    context
        .read<HomeBloc>()
        .add(HomeToggleFromOther(postId: id, isFavorite: isFavorite));
    // var home1 = homeState.newPost.indexWhere((element) => element.id == id);
    // var home2 = homeState.hotPost.indexWhere((element) => element.id == id);
    // if (home1 != -1) homeState.newPost[home1].isFavorite = false;
    // homeState.hotPost[home2].isFavorite = false;
  }
}
