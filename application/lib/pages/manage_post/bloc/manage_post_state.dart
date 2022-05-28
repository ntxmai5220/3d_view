part of 'manage_post_bloc.dart';

abstract class ManagePostState {
  List<Post> post;
  FilterParam params;
  ManagePostState({
    required this.post,
    required this.params,
  });
}

class ManagePostInitial extends ManagePostState {
  ManagePostInitial({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class ManagePostLoading extends ManagePostState {
  ManagePostLoading({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class ManagePostLoaded extends ManagePostState {
  ManagePostLoaded({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class ManagePostError extends ManagePostState {
  ManagePostError({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}
