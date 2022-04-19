import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void toProfile() {
      debugPrint('Profile');
    }

    void toPostManagement() {
      debugPrint('Management');
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ManagePost()));
    }

    List<Map<String, dynamic>> items = [
      {'label': 'Thông tin cá nhân', 'funct': toProfile},
      {'label': 'Quản lý bài đăng', 'funct': toPostManagement},
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Container(height: 10, color: Colors.white),
            Stack(
              children: [
                Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            AppColors.white80, BlendMode.srcOver),
                        image: AssetImage(AppAssets.background),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  left: AppConstants.pageMarginHorizontal,
                  top: 0,
                  bottom: 0,
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.appLogo,
                        height: AppConstants.logoSize,
                        width: AppConstants.logoSize,
                      ),
                      const SizedBox(width: 20),
                      Text(AppConstants.appName,
                          style: TextStyles.screenTitle
                              .copyWith(color: AppColors.primary))
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.separated(
                  // physics: const NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.pageMarginHorizontal,
                      vertical: 15),
                  itemBuilder: (context, index) {
                    return ChooseItem(items[index]['label'],
                        onClick: items[index]['funct']);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: items.length),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.pageMarginHorizontal,
                    vertical: 15),
                child: MyButton('Đăng xuất',
                    bgColor: AppColors.red, onClick: () {}))
          ],
        ),
      ),
    );
  }
}
