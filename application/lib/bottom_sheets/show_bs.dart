//show BS
import 'package:flutter/material.dart';

class ShowBottomSheet {
  static Future<dynamic> showBS(BuildContext context,
          {required Widget child}) =>
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return child;
        },
      );
}
