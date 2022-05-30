import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/manage_post/bloc/manage_post_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ManagePost extends StatelessWidget {
  const ManagePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Tất cả', 'Hiển thị', 'Đã ẩn'];
    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => ManagePostRepository(),
      child: BlocProvider(
        create: (context) =>
            ManagePostBloc(repository: RepositoryProvider.of(context))
              ..add(ManagePostLoadEvent(
                  params: FilterParam(
                      creatorIdEQ: HelperSharedPreferences.savedUserId))),
        child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.darkPrimary,
              iconTheme: Theme.of(context).iconTheme,
              title: Text(
                'Quản lý bài đăng',
                style: TextStyles.labelTopic.copyWith(color: AppColors.white),
              ),
              leading: const BackLeading(),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(35),
                child: BlocBuilder<ManagePostBloc, ManagePostState>(
                  builder: (context, state) {
                    return TabBar(
                      labelPadding: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.all(0),
                      indicatorPadding: const EdgeInsets.all(0),
                      indicatorColor: AppColors.lightPrimary,
                      tabs: tabs
                          .map((tab) => Tab(
                                text: tab,
                                height: 35,
                                iconMargin: const EdgeInsets.all(0),
                              ))
                          .toList(),
                      unselectedLabelColor: AppColors.secondary,
                      unselectedLabelStyle:
                          TextStyles.normalContent.copyWith(fontSize: 15),
                      labelColor: AppColors.darkPrimary,
                      labelStyle: TextStyles.normalLabel,
                      indicator: AppStyles.managePostIndicator,
                      onTap: (index) => context
                          .read<ManagePostBloc>()
                          .add(ManagePostChangeTabEvent(index: index)),
                    );
                  },
                ),
              ),
            ),
            body: BlocConsumer<ManagePostBloc, ManagePostState>(
              listenWhen: (previous, current) {
                return (previous is ManagePostLoading &&
                        current is! ManagePostLoading) ||
                    (previous is! ManagePostLoading &&
                        current is ManagePostLoading);
              },
              listener: (context, state) {
                if (state is ManagePostLoading) {
                  ShowMyDialog.show(context, dialog: const LoadingDialog());
                } else {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is ManagePostInitial) {
                  return const Center(
                    child: LoadingPlaceHolder(
                        height: double.maxFinite, width: double.maxFinite),
                  );
                } else {
                  return SmartRefresher(
                      controller:
                          context.read<ManagePostBloc>().refreshController,
                      key: key,
                      enablePullDown: true,
                      enablePullUp: true,
                      onRefresh: () => context
                          .read<ManagePostBloc>()
                          .add(ManagePostRefreshEvent()),
                      onLoading: () {
                        debugPrint('load');
                        context
                            .read<ManagePostBloc>()
                            .add(ManagePostLoadMoreEvent());
                      },
                      child: state.post.isEmpty
                          ? const EmptyImageList()
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                  vertical:
                                      AppConstants.pageMarginHorizontal / 1.5),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15),
                              itemCount: state.post.length,
                              itemBuilder: (context, index) => itemBuilder(
                                  context, index,
                                  width: size.width),
                            ));
                }
              },
            ),
            // floatingActionButton: Container(
            //   margin:
            //       const EdgeInsets.all(AppConstants.pageMarginHorizontal / 1.5),
            //   child: FloatingActionButton(
            //     backgroundColor: AppColors.darkPrimary,
            //     elevation: 10,
            //     onPressed: () => newPost(context),
            //     child: const Icon(Icons.add, size: 20),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }

  itemBuilder(BuildContext context, int index, {required double width}) {
    ScrollController scrollController = ScrollController();
    Post post = context.read<ManagePostBloc>().state.post[index];
    return SizedBox(
      height: 380,
      child: ListView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: CustomScrollPhysics(itemDimension: width),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.pageMarginHorizontal / 1.5,
        ),
        children: [
          SizedBox(
            width: width - AppConstants.pageMarginHorizontal / 1.5 * 2,
            child: PostItem(
              post: post,
              onTapPost: (id) => onClickPost(context, id: id),
            ),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
            margin: const EdgeInsets.only(
                left: AppConstants.pageMarginHorizontal / 1.5),
            child: InkWell(
              onTap: () {
                context
                    .read<ManagePostBloc>()
                    .add(ManagePostDeleteEvent(postId: post.id ?? ''));
                // await Future.delayed(Duration(seconds: 1));
                scrollController.jumpTo(0);
              },
              radius: AppConstants.borderRadius,
              child: const Center(
                  child: IconActionButton(
                icon: Icons.delete_forever_rounded,
                iconColor: AppColors.white80,
                size: 32,
              )),
            ),
          ),
        ],
      ),
    );
  }

  newPost(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewPostPage()),
    );
  }

  onClickPost(BuildContext context, {required String id}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PostDetail(id: id)),
    );
  }

  onToggleFavorite(BuildContext context, int index) {}
}
