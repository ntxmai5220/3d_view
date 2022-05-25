part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent {}

class PostDetailLoadEvent extends PostDetailEvent {
  final String id;
  PostDetailLoadEvent({
    required this.id,
  });
}


