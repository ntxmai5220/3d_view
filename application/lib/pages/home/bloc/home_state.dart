part of 'home_bloc.dart';

abstract class HomeState {
  List<Banner> banners;

  List<Post> newPost;
  List<Post> hotPost;
  HomeState({
    required this.banners,
    required this.newPost,
    required this.hotPost,
  });
}

class HomeInitial extends HomeState {
  HomeInitial({
    List<Banner> banners = const [],
    List<Post> newPost = const [],
    List<Post> hotPost = const [],
  }) : super(banners: banners, newPost: newPost, hotPost: hotPost);
}

class HomeLoading extends HomeState {
  HomeLoading(
      {required List<Banner> banners,
      required List<Post> newPost,
      required List<Post> hotPost})
      : super(banners: banners, newPost: newPost, hotPost: hotPost);
}

class HomeLoaded extends HomeState {
  HomeLoaded(
      {required List<Banner> banners,
      required List<Post> newPost,
      required List<Post> hotPost})
      : super(banners: banners, newPost: newPost, hotPost: hotPost);
}

class HomeLoadError extends HomeState {
  HomeLoadError(
      {required List<Banner> banners,
      required List<Post> newPost,
      required List<Post> hotPost})
      : super(banners: banners, newPost: newPost, hotPost: hotPost);
}
