import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bk_3d_view/minhApis/base/DioRequest.dart';
import 'package:bk_3d_view/minhApis/base/OptionBuilder.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:dio/dio.dart';

class PostRequest {
  PostRequest._();

  //Path: post/anopost/:id
  static DioRequest createAnoPost({required String id, required Post post, required String token}){
    Options options = OptionBuilder().jsonContent().authorizeToken(token).build();
    return DioRequest(path: "post/anopost/$id", options: options,  body: post.toMap());
  }


  // Path: post/:id
  static DioRequest createPost({required String id, required List<MapEntry<String,Uint8List>> images, required List<String> imageDescription, required Map<String, String> landInfo, required String token }) {
    Options options = OptionBuilder().authorizeToken(token).build();

    FormData form = FormData();
    images.forEach((image) {
      String name = image.key;
      Uint8List data = image.value;
      form.files.add(MapEntry("image", MultipartFile.fromBytes(data,filename: name)));
    });
    imageDescription.forEach((description) => form.fields.add(MapEntry("image_descriptions", description)));
    form.fields.addAll(landInfo.entries);
    print(form.fields);
    return DioRequest(path: "post/$id", options:options, body: form );
  }

  // Path: post/uploadhotspot/:id
  static DioRequest addHotspot({required String id, required List<Map<String, dynamic>> hotspots, required String token }){
    Options options = OptionBuilder().jsonContent().authorizeToken(token).build();

    return DioRequest(path: "post/uploadhotspot/$id", options: options, body: jsonEncode(hotspots));
  }

  // Path: /post/uploadthumbnail/:id
  static DioRequest   uploadThumbnail({required String id, required List<MapEntry<String,Uint8List>> images, required String token }){
    Options options = OptionBuilder().authorizeToken(token).build();
    FormData form = FormData();
    images.forEach((image) {
      String name = image.key;
      Uint8List data = image.value;
      form.files.add(MapEntry("image", MultipartFile.fromBytes(data,filename: name)));
    });

    return DioRequest(path: "post/uploadthumbnail/$id", body: form, options: options);
  }

  // Path: /post/uploadmainthumbnail/:id
  static DioRequest uploadMainThumbnail({required String id, required Map<String, String> mainThumbnail, required String token }){
    Options options = OptionBuilder().jsonContent().authorizeToken(token).build();
    return DioRequest(path: "post/uploadmainthumbnail/$id", body: jsonEncode(mainThumbnail), options: options);
  }

  // Path: /post
  static DioRequest getPostWithFilter({required Map<String, dynamic > params}){
    return DioRequest(path: "post", params: params);
  }

  // Path: post/:id
  static DioRequest getPostDetail({required String id}) {
    return DioRequest(path: "post/$id");
  }

  
  static DioRequest updateAllPost({required Map<String,dynamic> updateInfo, required String token}) {
    Options options = OptionBuilder().authorizeToken(token).jsonContent().build();
    return DioRequest(path: "post", body: jsonEncode(updateInfo), options: options);
  }

  static DioRequest updatePost({required String id,required Map<String,dynamic> updateInfo, required String token}) {
    Options options = OptionBuilder().authorizeToken(token).jsonContent().build();
    return DioRequest(path: "post/$id", body: jsonEncode(updateInfo), options: options);
  }

}