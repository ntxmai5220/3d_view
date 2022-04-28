import 'package:bk_3d_view/apis/apis.dart';
import 'package:bk_3d_view/apis/post/post_request.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:flutter/material.dart';


class PostService {
  final ApiExecute apiExecute;
  PostService({required this.apiExecute});

  //get post detail
  Future<ObjectResponse<Post>?> getPostDetail(String id) async {
    final request = PostRequest.getPostDetail(id:id);
    APIResponse response = await apiExecute.execute(request: request, type: ApiRequestType.app);
    debugPrint(response.data.toString());
    debugPrint(response.toString());
    Post post = Post.fromJson(response.toObject());
    // return ObjectResponse(object:n);

  }

}