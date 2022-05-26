import 'dart:typed_data';

import 'package:bk_3d_view/minhApis/apis.dart';
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

    return ObjectResponse(object: post);
    // print(data);
  }

  //path: /post/uploadhotspot/:id
  Future<ObjectResponse<Room>> addHotspot(
      {required String roomId,
      required List<Map<String, dynamic>> hotspots,
      String? token}) async {
    DioRequest request = PostRequest.addHotspot(
        roomId: roomId, hotspots: hotspots, token: token);
    APIResponse data = await DioClient.put(
        path: request.path, data: request.body, options: request.options);
    print(data);
    Room room = Room.fromJson(data.toObject());
    return ObjectResponse(object: room);
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

  Future<ListResponse<Post>> getPostWithFilter(
      {required Map<String, dynamic> params}) async {
    DioRequest request = PostRequest.getPostWithFilter(params: params);
    APIResponse data =
        await DioClient.get(path: request.path, params: request.params);
    List<Post> list =
        data.toList().map((banner) => Post.fromJson(banner)).toList();
    print(data.toList());
    return ListResponse(list: list);
  }

  Future<ObjectResponse<Post>> getPostDetail({required String id}) async {
    DioRequest request = PostRequest.getPostDetail(id: id);
    APIResponse data = await DioClient.get(path: request.path);

    Post post = Post.fromJson(data.toObject());
    print(data);
    return ObjectResponse(object: post);
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

  Future<dynamic> deletePost({
    required String id,
  }) async {
    DioRequest request = PostRequest.deletePost(id: id);
    await DioClient.delete(
      path: request.path,
      options: request.options,
    );
  }

  Future<dynamic> follow(
      {required String userId,
      required String token,
      required Map<String, dynamic> body}) async {
    DioRequest request =
        PostRequest.follow(userId: userId, token: token, body: body);
    APIResponse data = await DioClient.put(
        path: request.path, options: request.options, data: request.body);
    print(data);
  }

  Future<ListResponse<Banner>> getBanners() async {
    DioRequest request = PostRequest.getBanner();
    APIResponse data = await DioClient.get(
        path: request.path,
        options: request.options,
        optionPath: request.optionPath);
    List<Banner> list =
        data.toList().map((banner) => Banner.fromJson(banner)).toList();
    print(data.toList());
    return ListResponse(list: list);
  }
}
