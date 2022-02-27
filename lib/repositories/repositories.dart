//export all files

//test api
import 'package:bk_3d_view/apis/apis.dart';
import 'package:flutter/material.dart';

final ApiExecute apiExecute = ApiExecute(baseURL: BaseURLs.address);

void testAPI() {
  debugPrint('test api');
  testAddress();
}

testAddress() async {
  var result;

  // result = await AddressService(apiExecute: apiExecute).getProvinces();
  // result = await AddressService(apiExecute: apiExecute).getDistricts(234);
  result =
      await AddressService(apiExecute: apiExecute).getWards(districtId: 1880);

  debugPrint(result.list.length.toString());
  result.list.forEach((element) => debugPrint(element.toJson().toString()));
}
