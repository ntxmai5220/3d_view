import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

class ManagePost extends StatelessWidget {
  const ManagePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> tabs = ['Tất cả', 'Hiển thị', 'Đã ẩn'];
    _newPost() {
      debugPrint('new post');
    }

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
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: tabs.map((tab) => Text(tab)).toList(),
                ),
              ),
            ],
          )),
          floatingActionButton: Container(
            margin: const EdgeInsets.all(AppConstants.pageMarginHorizontal),
            child: FloatingActionButton(
              onPressed: _newPost,
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat),
    );
  }
}
