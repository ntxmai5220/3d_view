import 'package:bk_3d_view/data/mock.dart';
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
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadius),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(bannerRaw[index]["imgUrl"]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const SizedBox(height: 7),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 5),
                                  child: Text(bannerRaw[index]["title"],
                                      style: TextStyles.buttonText
                                          .copyWith(fontSize: 32)),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(bannerRaw[index]["content"],
                                        style: TextStyles.normalContent
                                            .copyWith(color: AppColors.white)),
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
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
            list: List.filled(8, 1),
            // backgroundColor: AppColors.darkSecondary,
            // titleColor: AppColors.lightPrimary,
            onTapPost: (id) => openPostDetail(context, id: id),
            onToggleFavorite: (id) => toggleFavorite(context, id: id),
          );
        case HomeSection.recent:
          return HorizontalListMiniPost2(
            title: 'Được quan tâm',
            list: List.filled(8, 1),
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
