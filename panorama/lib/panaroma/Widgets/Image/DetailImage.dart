import 'package:flutter/cupertino.dart';

class DetailImage {

  String name;
  String imageLink;
  Image? image;

  DetailImage({
    required this.name,
    required this.imageLink,
  });

  Image getImage(){
    if (image == null) image = Image.asset(imageLink);
    return  image!;
  }
}
