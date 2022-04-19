part of 'new_post_bloc.dart';

@immutable
abstract class NewPostEvent {}

class NewPostNextEvent extends NewPostEvent{}

class NewPostBackEvent extends NewPostEvent {}

class NewPostDoneEvent extends NewPostEvent {}
