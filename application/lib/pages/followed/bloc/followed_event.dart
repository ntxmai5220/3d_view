part of 'followed_bloc.dart';

@immutable
abstract class FollowedEvent {}

class FollowedRefreshEvent extends FollowedEvent {}

class FollowedLoadEvent extends FollowedEvent {
  final FilterParam params;
  FollowedLoadEvent({
    required this.params,
  });
}

class FollowedLoadMoreEvent extends FollowedEvent {}

class FollowedToggleFavoriteEvent extends FollowedEvent {
  final String postId;
  final bool isFavorite;
  FollowedToggleFavoriteEvent({
    required this.postId,
    required this.isFavorite,
  });
}
