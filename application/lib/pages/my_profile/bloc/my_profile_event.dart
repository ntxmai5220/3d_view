part of 'my_profile_bloc.dart';

@immutable
abstract class MyProfileEvent {}

class MyProfileInitEvent extends MyProfileEvent {
  final String? userId;

  MyProfileInitEvent(this.userId);
}
