part of 'followed_bloc.dart';

abstract class FollowedState {
  List<Post> post;
  FilterParam params;
  FollowedState({
    required this.post,
    required this.params,
  });
}

class FollowedInitial extends FollowedState {
  FollowedInitial({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class FollowedLoading extends FollowedState {
  FollowedLoading({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class FollowedLoaded extends FollowedState {
  FollowedLoaded({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class FollowedError extends FollowedState {
  FollowedError({required List<Post> post, required FilterParam params})
      : super(post: post, params: params);
}

class FollowdNotLogin extends FollowedState {
  FollowdNotLogin({List<Post> post = const [], required FilterParam params})
      : super(post: post, params: params);
}
