import 'package:flutter/material.dart';

class ShowMyDialog {
  static Future<dynamic> show(BuildContext context,
          {required Widget dialog}) async =>
      await showDialog(
          barrierDismissible: false, context: context, builder: (_) => dialog);
}
