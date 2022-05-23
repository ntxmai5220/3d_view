import 'package:bk_3d_view/pages/pages.dart';
import 'package:bk_3d_view/pages/register/bloc/register_bloc.dart';
import 'package:bk_3d_view/repositories/repositories.dart';
import 'package:bk_3d_view/values/values.dart';
import 'package:bk_3d_view/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _toLogin() {
      debugPrint('to register');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
      // Navigator.pop(context);
    }

    _toMainPage() {
      debugPrint('to main');
      // Navigator.pushNamed(context, 'main');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const MainPage()));
    }

    Size size = MediaQuery.of(context).size;
    return RepositoryProvider(
      create: (context) => RegisterRepository(),
      child: BlocProvider(
        create: (context) => RegisterBloc(
            repository: RepositoryProvider.of<RegisterRepository>(context)),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (previous, current) {
              return (previous is RegisterLoading &&
                      current is! RegisterLoading) ||
                  (previous is! RegisterLoading && current is RegisterLoading);
            },
            listener: (context, state) {
              // TODO: implement listener
              if (state is RegisterFail) {
                Navigator.of(context).pop();
              } else if (state is RegisterSuccess) {
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
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  return Container(
                                    height: 85,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: state is RegisterFail
                                        ? ErrorMessage(content: state.error)
                                        : null,
                                  );
                                },
                              ),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  return MyInputText(
                                    hint: 'Tên',
                                    controller:
                                        context.read<RegisterBloc>().username,
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  return MyInputText(
                                    hint: 'Email',
                                    controller:
                                        context.read<RegisterBloc>().email,
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  return MyInputText(
                                    hint: 'Mật khẩu',
                                    controller: context.read<RegisterBloc>().pw,
                                    pw: true,
                                  );
                                },
                              ),
                              const SizedBox(height: 25),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  return MyButton(
                                    'Đăng ký',
                                    bgColor: AppColors.primary,
                                    onClick: () => context
                                        .read<RegisterBloc>()
                                        .add(RegisterRequestEvent()),
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
                            text: 'Chưa đã có tài khoản? ',
                            style: TextStyles.tinyContent,
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Đăng nhập',
                                style: TextStyles.normalLabel
                                    .copyWith(color: AppColors.primary),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _toLogin,
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
      ),
    );
  }
}
