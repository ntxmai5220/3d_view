import 'package:bk_3d_view/apis/apis.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:dio/dio.dart';

class NewPostRepository {
  NewPostRepository({ApiExecute? apiExecute})
      : _apiExecute = apiExecute ?? ApiExecute.address();
  final ApiExecute _apiExecute;

  Future<ListResponse<Province>> getProvince() =>
      AddressService(apiExecute: _apiExecute).getProvinces();

  Future<ListResponse<District>> getDistrict({required int provinceId}) =>
      AddressService(apiExecute: _apiExecute)
          .getDistricts(provinceId: provinceId);

  Future<ListResponse<Ward>> getWard({required int districtId}) =>
      AddressService(apiExecute: _apiExecute).getWards(districtId: districtId);

  Future<Response<dynamic>> downloadCamera({required String urlPath, required String savePath, ProgressCallback? onReceivedData}) => Dio().download(urlPath, savePath, onReceiveProgress: onReceivedData);
}
