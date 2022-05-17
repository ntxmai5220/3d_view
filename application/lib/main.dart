import 'package:bk_3d_view/pages/admin/admin.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/pages/room_detail/room_detail.dart';
import 'package:bk_3d_view/panorama/add_object/testPana.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
  // runApp(const MyApp());
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
          textTheme: const TextTheme(bodyMedium: TextStyles.normalContent, bodySmall: TextStyles.tinyLabel),
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
                maxHeight: 48,
                minHeight: 48,
                maxWidth: 48,
                minWidth: 48,
              ),
              backgroundColor: AppColors.darkPrimary)),
      home: MyHomePage(title: "1232",),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    // TODO: implement onClose
    print(bloc);
    super.onClose(bloc);
  }
}
