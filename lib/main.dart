import 'package:bk_3d_view/pages/login_page.dart';
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
      title: 'Test branch Nam',
      theme: ThemeData(backgroundColor: Colors.white),
      home: const LoginPage(),
    );
  }
}
