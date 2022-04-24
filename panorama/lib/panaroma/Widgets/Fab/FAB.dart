import 'package:flutter/material.dart';

Widget buildFAB (VoidCallback onTap , int mode) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        backgroundColor: mode == 1 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: mode == 1 ? Icon(Icons.close  ,color: Colors.black): Icon(Icons.add  ,color: Colors.black) ,
        ),
        label: SizedBox(),
      ),
    );
