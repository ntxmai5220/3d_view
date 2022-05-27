import 'package:bk_3d_view/values/values.dart';
import 'package:flutter/material.dart';

Widget extObjectFAB(VoidCallback onTap, int mode) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 120,
      height: 50,
      child: FloatingActionButton.extended(
        heroTag: "addObject",
        backgroundColor: mode == 3 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: mode == 3
            ? const Icon(Icons.close, color: Colors.black)
            : const Icon(Icons.add, color: Colors.black),
        label: Center(
          child: Text(
            mode == 3 ? "Hủy" : "Thêm",
            style: TextStyles.normalLabel.copyWith(color: AppColors.black),
          ),
        ),
      ),
    );
