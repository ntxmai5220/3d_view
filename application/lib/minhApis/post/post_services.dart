import 'dart:typed_data';

import 'package:bk_3d_view/apis/apis.dart';

import 'package:bk_3d_view/minhApis/base/dio_client.dart';
import 'package:bk_3d_view/minhApis/base/dio_request.dart';
import 'package:bk_3d_view/minhApis/post/post_request.dart';
import 'package:bk_3d_view/models/models.dart';

class PostServices {
  //path: /post/:id
  Future<ObjectResponse<Post>> createPost(
      {required String userId,
      required List<MapEntry<String, Uint8List>> images,
      required List<String> imageDescription,
      required Map<String, String> landInfo,
      String? token}) async {
    DioRequest request = PostRequest.createPost(
        userId: userId,
        images: images,
        imageDescription: imageDescription,
        landInfo: landInfo,
        token: token);
    APIResponse data = await DioClient.post(
        path: request.path, data: request.body, options: request.options);
    Post post = Post.fromJson(data.toObject());
    print(post.province?.toJson().toString());
    print('done');
    return ObjectResponse(object: post);
    // print(data);
  }

  //path: /post/uploadhotspot/:id
  Future<dynamic> addHotspot(
      {required String roomId,
      required List<Map<String, dynamic>> hotspots,
      String? token}) async {
    DioRequest request = PostRequest.addHotspot(
        roomId: roomId, hotspots: hotspots, token: token);
    dynamic data = await DioClient.post(
        path: request.path, data: request.body, options: request.options);
    print(data);
  }

  //path: /post/uploadhotspot/:id
  Future<ObjectResponse<Room>> uploadThumbnail(
      {required String roomId,
      required List<MapEntry<String, Uint8List>> images,
      String? token}) async {
    DioRequest request = PostRequest.uploadThumbnail(
        roomId: roomId, images: images, token: token);
    APIResponse data = await DioClient.put(
        path: request.path, data: request.body, options: request.options);
    Room room = Room.fromJson(data.toObject());
    print(data.toString());

    return ObjectResponse(object: room);
  }

  //path: /post/uploadmainthumbnail/:id
  Future<dynamic> uploadMainThumbnail(
      {required String roomId,
      required Map<String, String> mainThumbnail,
      String? token}) async {
    DioRequest request = PostRequest.uploadMainThumbnail(
        roomId: roomId, mainThumbnail: mainThumbnail, token: token);
    dynamic data = await DioClient.put(
        path: request.path, data: request.body, options: request.options);
    print(data);
  }

  Future<ObjectResponse<Room?>> uploadRemoveImage(
      {required String roomId,
      required MapEntry<String, Uint8List> removeImage,
      String? token}) async {
    DioRequest request = PostRequest.uploadRemoveImage(
        roomId: roomId, removeImage: removeImage, token: token);
    APIResponse data = await DioClient.put(
        path: request.path, data: request.body, options: request.options);
    Room room = Room.fromJson(data.toObject());
    print(data.toString());

    return ObjectResponse(object: room);
  }

  Future<dynamic> getPostWithFilter(
      {required Map<String, dynamic> params}) async {
    DioRequest request = PostRequest.getPostWithFilter(params: params);
    dynamic data =
        await DioClient.get(path: request.path, params: request.params);
    print(data);
  }

  Future<dynamic> getPostDetail({required String id}) async {
    DioRequest request = PostRequest.getPostDetail(id: id);
    dynamic data = await DioClient.get(path: request.path);
    print(data);
  }

  Future<dynamic> updateAllPost(
      {required Map<String, dynamic> updateInfo, String? token}) async {
    DioRequest request =
        PostRequest.updateAllPost(updateInfo: updateInfo, token: token);
    dynamic data = await DioClient.put(
        path: request.path, options: request.options, data: request.body);
    print(data);
  }

  Future<dynamic> updatePost(
      {required String id,
      required Map<String, dynamic> updateInfo,
      String? token}) async {
    DioRequest request =
        PostRequest.updatePost(id: id, updateInfo: updateInfo, token: token);
    dynamic data = await DioClient.put(
        path: request.path, options: request.options, data: request.body);
    print(data);
  }
}
