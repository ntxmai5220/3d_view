import 'dart:convert';

import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:dio/dio.dart';

class RoomRequest{
  RoomRequest._();

  // Path : room/:id
  static DioRequest updateRoom({required String id, String? token, required Map<String, dynamic> body }){
    Options options = OptionBuilder().authorizeToken(token ?? 'example1').jsonContent().build();
    return DioRequest(path: "room/$id", options: options, body: jsonEncode(body));
  }

  // Path : room/:id
  static DioRequest getRoom({required String id, String? token}){
    Options options = OptionBuilder().authorizeToken(token ?? 'example1').build();
    return DioRequest(path: "room/$id", options: options);
  }

  static DioRequest deleteRoom({required String id, String? token}){
    Options options = OptionBuilder().authorizeToken(token ?? 'example1').build();
    return DioRequest(path: "room/$id", options: options);
  }
}