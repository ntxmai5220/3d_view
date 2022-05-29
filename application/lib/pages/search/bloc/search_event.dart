part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchRefreshEvent extends SearchEvent {}

class SearchLoadEvent extends SearchEvent {
  final FilterParam params;
  SearchLoadEvent({
    required this.params,
  });
}

class SearchLoadMoreEvent extends SearchEvent {}

class SearchToggleFavoriteEvent extends SearchEvent {
  final String postId;
  final bool isFavorite;
  SearchToggleFavoriteEvent({
    required this.postId,
    required this.isFavorite,
  });
}
