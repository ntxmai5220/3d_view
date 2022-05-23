import 'package:bk_3d_view/models/models.dart';
import 'package:bk_3d_view/pages/login/bloc/login_bloc.dart';
import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _emailController = TextEditingController();
//     TextEditingController _pwController = TextEditingController();
//     GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'login');
//     // final Size size = MediaQuery.of(context).size;

//     _toForgotPassword() {
//       debugPrint('to forgot');
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => const ForgotPage()));
//     }

//     _toRegister() {
//       debugPrint('to register');
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const RegisterPage()));
//     }

//     _toMainPage() {
//       debugPrint('to main');
//       // Navigator.pushNamed(context, 'main');
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const MainPage()));
//     }

//     String? validEmail(String? email) {
//       if (email!.isEmpty) {
//         return 'Email is required';
//       } else if (Validator.validateEmail(email)) {
//         return 'Email không hợp lệ';
//       }
//       return null;
//     }

//     String? validPw(String? pw) {
//       if (pw!.isEmpty) {
//         return 'Password is required';
//       }
//       return null;
//     }

//     bool validation() {
//       debugPrint('valid');
//       // FocusScope.of(context).requestFocus(FocusNode());
//       FormState? form = formKey.currentState;

//       if (form?.validate() ?? false) {
//         form?.save();
//         return true;
//       }
//       return false;
//     }

//     _login() {
//       // debugPrint('login');
//       if (validation()) {
//         //login success
//         // debugPrint('login');
//         _toMainPage();
//       } else {
//         debugPrint('error');
//       }
//     }

//     Size size = MediaQuery.of(context).size;
//     return RepositoryProvider(
//       create: (context) => LoginRepository(),
//       child: BlocProvider(
//         create: (context) => LoginBloc(),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           body: SizedBox(
//             height: size.height,
//             width: size.width,
//             child: Stack(
//               children: [
//                 const BgOpacity(),
//                 SingleChildScrollView(
//                   child: SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: AppConstants.pageMarginHorizontal),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 50,
//                             width: double.infinity,
//                           ),
//                           const HeaderLogo('Đăng nhập'),
//                           BlocBuilder<LoginBloc, LoginState>(
//                             builder: (context, state) {
//                               return Container(
//                                 height: 85,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                                 child: state is LoginFail
//                                     ? ErrorMessage(content: state.error)
//                                     : null,
//                               );
//                             },
//                           ),
//                           MyInputText(
//                             hint: 'Email',
//                             controller: _emailController,
//                             validator: (value) => validEmail(value),
//                           ),
//                           const SizedBox(height: 15),
//                           MyInputText(
//                             hint: 'Mật khẩu',
//                             controller: _pwController,
//                             validator: (value) => validPw(value),
//                             pw: true,
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(top: 5, bottom: 30),
//                             alignment: Alignment.centerRight,
//                             child: GestureDetector(
//                               onTap: () => _toForgotPassword(),
//                               child: const Text(
//                                 'Quên mật khẩu?',
//                                 style: TextStyles.tinyLabel,
//                               ),
//                             ),
//                           ),
//                           MyButton(
//                             'Đăng nhập',
//                             bgColor: AppColors.primary,
//                             onClick: () => context
//                                 .read<LoginBloc>()
//                                 .add(LoginRequestEvent()),
//                           ),
//                           const SizedBox(height: 20),
//                           const MyDivider(),
//                           const SizedBox(height: 20),
//                           GuestContinue(() => _toMainPage),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   left: 0,
//                   bottom: 30,
//                   child: Center(
//                     child: RichText(
//                       text: TextSpan(
//                         text: 'Chưa có tài khoản? ',
//                         style: TextStyles.tinyContent,
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: 'Đăng ký',
//                             style: TextStyles.normalLabel
//                                 .copyWith(color: AppColors.primary),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = _toRegister,
//                           ),
//                           const TextSpan(text: ' ngay')
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => LoginRepository(),
      child: BlocProvider(
        create: (context) => LoginBloc(
            repository: RepositoryProvider.of<LoginRepository>(context)),
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) {
            return (previous is LoginLoading && current is! LoginLoading) ||
                (previous is! LoginLoading && current is LoginLoading);
          },
          listener: (context, state) {
            if (state is LoginFail) {
              Navigator.of(context).pop();
            } else if (state is LoginSuccess) {
              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (_) => const MainPage()));
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainPage()),
                  (route) => false);
            } else {
              ShowMyDialog.show(context, dialog: const LoadingDialog());
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  const BgOpacity(),
                  SingleChildScrollView(
                    child: SafeArea(
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
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return Container(
                                  height: 85,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: state is LoginFail
                                      ? ErrorMessage(content: state.error)
                                      : null,
                                );
                              },
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return MyInputText(
                                  hint: 'Email',
                                  controller: context.read<LoginBloc>().email,
                                );
                              },
                            ),
                            const SizedBox(height: 15),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return MyInputText(
                                  hint: 'Mật khẩu',
                                  controller: context.read<LoginBloc>().pw,
                                  pw: true,
                                );
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 30),
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => _toForgotPassword(),
                                child: const Text(
                                  'Quên mật khẩu?',
                                  style: TextStyles.tinyLabel,
                                ),
                              ),
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return MyButton(
                                  'Đăng nhập',
                                  bgColor: AppColors.primary,
                                  onClick: () => context
                                      .read<LoginBloc>()
                                      .add(LoginRequestEvent()),
                                );
                              },
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
      ),
    );
  }
}
