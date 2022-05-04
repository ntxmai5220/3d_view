import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var section = HomeSection.values;
    // Size size = MediaQuery.of(context).size;

    bannerSection(BuildContext context) {
      return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: PageView.builder(
            controller: PageController(viewportFraction: 0.9),
            itemCount: 3,
            itemBuilder: (context, index) => Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadius),
                      image: const DecorationImage(
                          image: AssetImage(AppAssets.background),
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                        child: Text('Banner $index',
                            style:
                                TextStyles.buttonText.copyWith(fontSize: 32))),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderRadius)),
                  elevation: 2,
                )),
      );
    }

    getHomeSection(BuildContext context, int index) {
      switch (section[index]) {
        case HomeSection.banner:
          return bannerSection(context);
        case HomeSection.newest:
          return HorizontalListMiniPost2(
            title: 'Bài đăng mới',
            list: List.filled(10, 1),
            // backgroundColor: AppColors.darkSecondary,
            // titleColor: AppColors.lightPrimary,
            onTapPost: (id) => openPostDetail(context, id: id),
            onToggleFavorite: (id) => toggleFavorite(context, id: id),
          );
        case HomeSection.recent:
          return HorizontalListMiniPost2(
            title: 'Đã xem gần đây',
            list: List.filled(10, 1),
            onTapPost: (id) => openPostDetail(context, id: id),
            onToggleFavorite: (id) => toggleFavorite(context, id: id),
          );
      }
    }

    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            AppConstants.appName,
            style: TextStyles.screenTitle.copyWith(color: AppColors.primary),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(3.0),
              child: Icon(
                Icons.more_vert_rounded,
                size: kToolbarHeight - 30,
                color: AppColors.darkSecondary,
              ),
            )
          ],
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemBuilder: getHomeSection,
          itemCount: section.length,
        ));
  }

  openPostDetail(BuildContext context, {String? id}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PostDetail(id: id ?? '')));
  }

  toggleFavorite(BuildContext context, {String? id}) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => PostDetail(id: id ?? '')));
  }
}
