import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '3D VIEW',
        theme: ThemeData(
            tabBarTheme: const TabBarTheme(
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.darkSecondary,
            ),
            textTheme: const TextTheme(bodyMedium: TextStyles.normalContent),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppConstants.borderRadius))),
                backgroundColor: Colors.white,
                titleTextStyle: TextStyles.normalContent,
                contentTextStyle: TextStyles.tinyContent),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: AppColors.primary,
                linearTrackColor: AppColors.lightPrimary),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.darkPrimary,
              size: 24,
            ),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                sizeConstraints: BoxConstraints(
                  maxHeight: 46,
                  minHeight: 46,
                  maxWidth: 46,
                  minWidth: 46,
                ),
                backgroundColor: AppColors.darkPrimary)),
        home: const MainPage(),
        routes: {'main': (_) => const MainPage()});
  }
}
