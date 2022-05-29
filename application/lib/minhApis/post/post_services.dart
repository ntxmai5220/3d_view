import 'dart:typed_data';

import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class PostServices {
  //path: /post/:id
  Future<ObjectResponse<Post>> createPost({
    required List<MapEntry<String, Uint8List>> images,
    required List<String> imageDescription,
    required Map<String, String> landInfo,
  }) async {
    DioRequest request = PostRequest.createPost(
      images: images,
      imageDescription: imageDescription,
      landInfo: landInfo,
    );
    APIResponse data = await DioClient.post(
      path: request.path,
      data: request.body,
      options: request.options,
    );
    Post post = Post.fromJson(data.toObject());

    return ObjectResponse(object: post);
    // print(data);
  }

  //path: /post/uploadhotspot/:id
  Future<ObjectResponse<Room>> addHotspot({
    required String roomId,
    required List<Map<String, dynamic>> hotspots,
  }) async {
    DioRequest request = PostRequest.addHotspot(
      roomId: roomId,
      hotspots: hotspots,
    );
    APIResponse data = await DioClient.put(
      path: request.path,
      data: request.body,
      options: request.options,
    );
    Room room = Room.fromJson(data.toObject());
    return ObjectResponse(object: room);
  }

  //path: /post/uploadhotspot/:id
  Future<ObjectResponse<Room>> uploadThumbnail({
    required String roomId,
    required List<MapEntry<String, Uint8List>> images,
  }) async {
    DioRequest request = PostRequest.uploadThumbnail(
      roomId: roomId,
      images: images,
    );
    APIResponse data = await DioClient.put(
      path: request.path,
      data: request.body,
      options: request.options,
    );
    Room room = Room.fromJson(data.toObject());

    return ObjectResponse(object: room);
  }

  //path: /post/uploadmainthumbnail/:id
  Future<dynamic> uploadMainThumbnail({
    required String roomId,
    required Map<String, String> mainThumbnail,
  }) async {
    DioRequest request = PostRequest.uploadMainThumbnail(
      roomId: roomId,
      mainThumbnail: mainThumbnail,
    );
    dynamic data = await DioClient.put(
      path: request.path,
      data: request.body,
      options: request.options,
    );
    print(data);
  }

  Future<ObjectResponse<Room?>> uploadRemoveImage({
    required String roomId,
    required MapEntry<String, Uint8List> removeImage,
  }) async {
    DioRequest request = PostRequest.uploadRemoveImage(
      roomId: roomId,
      removeImage: removeImage,
    );
    APIResponse data = await DioClient.put(
      path: request.path,
      data: request.body,
      options: request.options,
    );
    Room room = Room.fromJson(data.toObject());

    return ObjectResponse(object: room);
  }

  Future<ListResponse<Post>> getPostWithFilter(
      {required Map<String, dynamic> params}) async {
    DioRequest request = PostRequest.getPostWithFilter(params: params);

    APIResponse data = await DioClient.get(
      path: request.path,
      params: request.params,
    );
    List<Post> list =
        data.toList().map((banner) => Post.fromJson(banner)).toList();

    return ListResponse(list: list);
  }

  Future<ObjectResponse<Post>> getPostDetail({required String id}) async {
    DioRequest request = PostRequest.getPostDetail(id: id);
    APIResponse data = await DioClient.get(path: request.path);

    Post post = Post.fromJson(data.toObject());

    return ObjectResponse(object: post);
  }

  Future<dynamic> updateAllPost({
    required Map<String, dynamic> updateInfo,
  }) async {
    DioRequest request = PostRequest.updateAllPost(
      updateInfo: updateInfo,
    );
    dynamic data = await DioClient.put(
      path: request.path,
      options: request.options,
      data: request.body,
    );
    print(data);
  }

  Future<dynamic> updatePost({
    required String id,
    required Map<String, dynamic> updateInfo,
  }) async {
    DioRequest request = PostRequest.updatePost(
      id: id,
      updateInfo: updateInfo,
    );
    dynamic data = await DioClient.put(
      path: request.path,
      options: request.options,
      data: request.body,
    );
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

  Future<ObjectResponse<bool>> follow({
    String? postId,
    required bool isFavorite,
  }) async {
    DioRequest request = PostRequest.follow(
      body: {
        "postId": postId,
        "isFavorite": isFavorite,
      },
    );
    APIResponse response = await DioClient.put(
      path: request.path,
      options: request.options,
      data: request.body,
    );
    return ObjectResponse(object: response.toObject()['message'] == 'ok');
  }

  Future<ListResponse<Banner>> getBanners() async {
    DioRequest request = PostRequest.getBanner();

    APIResponse data = await DioClient.get(
      path: request.path,
      options: request.options,
      optionPath: request.optionPath,
    );
    List<Banner> list =
        data.toList().map((banner) => Banner.fromJson(banner)).toList();
    return ListResponse(list: list);
  }
}
