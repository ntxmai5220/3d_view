import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequestEvent>(login);
  }

  login(LoginRequestEvent event, Emitter<LoginState> emit) {}
}
