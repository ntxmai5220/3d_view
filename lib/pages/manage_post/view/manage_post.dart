import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';

import 'package:flutter/material.dart';

class ManagePost extends StatelessWidget {
  const ManagePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Tất cả', 'Hiển thị', 'Đã ẩn'];

    Room room = Room(id: 1, img: AppConstants.noImage);
    Province province = Province(name: 'Tien Giang');
    District district = District(name: 'TP. My Tho');
    Ward ward = Ward(name: 'Phuong 1');
    Post post = Post(
      id: 'a',
      area: 120,
      price: 900,
      desc: 'description',
      address: '55/12 duong Hung Vuong',
      province: province,
      district: district,
      ward: ward,
      rooms: [room],
    );
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            'Quản lý bài đăng',
            style: AppStyles.buttonText.copyWith(color: AppColors.primary),
          ),
          bottom: TabBar(
              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              unselectedLabelColor: AppColors.darkSecondary,
              labelColor: AppColors.primary,
              labelStyle: AppStyles.normalLabel,
              indicator: AppStyles.managePostIndicator),
        ),
        body: SafeArea(
            child: Column(
          children: [
            // const SizedBox(height: 10),
            Expanded(
                // child: TabBarView(
                //   children: tabs.map((tab) => Text(tab)).toList(),
                // ),
                child: ListView.builder(
                    itemCount: 5,
                    //item
                    itemBuilder: (context, index) => PostItem(
                          post: post,
                          onClick: () => onClickPost(context, index),
                          onToggleFavorite: () =>
                              onToggleFavorite(context, index),
                        ))),
          ],
        )),
        floatingActionButton: Container(
          margin: const EdgeInsets.all(AppConstants.pageMarginHorizontal),
          child: FloatingActionButton(
            backgroundColor: AppColors.darkPrimary,
            elevation: 10,
            onPressed: () => newPost(context),
            child: const Icon(Icons.add),
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
