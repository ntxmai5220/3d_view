import 'package:bk_3d_view/helpers/shared_references.dart';
import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/repositories/repositories.dart';

import 'package:bk_3d_view/values/app_enum.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  final LoginRepository _repository;
  LoginBloc({required LoginRepository repository})
      : _repository = repository,
        super(LoginInitial()) {
    on<LoginRequestEvent>(login);
  }

  login(LoginRequestEvent event, Emitter<LoginState> emit) async {
    if (email.text.isNotEmpty && pw.text.isNotEmpty) {
      if (!Validator.validateEmail(email.text)) {
        emit(LoginFail(error: ValidatorError.invalidEmail.error));
        // } else if (!Validator.validatePw(pw.text)) {
        //   emit(LoginFail(error: ValidatorError.pwLength.error));
      } else {
        emit(LoginLoading());
        try {
          var response =
              await _repository.login(email: email.text, pw: pw.text);

          User user = response.object;
          if (user.accessToken != null && user.id != null) {
            await HelperSharedPreferences.saveToken(user.accessToken!);

            var a = await HelperSharedPreferences.getToken();
            await HelperSharedPreferences.saveUserId(user.id!);
            await HelperSharedPreferences.saveAdmin(user.isAdmin ?? false);
            await HelperSharedPreferences.saveUserLogin(true);
            await HelperSharedPreferences.saveListFollow(user.follows ?? []);
            debugPrint(a);
          } else {
            emit(LoginFail());
          }

          debugPrint(user.toJson().toString());
          emit(LoginSuccess());
        } catch (e) {
          emit(LoginFail(error: e.toString()));
        }
      }
    } else {
      emit(LoginFail(error: ValidatorError.emptyField.error));
    }
  }
}
