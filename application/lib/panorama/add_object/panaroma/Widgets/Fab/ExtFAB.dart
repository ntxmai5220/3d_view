import 'package:flutter/material.dart';

Widget buildExtendedFAB(VoidCallback onTap, int mode) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        heroTag: "addExt",
        backgroundColor: mode == 1 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: mode == 1 ? Icon(Icons.close  ,color: Colors.black): Icon(Icons.add  ,color: Colors.black),
        label: Center(
          child: Text(
            mode == 1 ?  "Cancel": "Add Hotspot" ,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ),
    );
