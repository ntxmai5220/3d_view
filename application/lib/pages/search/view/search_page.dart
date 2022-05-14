import 'package:bk_3d_view/drawer/drawer.dart';
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
    );
  }
}
