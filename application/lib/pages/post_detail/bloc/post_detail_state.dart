part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailState {}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoading extends PostDetailState {}

class PostDetailLoaded extends PostDetailState {
  final Post post;
  final User? user;
  PostDetailLoaded({
    required this.post,
    this.user,
  });
}

class PostDetailError extends PostDetailState {
  final String? error;
  PostDetailError({
    this.error,
  });
}
