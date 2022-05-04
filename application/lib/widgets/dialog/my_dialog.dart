import 'package:flutter/material.dart';

class ShowMyDialog {
  static show(BuildContext context, {required Widget dialog}) => showDialog(
      barrierDismissible: false, context: context, builder: (_) => dialog);

  
}
