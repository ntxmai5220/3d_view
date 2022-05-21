import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';

import 'package:flutter/material.dart';

class ManagePost extends StatelessWidget {
  const ManagePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Tất cả', 'Hiển thị', 'Đã ẩn'];

    return DefaultTabController(
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
            child: TabBar(
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
                indicator: AppStyles.managePostIndicator),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.pageMarginHorizontal / 1.5,
                vertical: AppConstants.pageMarginHorizontal / 1.5),
            child: Wrap(
                // alignment: WrapAlignment.center,
                runSpacing: 15,
                spacing: 15,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: posts
                    .map((post) => PostItem(
                          post: post,
                          onTapPost: (id) => onClickPost(context, 0),
                          // onToggleFavorite: (id) =>
                          //     onToggleFavorite(context, 0),
                        ))
                    .toList()),
          ),
        )),
        floatingActionButton: Container(
          margin: const EdgeInsets.all(AppConstants.pageMarginHorizontal / 1.5),
          child: FloatingActionButton(
            backgroundColor: AppColors.darkPrimary,
            elevation: 10,
            onPressed: () => newPost(context),
            child: const Icon(Icons.add, size: 20),
          ),
        ),
      ),
    );
  }

  newPost(BuildContext context) {
    debugPrint('new post');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const NewPostPage()),
    );
  }

  onClickPost(BuildContext context, int index) {
    debugPrint('$index');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PostDetail(id: index.toString())),
    );
  }

  onToggleFavorite(BuildContext context, int index) {
    debugPrint('favor $index');
  }
}
