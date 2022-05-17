import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';

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

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              const BgOpacity(),
              Form(
                key: globalKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.pageMarginHorizontal),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60,
                        width: double.infinity,
                      ),
                      const HeaderLogo('Đăng nhập'),
                      const SizedBox(height: 80),
                      MyInputText(
                        hint: 'Email',
                        controller: _emailController,
                        validator: validEmail,
                      ),
                      const SizedBox(height: 25),
                      MyInputText(
                        hint: 'Mật khẩu',
                        controller: _pwController,
                        validator: validPw,
                        pw: true,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 35),
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
                      const Expanded(child: SizedBox(height: 100)),
                      RichText(
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
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
