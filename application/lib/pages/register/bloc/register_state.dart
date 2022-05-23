part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState{

}


class RegisterSuccess extends RegisterState {}

class RegisterFail extends RegisterState {
  final String? error;
  RegisterFail({
    this.error,
  });
}
