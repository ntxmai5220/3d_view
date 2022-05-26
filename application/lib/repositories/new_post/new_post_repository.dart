import 'dart:typed_data';

import 'package:bk_3d_view/apis/apis.dart';
import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:dio/dio.dart';

class NewPostRepository {
  NewPostRepository({ApiExecute? apiExecute})
      : _apiExecute = apiExecute ?? ApiExecute.address();
  final ApiExecute _apiExecute;
  final PostServices postServices = PostServices();

  Future<ListResponse<Province>> getProvince() =>
      AddressService(apiExecute: _apiExecute).getProvinces();

  Future<ListResponse<District>> getDistrict({required int provinceId}) =>
      AddressService(apiExecute: _apiExecute)
          .getDistricts(provinceId: provinceId);

  Future<ListResponse<Ward>> getWard({required int districtId}) =>
      AddressService(apiExecute: _apiExecute).getWards(districtId: districtId);

  Future<Response<dynamic>> downloadCamera(
          {required String urlPath,
          required String savePath,
          ProgressCallback? onReceivedData}) =>
      Dio().download(urlPath, savePath, onReceiveProgress: onReceivedData);

  //create post
  Future<ObjectResponse<Post>> createPost({
    required String userId,
    required List<MapEntry<String, Uint8List>> images,
    required List<String> imageDescription,
    required Map<String, String> landInfo,
    String? token,
  }) =>
      postServices.createPost(
        userId: userId,
        images: images,
        imageDescription: imageDescription,
        landInfo: landInfo,
        token: token,
      );

  //upload thumbnail
  Future<ObjectResponse<Room>> uploadThumbnail(
          {required String roomId,
          required List<MapEntry<String, Uint8List>> images,
          String? token}) =>
      postServices.uploadThumbnail(
        roomId: roomId,
        images: images,
        token: token,
      );

  //delete post when click huy
  Future<dynamic> deletePost({
    required String id,
  }) =>
      postServices.deletePost(id: id);
}
