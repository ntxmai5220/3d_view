import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/drawer/drawer.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:bk_3d_view/values/app_constants.dart';
import 'package:bk_3d_view/values/app_styles.dart';
import 'package:bk_3d_view/widgets/button/icon_action_button.dart';
import 'package:bk_3d_view/widgets/post_item.dart';
import 'package:flutter/material.dart';

class FollowedPage extends StatelessWidget {
  const FollowedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> globalKey = GlobalKey();
    return Scaffold(
      key: globalKey,
      // endDrawerEnableOpenDragGesture: ,
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const FilterDrawer(),
      appBar: AppBar(
        title: Text('Đang theo dõi',
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
                children: posts.reversed
                    .map((post) => PostItem(
                          post: post,
                          onTapPost: (id) => onClickPost(context, 0),
                          onToggleFavorite: (id) =>
                              onToggleFavorite(context, 0),
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
