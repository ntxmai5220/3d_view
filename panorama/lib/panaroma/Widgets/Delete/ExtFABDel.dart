import 'package:flutter/material.dart';

Widget buildExtendedDel(VoidCallback onTap, int mode) => AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
      width: 150,
      height: 50,
      child: FloatingActionButton.extended(
        backgroundColor: mode == 2 ? Colors.red : Colors.white,
        onPressed: onTap,
        icon: mode == 2 ? Icon(Icons.delete_forever ,color: Colors.black,): Icon(Icons.delete,color: Colors.black),
        label: Center(
          child: Text(
            mode == 2 ? "Cancel" : "Del Hotspot",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ),
    );
