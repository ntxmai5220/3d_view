import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController username = TextEditingController();
  final RegisterRepository _repository;
  RegisterBloc({required RegisterRepository repository})
      : _repository = repository,
        super(RegisterInitial()) {
    on<RegisterRequestEvent>(register);
  }

  register(RegisterRequestEvent event, Emitter<RegisterState> emit) async {
    if (email.text.isNotEmpty &&
        pw.text.isNotEmpty &&
        username.text.isNotEmpty) {
      if (!Validator.validateEmail(email.text)) {
        emit(RegisterFail(error: ValidatorError.invalidEmail.error));
      } else if (!Validator.validatePw(pw.text)) {
        emit(RegisterFail(error: ValidatorError.pwLength.error));
      } else {
        emit(RegisterLoading());
        try {
          var response = await _repository.signup(
              email: email.text, pw: pw.text, name: username.text);

          User user = response.object;
          debugPrint(user.toJson().toString());
          emit(RegisterSuccess());
        } catch (e) {
          emit(RegisterFail(error: e.toString()));
        }
      }
    } else {
      emit(RegisterFail(error: ValidatorError.emptyField.error));
    }
  }
}
