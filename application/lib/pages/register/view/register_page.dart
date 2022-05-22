import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _pwController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    GlobalKey<FormState> globalKey = GlobalKey<FormState>();
    // final Size size = MediaQuery.of(context).size;

    _toForgotPassword() {
      debugPrint('to forgot');
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ForgotPage()));
    }

    _toLogin() {
      debugPrint('to register');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
      // Navigator.pop(context);
    }

    _toMainPage() {
      debugPrint('to main');
      // Navigator.pushNamed(context, 'main');
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const MainPage()));
    }

    String? validEmail(String? email) {
      if (email!.isEmpty) {
        return 'Email is required';
      }
      return null;
    }

    String? validName(String? name) {
      if (name!.isEmpty) {
        return 'Name is required';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                  child: Form(
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
                          const HeaderLogo('Đăng ký'),
                          const SizedBox(height: 70),
                          MyInputText(
                            hint: 'Tên',
                            controller: _nameController,
                            validator: validName,
                          ),
                          const SizedBox(height: 15),
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
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            alignment: Alignment.centerRight,
                          ),
                          MyButton(
                            'Đăng ký',
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
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 30,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Chưa đã có tài khoản? ',
                      style: TextStyles.tinyContent,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Đăng nhập',
                          style: TextStyles.normalLabel
                              .copyWith(color: AppColors.primary),
                          recognizer: TapGestureRecognizer()..onTap = _toLogin,
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
    );
  }
}
