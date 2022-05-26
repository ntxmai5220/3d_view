import 'dart:convert';

import 'dart:typed_data';

import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:dio/dio.dart';

class PostRequest {
  PostRequest._();

  //Path: post/anopost/:id
  static DioRequest createAnoPost({
    required String userId,
    required Post post,
    String? token,
  }) {
    Options options = OptionBuilder()
        .jsonContent()
        .authorizeToken(token ?? 'example1')
        .build();
    return DioRequest(
        path: "post/anopost/$userId",
        options: options,
        body: post.toFormData());
  }

  // Path: post/:id
  static DioRequest createPost({
    required String userId,
    required List<MapEntry<String, Uint8List>> images,
    required List<String> imageDescription,
    required Map<String, String> landInfo,
    String? token,
  }) {
    Options options =
        OptionBuilder().authorizeToken(token ?? 'example1').build();

    FormData form = FormData();
    for (var image in images) {
      String name = image.key;
      Uint8List data = image.value;
      form.files.add(
          MapEntry("image", MultipartFile.fromBytes(data, filename: name)));
    }
    for (var description in imageDescription) {
      form.fields.add(MapEntry("image_descriptions", description));
    }
    form.fields.addAll(landInfo.entries);
    print(form.fields);
    return DioRequest(path: "post/$userId", options: options, body: form);
  }

  // Path: post/uploadhotspot/:id
  static DioRequest addHotspot({
    required String roomId,
    required List<Map<String, dynamic>> hotspots,
    String? token,
  }) {
    Options options = OptionBuilder()
        .jsonContent()
        .authorizeToken(token ?? 'example1')
        .build();

    return DioRequest(
        path: "post/uploadhotspot/$roomId",
        options: options,
        body: jsonEncode(hotspots));
  }

  // Path: /post/uploadthumbnail/:id
  static DioRequest uploadThumbnail({
    required String roomId,
    required List<MapEntry<String, Uint8List>> images,
    String? token,
  }) {
    Options options =
        OptionBuilder().authorizeToken(token ?? 'example1').build();
    FormData form = FormData();
    for (var image in images) {
      String name = image.key;
      Uint8List data = image.value;
      form.files.add(
          MapEntry("image", MultipartFile.fromBytes(data, filename: name)));
    }

    return DioRequest(
        path: "post/uploadthumbnail/$roomId", body: form, options: options);
  }

  // Path: /post/uploadmainthumbnail/:id
  static DioRequest uploadMainThumbnail({
    required String roomId,
    required Map<String, String> mainThumbnail,
    String? token,
  }) {
    Options options = OptionBuilder()
        .jsonContent()
        .authorizeToken(token ?? 'example1')
        .build();
    return DioRequest(
        path: "post/uploadmainthumbnail/$roomId",
        body: jsonEncode(mainThumbnail),
        options: options);
  }

  // Path: /post/uploadremoveimg/:roomId
  static DioRequest uploadRemoveImage({
    required String roomId,
    required MapEntry<String, Uint8List> removeImage,
    String? token,
  }) {
    Options options = OptionBuilder()
        .jsonContent()
        .authorizeToken(token ?? 'example1')
        .build();

    FormData form = FormData();

    String name = removeImage.key;
    Uint8List data = removeImage.value;

    form.files
        .add(MapEntry("image", MultipartFile.fromBytes(data, filename: name)));
    // var formData =
    //     MapEntry("image", MultipartFile.fromBytes(data, filename: name));
    return DioRequest(
        path: "post/uploadremovedimg/$roomId",
        body: form,
        options: options);
  }

  // Path: /post
  static DioRequest getPostWithFilter({
    required Map<String, dynamic> params,
  }) {
    return DioRequest(path: "post", params: params);
  }

  // Path: post/:id
  static DioRequest getPostDetail({
    required String id,
  }) {
    return DioRequest(path: "post/$id");
  }

  static DioRequest updateAllPost({
    required Map<String, dynamic> updateInfo,
    String? token,
  }) {
    Options options = OptionBuilder()
        .authorizeToken(token ?? 'example1')
        .jsonContent()
        .build();
    return DioRequest(
        path: "post", body: jsonEncode(updateInfo), options: options);
  }

  static DioRequest updatePost({
    required String id,
    required Map<String, dynamic> updateInfo,
    String? token,
  }) {
    Options options = OptionBuilder()
        .authorizeToken(token ?? 'example1')
        .jsonContent()
        .build();
    return DioRequest(
        path: "post/$id", body: jsonEncode(updateInfo), options: options);
  }

  static DioRequest deletePost({required String id ,String? token}){
    Options options = OptionBuilder().authorizeToken(token??'example1').build();
    return DioRequest(path: "post/$id", options: options);
  }

  static DioRequest follow({required String userId, required String token, required Map<String, dynamic> body}){
    Options options = OptionBuilder().jsonContent().authorizeToken(token).build();
    return DioRequest(path: "user/follow/$userId", options: options, body: jsonEncode(body));
  }

  static DioRequest getBanner(){
    String path = "https://6280872d7532b4920f704090.mockapi.io/v1/3dview/banners";
    return DioRequest(path: "", optionPath: path);
  } 
}
