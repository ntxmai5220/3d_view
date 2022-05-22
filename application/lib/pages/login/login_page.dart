import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/login/bloc/login_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _pwController = TextEditingController();
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    // final Size size = MediaQuery.of(context).size;

    _toForgotPassword() {
      debugPrint('to forgot');
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ForgotPage()));
    }

    _toRegister() {
      debugPrint('to register');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const RegisterPage()));
    }

    _toMainPage() {
      debugPrint('to main');
      // Navigator.pushNamed(context, 'main');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainPage()));
    }

    String? validEmail(String? email) {
      if (email!.isEmpty) {
        return 'Email is required';
      } else if (Validator.validateEmail(email)) {
        return 'Email không hợp lệ';
      }
      return null;
    }

    String? validPw(String? pw) {
      if (pw!.isEmpty) {
        return 'Password is required';
      }
      return null;
    }

    bool validation() {
      debugPrint('valid');
      // FocusScope.of(context).requestFocus(FocusNode());
      FormState? form = globalKey.currentState;

      if (form!.validate()) {
        form.save();
        return true;
      }
      return false;
    }

    _login() {
      // debugPrint('login');
      if (validation()) {
        //login success
        // debugPrint('login');
        _toMainPage();
      } else {
        debugPrint('error');
      }
    }

    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => LoginRepository(),
      child: BlocProvider(
        create: (context) => LoginBloc(),
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                const BgOpacity(),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Stack(
                      children: [
                        Form(
                          key: globalKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.pageMarginHorizontal),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                ),
                                const HeaderLogo('Đăng nhập'),
                                const SizedBox(height: 70),
                                MyInputText(
                                  hint: 'Email',
                                  controller: _emailController,
                                  validator: validEmail,
                                ),
                                const SizedBox(height: 15),
                                MyInputText(
                                  hint: 'Mật khẩu',
                                  controller: _pwController,
                                  validator: validPw,
                                  pw: true,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, bottom: 35),
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: _toForgotPassword,
                                    child: const Text(
                                      'Quên mật khẩu?',
                                      style: TextStyles.tinyLabel,
                                    ),
                                  ),
                                ),
                                MyButton(
                                  'Đăng nhập',
                                  bgColor: AppColors.primary,
                                  onClick: _login,
                                ),
                                const SizedBox(height: 20),
                                const MyDivider(),
                                const SizedBox(height: 20),
                                GuestContinue(_toMainPage),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 30,
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Chưa có tài khoản? ',
                        style: TextStyles.tinyContent,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Đăng ký',
                            style: TextStyles.normalLabel
                                .copyWith(color: AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _toRegister,
                          ),
                          const TextSpan(text: ' ngay')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
