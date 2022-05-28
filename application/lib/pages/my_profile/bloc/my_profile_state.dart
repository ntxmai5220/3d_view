part of 'my_profile_bloc.dart';

abstract class MyProfileState {
  User? user;
  MyProfileState({
    required this.user,
  });
}

class MyProfileInitial extends MyProfileState {
  MyProfileInitial({required User? user}) : super(user: user);
}

class MyProfileLoading extends MyProfileState {
  MyProfileLoading({required User? user}) : super(user: user);
}

class MyProfileLoaded extends MyProfileState {
  MyProfileLoaded({required User? user}) : super(user: user);

}

class MyProfileError extends MyProfileState {
  MyProfileError({required User? user}) : super(user: user);
}
