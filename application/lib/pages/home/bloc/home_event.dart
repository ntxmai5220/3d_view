part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeLoadDataEvent extends HomeEvent {}

class HomeToggleFavoriteEvent extends HomeEvent {
  final String postId;
  final bool isFavorite;
  HomeToggleFavoriteEvent({
    required this.postId,
    required this.isFavorite,
  });
}

class HomeToggleFromOther extends HomeEvent {
  final String postId;
  final bool isFavorite;
  HomeToggleFromOther({
    required this.postId,
    required this.isFavorite,
  });
}
