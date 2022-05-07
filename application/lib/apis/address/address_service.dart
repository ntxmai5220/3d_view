import 'package:bk_3d_view/apis/apis.dart';
import 'package:bk_3d_view/models/models.dart';

class AddressService {
  final ApiExecute apiExecute;
  AddressService({required this.apiExecute});

  //get provinces
  Future<ListResponse<Province>> getProvinces() async {
    final request = AddressRequest.getProvinces();

    APIResponse response = await apiExecute.execute(request: request);

    List<Province> list =
        response.toListAddress().map((e) => Province.fromJson(e)).toList();
    return ListResponse(list: list);
  }

  //get districts
  Future<ListResponse<District>> getDistricts({required int provinceId}) async {
    final request = AddressRequest.getDistricts(provinceId: provinceId);

    APIResponse response = await apiExecute.execute(request: request);

    List<District> list =
        response.toListAddress().map((e) => District.fromJson(e)).toList();
    return ListResponse(list: list);
  }

  //get wards
  Future<ListResponse<Ward>> getWards({required int districtId}) async {
    final request = AddressRequest.getWards(districtId: districtId);
    APIResponse response = await apiExecute.execute(request: request);

    List<Ward> list =
        response.toListAddress().map((e) => Ward.fromJson(e)).toList();
    return ListResponse(list: list);
  }
}
