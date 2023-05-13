import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_state.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/component/custom_button.dart';
import 'package:ibn_khaldun/core/component/password_box.dart';
import 'package:ibn_khaldun/core/component/text_box.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/children_screen.dart';
import 'package:translator/translator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LoginCubit>(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
        String langCode = Localizations.localeOf(context).languageCode;
        if (state is LoginSuccessfullyState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                langCode == 'ar' ? 'تم تسجيل الدخول بنجاح' : state.message,
              ),
            ),
          );
        } else if (state is LoginFailedState) {
          if (langCode == 'ar') {
            state.message
                .translate(
              from: 'en',
              to: 'ar',
            )
                .then(
              (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value.text,
                    ),
                  ),
                );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
        }
        if (state is LoginSuccessfullyState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ChildrenScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formState,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextBox(
                text: getLang(context, 'email'),
                controller: _emailController,
                inputType: TextInputType.emailAddress,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: AppSize.s20h,
                  bottom: AppSize.s30h,
                ),
                child: PasswordBox(
                  controller: _passwordController,
                ),
              ),
              CustomButton(
                onPressed: () {
                  _formState.currentState?.save();
                  if (_formState.currentState?.validate() ?? false) {
                    cubit.login(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
                text: getLang(context, 'login'),
              ),
              /*ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ChildrenScreen(),
                    ),
                  );
                },
                child: const Text('demo access'),
              ),*/
            ],
          ),
        );
      },
    );
  }
}
