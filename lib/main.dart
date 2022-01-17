import 'package:bk_3d_view/blocs/blocs.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        theme: ThemeData(backgroundColor: Colors.white),
        home: const LoginPage(),
        routes: {
          'main': (_) => BlocProvider(
                create: (context) => MainPageBloc(),
                child: const MainPage(),
              )
        });
  }
}
