import 'dart:io';
import 'dart:typed_data';

import 'package:bk_3d_view/minhApis/base/DioClient.dart';
import 'package:bk_3d_view/minhApis/base/DioRequest.dart';
import 'package:bk_3d_view/minhApis/post/postRequest.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:dio/dio.dart';

class PostServices {

  //path: /post/:id
  Future<dynamic> createPost({required String id, required List<MapEntry<String,Uint8List>> images , required List<String> imageDescription, required Map<String, String> landInfo, required String token } ) async {
    DioRequest request = PostRequest.createPost(id: id, images: images,  imageDescription: imageDescription, landInfo: landInfo, token: token); 
    dynamic data = await DioClient.post(path: request.path, data: request.body, options: request.options);
    print(data);
  }

  //path: /post/uploadhotspot/:id
  Future<dynamic> addHotspot({required String id, required List<Map<String, dynamic>> hotspots, required String token }) async{
    DioRequest request = PostRequest.addHotspot(id: id, hotspots: hotspots,  token: token );
    dynamic data = await DioClient.post(path: request.path, data: request.body, options: request.options );
    print(data);
   
  }

  //path: /post/uploadhotspot/:id
  Future<dynamic> uploadThumbnail({required String id, required List<MapEntry<String,Uint8List>> images , required String token }) async{
    DioRequest request = PostRequest.uploadThumbnail(id: id, images: images,  token: token );
    dynamic data = await DioClient.put(path: request.path, data: request.body, options: request.options );
    print(data);
   
  }

  //path: /post/uploadmainthumbnail/:id
  Future<dynamic> uploadMainThumbnail({required String id, required Map<String, String> mainThumbnail , required String token }) async{
    DioRequest request = PostRequest.uploadMainThumbnail(id: id, mainThumbnail: mainThumbnail,  token: token );
    dynamic data = await DioClient.put(path: request.path, data: request.body, options: request.options );
    print(data);
   
  }

  Future<dynamic> getPostWithFilter({required Map<String, dynamic> params}) async {
    DioRequest request = PostRequest.getPostWithFilter(params: params);
    dynamic data = await DioClient.get(path: request.path, params: request.params);
    print(data);
  }

  Future<dynamic> getPostDetail({required String id}) async {
    DioRequest request = PostRequest.getPostDetail(id: id);
    dynamic data = await DioClient.get(path: request.path);
    print(data);
  }

  Future<dynamic> updateAllPost({required Map<String,dynamic> updateInfo, required String token}) async {
    DioRequest request = PostRequest.updateAllPost(updateInfo:updateInfo, token:token );
    dynamic data = await DioClient.put(path: request.path, options: request.options, data: request.body);
    print(data);
  }

  Future<dynamic> updatePost({required String id ,required Map<String,dynamic> updateInfo, required String token}) async {
    DioRequest request = PostRequest.updatePost(id:id , updateInfo:updateInfo, token:token );
    dynamic data = await DioClient.put(path: request.path, options: request.options, data: request.body);
    print(data);
  }

}