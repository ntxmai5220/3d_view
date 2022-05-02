//export all files
export 'new_post/new_post_repository.dart';

export 'remove_object/remove_object_repository.dart';

//test api
import 'package:bk_3d_view/apis/apis.dart';
import 'package:flutter/material.dart';

final ApiExecute apiExecute = ApiExecute.address();
final ApiExecute postApiExecute = ApiExecute.app();

void testAPI() {
  debugPrint('test api');
  // testAddress();
  testPost();
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

testPost() async {
  var result;
  result = await PostService(apiExecute: postApiExecute)
      .getPostDetail('625bd215fa9050c1dc04fdb4');

  debugPrint(result.toString());
}

// testRemove() async {
//   var result = await RemoveObjectService().inpainting(image: image, mask: mask);
// }
