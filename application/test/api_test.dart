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

  test("createAnoPost", () async {
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
    List<String> imageDescription = ["test1", "test2"];
    var result = await services.createPost(
        userId: "625bd0648e18145a85211945",
        images: images,
        imageDescription: imageDescription,
        landInfo: post.toFormData(),
        token: token);
    debugPrint(result.object.toFormData().toString());
  });

  test("add hotpost", () async {
    List<Map<String, dynamic>> hotspots = [
      {
        "title": "Hotspot1",
        "latitude": 123,
        "longitude": 456,
        "type": 0,
        "currentRoom": "62861b2f934853c01d8a5128",
        "nextRoom": "62861b2f934853c01d8a512a"
      },
      {
        "title": "Hotspot2",
        "latitude": 123,
        "longitude": 456,
        "type": 1,
        "currentRoom": "62861b2f934853c01d8a5128",
        "nextRoom": "62861b2f934853c01d8a512a"
      }
    ];
    PostServices services = PostServices();
    await services.addHotspot(
        roomId: "62861b2f934853c01d8a5128", hotspots: hotspots);
  });

  test("upload thubmnail", () async {
    final images = await getImage();
    PostServices services = PostServices();
    var result = await services.uploadThumbnail(
      roomId:
          "6275c370117a505b026e719b", //6275c370117a505b026e719b-6275c370117a505b026e719d
      images: images,
      // token:
      //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNWJkMDY0OGUxODE0NWE4NTIxMTk0NSIsImlzQWRtaW4iOmZhbHNlLCJzZXNzaW9uVG9rZW4iOiI2MjViZTU0MWQ3Y2UxY2JjMGJiZTZjZjUiLCJpYXQiOjE2NTAxODk2MzMsImV4cCI6MTY1Mjc4MTYzM30.NpfugyhGnauxPcW9rdHgj4oEf_GRS84HznepD3X14Sw"
    );
    print(result);
  });

  test("upload remove image", () async {
    final images = await getImage();
    PostServices services = PostServices();
    var result = await services.uploadRemoveImage(
        roomId:
            "627e139ec5d44f0fca3de5f1", //6275c370117a505b026e719b-6275c370117a505b026e719d
        removeImage: images[0]
        // token:
        //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNWJkMDY0OGUxODE0NWE4NTIxMTk0NSIsImlzQWRtaW4iOmZhbHNlLCJzZXNzaW9uVG9rZW4iOiI2MjViZTU0MWQ3Y2UxY2JjMGJiZTZjZjUiLCJpYXQiOjE2NTAxODk2MzMsImV4cCI6MTY1Mjc4MTYzM30.NpfugyhGnauxPcW9rdHgj4oEf_GRS84HznepD3X14Sw"
        );
    print(result);
  });

  test("upload mainThumbnail", () async {
    final images = await getImage();
    final mainThumbnail = {"mainThumbnail": "duong link dan toi Thumbnail"};
    PostServices services = PostServices();
    await services.uploadMainThumbnail(
        roomId: "625be882ba0392826c179527",
        mainThumbnail: mainThumbnail,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNWJkMDY0OGUxODE0NWE4NTIxMTk0NSIsImlzQWRtaW4iOmZhbHNlLCJzZXNzaW9uVG9rZW4iOiI2MjViZTU0MWQ3Y2UxY2JjMGJiZTZjZjUiLCJpYXQiOjE2NTAxODk2MzMsImV4cCI6MTY1Mjc4MTYzM30.NpfugyhGnauxPcW9rdHgj4oEf_GRS84HznepD3X14Sw");
  });

  test("getPostWithFilter", () async {
    Map<String, dynamic> params = {
      "page": 1,
      "limit": 7,
      "price[gte]": 2.0

      // "creatorId[eq]": "625bd0648e18145a85211945"
    };
    PostServices services = PostServices();
    await services.getPostWithFilter(params: params);
  });
  test("getPost", () async {
    PostServices services = PostServices();
    await services.getPostDetail(id: "625bd215fa9050c1dc04fdb4");
  });

  test("updateAllPost", () async {
    Map<String, dynamic> update = {"desc": "123"};
    PostServices services = PostServices();
    await services.updateAllPost(
        updateInfo: update,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNmE2ZWIzODAzYjFlMjIxZGQyYzJjYiIsImlzQWRtaW4iOnRydWUsInNlc3Npb25Ub2tlbiI6IjYyNmE2ZWJiODAzYjFlMjIxZGQyYzJjZSIsImlhdCI6MTY1MTE0MjMzMSwiZXhwIjoxNjUzNzM0MzMxfQ.BkGKAAAa6sFJPQ1vTn9zQg59E0Cd7eRznFECbgeCn5k");
  });

  test("updatePost", () async {
    Map<String, dynamic> update = {"desc": "123"};
    PostServices services = PostServices();
    await services.updatePost(
        id: "625a6ae0c313e60d2f3836e6", updateInfo: update, token: "example1");
  });

  test("followPost", () async {
    String id = "625bd0768e18145a85211947";
    const body = {"postId": "625bd324fa9050c1dc04feb3", "isFavorite": true};
    PostServices services = PostServices();
    await services.follow(userId: id, token: token, body: body);
  });

  test("deletePost", () async {});

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
    const account = {"username": "mai", "password": "example1"};
    AuthServices authServices = AuthServices();
    await authServices.login(account: account);
  });

  test("signup", () async {
    const account = {
      "username": "minh23",
      "email": "minh23@gmail.com",
      "password": "example123"
    };
    AuthServices authServices = AuthServices();
    await authServices.signup(account: account);
  });

  // Room api

  test("updateRoom", () async {
    const room = {"name": "test Name"};
    RoomServices roomServices = RoomServices();
    String id = "625a6ae0c313e60d2f3836e6";
    await roomServices.updateRoom(id: id, token: token, body: room);
  });

  test("getRoom", () async {
    String id = "625a6ae0c313e60d2f3836e6";
    RoomServices roomServices = RoomServices();
    await roomServices.getRoom(id: id, token: token);
  });

  test("deleteRoom", () async {
    String id = "625a6ae0c313e60d2f3836e6";
    RoomServices roomServices = RoomServices();
    await roomServices.deleteRoom(id: id, token: token);
  });

  test("getAllUser", () async {
    UserServices userServices = UserServices();
    await userServices.getById(id: "625bd0648e18145a85211945", token: token);
  });
}
