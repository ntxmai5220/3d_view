import 'package:flutter/material.dart';

Widget buildDel (VoidCallback onTap , int mode) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 50,
      height: 50,
      child: FloatingActionButton.extended(
        heroTag: "del",
        backgroundColor: mode == 2 ? Colors.red :  Colors.white,
        onPressed: onTap,
        icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: mode == 2 ? Icon(Icons.delete_forever  ,color: Colors.black): Icon(Icons.delete  ,color: Colors.black) ,
        ),
        label: SizedBox(),
      ),
    );
