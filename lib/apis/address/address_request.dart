import 'package:bk_3d_view/apis/apis.dart';

class AddressRequest {
  AddressRequest._();

  //get provinces
  static APIRequest getProvinces() => APIRequest.address(
        path: '/province',
      );

  //get districts
  static APIRequest getDistricts({required int provinceId}) => APIRequest.address(
      path: '/district', parameters: {'province_id': provinceId});

  //get wards
  static APIRequest getWards({required int districtId}) => APIRequest.address(
      path: '/ward', parameters: {'district_id': districtId});
}
