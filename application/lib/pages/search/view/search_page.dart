import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/drawer/drawer.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    return Scaffold(
      key: globalKey,
      // endDrawerEnableOpenDragGesture: ,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const FilterDrawer(),
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
      body: SingleChildScrollView(
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
                        onToggleFavorite: (id) => onToggleFavorite(context, 0),
                      ))
                  .toList()),
        ),
      ),
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
