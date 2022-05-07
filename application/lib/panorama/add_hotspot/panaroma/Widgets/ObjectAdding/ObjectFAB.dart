import 'package:flutter/material.dart';

Widget ObjectFAB (VoidCallback onTap , int mode) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        heroTag: "objectAddExt",
        backgroundColor: mode == 3 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: mode ==31 ? Icon(Icons.close  ,color: Colors.black): Icon(Icons.add  ,color: Colors.black) ,
        ),
        label: SizedBox(),
      ),
    );
