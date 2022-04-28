//show BS
import 'package:bk_3d_view/bottom_sheets/bottom_sheets.dart';
import 'package:flutter/material.dart';

class ShowBottomSheet {
  static Future showBS(BuildContext context) => showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const AddImageBS();
        },
      );
}
