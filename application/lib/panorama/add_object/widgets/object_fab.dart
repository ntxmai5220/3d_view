import 'package:flutter/material.dart';

Widget objectFAB(VoidCallback onTap, int mode) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        heroTag: "objectAddExt",
        backgroundColor: mode == 3 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Center(
              child: Icon(mode == 3 ? Icons.close : Icons.add,
                  color: Colors.black),
            )),
        label: const SizedBox(),
      ),
    );
