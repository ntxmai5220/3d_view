import 'dart:convert';
import 'dart:html';

import 'package:bk_3d_view/apis/apis.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PostRequest {
  PostRequest._();
  // get post detail
  static APIRequest getPostDetail({required String id}) =>
      APIRequest.app(method: HTTPMethods.get, path: "post/$id");

  ///Path: post/anopost
  static APIRequest anoPost({required String id}) =>
      APIRequest.app(method: HTTPMethods.post, path: "post/anopost/$id");

  ///Path: /post/upload2ano/:id
  /// ?? Upload images
  static APIRequest uploadImg2Ano({required String id, Map<String, dynamic >? images }){
    FormData formData = FormData.fromMap(images!);
    return APIRequest.app(method: HTTPMethods.put, path: "post/upload2ano/$id", body:formData );
  }

  ///Path: /post/uploadhotspot/:id
  static APIRequest uploadhotSpot({required String id, dynamic hostPost}){
    return APIRequest.app(method: HTTPMethods.put, path: "post/upload2ano/$id", body:jsonEncode(hostPost) );
  }

  ///Path: /post/uploadthumbnail/:id
  static APIRequest uploadThumbnail({required String id, Image? image}){
    FormData form = FormData.fromMap({
      "images":image
    });
    return APIRequest.app(method: HTTPMethods.put, path: "post/uploadthumbnail/$id", body:form);
  }

  ///Path: post/uploadmainthumbnail/:id
  static APIRequest uploadMainThumbnail({required String id,  dynamic body}){
    return APIRequest.app(method: HTTPMethods.put, path: "post/uploadmainthumbnail/$id", body:jsonDecode(body));
  } 
  


      
  
}
