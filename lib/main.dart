import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '3D VIEW',
        theme: ThemeData(
            iconTheme: const IconThemeData(color: AppColors.primary),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: AppColors.primary)),
        home: const MainPage(),
        routes: {'main': (_) => const MainPage()});
  }
}
