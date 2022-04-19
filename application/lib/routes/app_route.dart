import 'package:auto_route/annotations.dart';
import 'package:bk_3d_view/pages/pages.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'app',
  routes: <AutoRoute>[
    AutoRoute(page: MainPage, initial: true),
    AutoRoute(page: HomePage),
    AutoRoute(page: SearchPage),
    AutoRoute(page: FollowedPage),
  ],
)

// @MaterialAutoRouter(
//   replaceInRouteName: 'post',
//   routes: <AutoRoute>[
//     AutoRoute(page: MainPage, initial: true),
//     AutoRoute(page: BookDetailsPage),
//   ],
// )
class AppRouter{}
