import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/data/data_source/local_data_source/hive_data_source.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_cubit.dart';
import 'package:ibn_khaldun/auth_and_onboarding_module/presentation/controllers/login/login_state.dart';
import 'package:ibn_khaldun/core/app_locale.dart';
import 'package:ibn_khaldun/core/app_size.dart';
import 'package:ibn_khaldun/core/component/custom_button.dart';
import 'package:ibn_khaldun/core/component/password_box.dart';
import 'package:ibn_khaldun/core/component/text_box.dart';
import 'package:ibn_khaldun/core/constants.dart';
import 'package:ibn_khaldun/core/extensions_helper.dart';
import 'package:ibn_khaldun/parent_module/presentation/screens/children_screen/children_screen.dart';
import 'package:ibn_khaldun/teacher_module/presentation/screens/teacher_table_screen.dart';
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
                langCode == 'ar' ? getLang(context, 'success') : state.message,
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
          HiveDataSource hiveBool =
              HiveDataSource<bool>(AppLocalDataKeys.cacheBoxName);
          hiveBool.set(AppLocalDataKeys.isParent, state.isParent);
          print(state.isParent);
          if (state.isParent) {
            context.pushReplacement(const ChildrenScreen());
          } else {
            context.pushReplacement(const TeacherTableScreen());
          }
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
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: SizedBox(
                              width: context.screenWidth * 0.5,
                              height: context.screenHeight * 0.25,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        });
                  }
                },
                text: getLang(context, 'login'),
              ),
            ],
          ),
        );
      },
    );
  }
}
