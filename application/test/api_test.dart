import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bk_3d_view/data/mock.dart';
import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String token = "example1";

  Future<List<MapEntry<String, Uint8List>>> getImage() async {
    List<MapEntry<String, Uint8List>> images = [];

    File image = File("assets/test/anh1.jpg");
    String name = image.path.split("/").last;
    Uint8List data = await image.readAsBytes();

    File image2 = File("assets/test/anh2.jpg");
    String name2 = image2.path.split("/").last;
    Uint8List data2 = await image2.readAsBytes();

    images.add(MapEntry(name, data));
    images.add(MapEntry(name2, data2));
    return images;
  }

  test("createPost", () async {
    PostServices services = PostServices();
    final images = await getImage();
    final landInfo = {
      'area': '357',
      'price': '123',
      'address': 'saacvd',
      'desc': 'minh',
      'province[id]': '35',
      'province[name]': 'TP HCM',
      'district[id]': '80',
      'district[name]': 'Thu Duc',
      'district[provinceId]': '35',
      'ward[code]': '77',
      'ward[name]': 'Phuong 9',
      'ward[districtId]': '80'
    };
    List<String> imageDescription = ["phong 1", "phong 2"];
    var result = await services.createPost(
      images: images,
      imageDescription: imageDescription,
      landInfo: post.toFormData(),
    );
    // debugPrint(result.object.toFormData().toString());
  });

  test("add hotpost", () async {
    List<Map<String, dynamic>> hotspots = [
      {
        "title": "ban an",
        "latitude": 123,
        "longitude": 456,
        "type": 0,
        "content": 'k=ban an kich thuoc 1.6x2'
      },
      {
        "title": "phong 2",
        "latitude": 123,
        "longitude": 456,
        "type": 1,
        "currentRoom": "62948d5ae358fd5453173619",
        "nextRoom": "62948d5ae358fd545317361b"
      }
    ];
    PostServices services = PostServices();
    await services.addHotspot(
        roomId: "62948d5ae358fd5453173619", hotspots: hotspots);
  });

  test("upload thubmnail", () async {
    final images = await getImage();
    PostServices services = PostServices();
    var result = await services.uploadThumbnail(
      roomId: "62948d5ae358fd5453173619",
      images: images,
    );
  });

  test("upload remove image", () async {
    final images = await getImage();
    PostServices services = PostServices();
    var result = await services.uploadRemoveImage(
        roomId: "62948d5ae358fd5453173619", removeImage: images[0]);
  });

  test("upload mainThumbnail", () async {
    final images = await getImage();
    final mainThumbnail = {"mainThumbnail": "duong link dan toi Thumbnail"};
    PostServices services = PostServices();
    await services.uploadMainThumbnail(
      roomId: "62948d5ae358fd5453173619",
      mainThumbnail: mainThumbnail,
    );
  });

  test("getPostWithFilter", () async {
    Map<String, dynamic> params = {"page": 1, "limit": 7, "price[gte]": 1000.0};
    PostServices services = PostServices();
    await services.getPostWithFilter(params: params);
  });
  test("getPostDetail", () async {
    PostServices services = PostServices();
    await services.getPostDetail(id: "6293358df0bfdc9c9738f276");
  });

  // test("updateAllPost", () async {
  //   Map<String, dynamic> update = {"desc": "123"};
  //   PostServices services = PostServices();
  //   await services.updateAllPost(
  //     updateInfo: update,
  //   );
  // });

  test("updatePost", () async {
    Map<String, dynamic> update = {
      "desc": " description moi ne, cap nhat moi nhat"
    };
    PostServices services = PostServices();
    await services.updatePost(
      id: "62948d57e358fd5453173615",
      updateInfo: update,
    );
  });

  test("followPost", () async {
    String id = "625bd0768e18145a85211947";
    const body = {"postId": "625bd324fa9050c1dc04feb3", "isFavorite": true};
    PostServices services = PostServices();
    // await services.follow(body: body);
    await Future.delayed(Duration(milliseconds: 184));
  });

  test("deletePost", () async {
    await Future.delayed(Duration(milliseconds: 231));
  });

  test("banners", () async {
    PostServices services = PostServices();
    await services.getBanners();
  });

  test("removeMask", () async {
    File image = File("assets/test/mask1.jpg");
    Uint8List data = await image.readAsBytes();
    String base64Image = base64Encode(data);

    File image2 = File("assets/test/mask2.jpg");
    Uint8List data2 = await image2.readAsBytes();
    String base64Mask = base64Encode(data2);
    InPaintingServices services = InPaintingServices();
    await services.removeWithMask(
        base64Image: base64Image, base64Mask: base64Mask);
    debugPrint('mask');
  });

  test("login", () async {
    const account = {"email": "mai@gmail.com", "password": "example1"};
    AuthServices authServices = AuthServices();
    try {
      var result = await authServices.login(
          email: account['email'] ?? '', pw: account['password'] ?? '');
      debugPrint(result.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  test("signup", () async {
    const account = {
      "username": "minh23",
      "email": "minh23@gmail.com",
      "password": "example123"
    };
    AuthServices authServices = AuthServices();
    await authServices.signup(
        email: account['email'] ?? '',
        pw: account['password'] ?? '',
        name: 'mai');
  });

  // Room api

  test("updateRoom", () async {
    const room = {"name": "test Name"};
    RoomServices roomServices = RoomServices();
    String id = "62948d5ae358fd5453173619";
    await roomServices.updateRoom(id: id, body: {"name": "phong moi"});
  });

  test("getRoomDetail", () async {
    String id = "62948d5ae358fd5453173619";
    RoomServices roomServices = RoomServices();
    await roomServices.getRoom(
      id: id,
    );
  });

  test("deleteRoom", () async {
    String id = "62948d5ae358fd5453173619";
    RoomServices roomServices = RoomServices();
    await roomServices.deleteRoom(
      id: id,
    );
  });

  test("getAllUser", () async {
    UserServices userServices = UserServices();
    await userServices.getUserById();
  });
}

var result = {
  "province": {"id": 160, "name": "Tien Giang"},
  "district": {"id": 10, "name": "TP. My Tho", "provinceId": 160},
  "ward": {"code": 5, "name": "Phuong 1", "districtId": 10},
  "_id": "62948d57e358fd5453173615",
  "area": 120,
  "price": 900,
  "desc": "description",
  "address": "55/12 duong Hung Vuong",
  "isUsed": false,
  "isFavorite": false,
  "isHidden": false,
  "isRent": false,
  "rooms": [
    {
      "mainThumbnail": {"imgUrl": "", "publicId": ""},
      "_id": "62948d5ae358fd5453173619",
      "name": "phong 1",
      "imgUrl":
          "http://res.cloudinary.com/dtnam302/image/upload/v1653902680/Thesis/62948d57e358fd5453173615/byjzetufe5llfonjqz7v.jpg"
    },
    {
      "mainThumbnail": {"imgUrl": "", "publicId": ""},
      "_id": "62948d5ae358fd545317361b",
      "name": "phong 2",
      "imgUrl":
          "http://res.cloudinary.com/dtnam302/image/upload/v1653902682/Thesis/62948d57e358fd5453173615/bg9idzaor0bl2doimcgp.jpg"
    }
  ],
  "favoriteCount": 0,
  "creatorId": "62920cdd70788d943fa83020",
  "createdAt": "2022-05-30T09:24:39.080Z",
  "updatedAt": "2022-05-30T09:24:42.872Z",
  "__v": 1
};
