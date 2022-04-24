import 'package:flutter/material.dart';

Widget ExtObjectFAB(VoidCallback onTap, int mode) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        backgroundColor: mode == 3 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: mode == 1 ? Icon(Icons.close  ,color: Colors.black): Icon(Icons.add  ,color: Colors.black),
        label: Center(
          child: Text(
            mode == 3 ?  "Cancel": "Object toolkit" ,
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ),
    );
