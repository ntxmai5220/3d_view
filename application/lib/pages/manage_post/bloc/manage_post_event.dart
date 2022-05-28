part of 'manage_post_bloc.dart';

@immutable
abstract class ManagePostEvent {}

class ManagePostRefreshEvent extends ManagePostEvent {}

class ManagePostLoadEvent extends ManagePostEvent {
  final FilterParam params;
  ManagePostLoadEvent({
    required this.params,
  });
}

class ManagePostLoadMoreEvent extends ManagePostEvent {}

class ManagePostChangeTabEvent extends ManagePostEvent {
  final int index;
  ManagePostChangeTabEvent({
    required this.index,
  });
}

class ManagePostDeleteEvent extends ManagePostEvent {
  final String postId;

  ManagePostDeleteEvent({
    required this.postId,
  });
}
