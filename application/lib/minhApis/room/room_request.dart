import 'dart:convert';

import 'package:bk_3d_view/minhApis/apis.dart';
import 'package:dio/dio.dart';

class RoomRequest {
  RoomRequest._();

  // Path : room/:id
  static DioRequest updateRoom({
    required String id,
    required Map<String, dynamic> body,
  }) {
    Options options = OptionBuilder().authorizeToken().jsonContent().build();
    return DioRequest(
      path: "room/$id",
      options: options,
      body: jsonEncode(body),
    );
  }

  // Path : room/:id
  static DioRequest getRoom({
    required String id,
  }) {
    Options options = OptionBuilder().authorizeToken().build();
    return DioRequest(
      path: "room/$id",
      options: options,
    );
  }

  static DioRequest deleteRoom({
    required String id,
  }) {
    Options options = OptionBuilder().authorizeToken().build();
    return DioRequest(
      path: "room/$id",
      options: options,
    );
  }
}
