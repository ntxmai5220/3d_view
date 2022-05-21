part of 'search_bloc.dart';

abstract class SearchState {
  List<Post> post;
  FilterParam params;
  SearchState({
    required this.post,
    required this.params,
  });
}

class SearchInitial extends SearchState {
  SearchInitial({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class SearchLoading extends SearchState {
  SearchLoading({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}

class SearchLoaded extends SearchState {
  SearchLoaded({
    required List<Post> post,
    required FilterParam params,
  }) : super(post: post, params: params);
}
