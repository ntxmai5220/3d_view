part of 'list_user_bloc.dart';

@immutable
abstract class ListUserState {}

class ListUserInitial extends ListUserState {}

class ListUserLoaded extends ListUserState {
  final List<User> list;
  ListUserLoaded({
    required this.list,
  });
}

class ListUserLoading extends ListUserState {}

class ListUserError extends ListUserState {}
