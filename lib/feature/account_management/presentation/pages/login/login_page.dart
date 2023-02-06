// ignore_for_file: unused_element

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scaffold_bloc/feature/account_management/presentation/pages/sign_up/sign_up_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/entities/enums/submission_status_enum.dart';
import '../../../../../core/global/widgets/custom_will_pop_scope.dart';
import '../../../../../core/global/widgets/error_text_input_widget.dart';
import '../../../../../core/global/widgets/generic_button.dart';
import '../../../../../core/global/widgets/generic_input.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../di/injector.dart';
import '../../bloc/log_in/log_in_bloc.dart';
import '../home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInBloc(
        Injector.instance!.getDependency(),
        Injector.instance!.getDependency(),
      ),
      child: GestureDetector(
        onTap: () => Utils.hideKeyBoard(context),
        child: const _LoginView(),
      ),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return CustomWillPopScope(
      child: Scaffold(
        body: BlocConsumer<LogInBloc, LoginState>(
          listener: (context, state) {
            if (state.status == SubmissionStatusEnum.success) {
              Injector.instance?.routerManager
                  .replace(context, HomePage.routeName);
            }
          },
          buildWhen: (previous, current) {
            return previous.status != current.status;
          },
          builder: (context, state) {
            return SafeArea(
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _Header(),
                          SizedBox(
                            height: 80.h,
                          ),
                          const _SignUpForm(),
                          SizedBox(
                            height: 50.h,
                          ),
                          const _SignInButton(),
                          SizedBox(
                            height: 20.h,
                          ),
                          const _SignUpButton()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Login',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0.sp,
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericInput(
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: 'Email',
            onChanged: (value) {
              context
                  .read<LogInBloc>()
                  .add(LoginEmailChangedEvent(email: value));
            },
          ),
          BlocBuilder<LogInBloc, LoginState>(
            buildWhen: (previous, current) {
              return previous.email != current.email;
            },
            builder: (context, state) {
              return ErrorTextInputWidget(
                isVisible: state.emailErrorText.isNotEmpty,
              );
            },
          ),
          SizedBox(
            height: 20.0.h,
          ),
          GenericInput(
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.lock_outline),
            isObscureText: true,
            hintText: 'Password',
            onChanged: (value) {
              context
                  .read<LogInBloc>()
                  .add(LoginPasswordChangedEvent(password: value));
            },
          ),
          BlocBuilder<LogInBloc, LoginState>(
            buildWhen: (previous, current) {
              return previous.password != current.password;
            },
            builder: (context, state) {
              return ErrorTextInputWidget(
                isVisible: state.passwordErrorText.isNotEmpty,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return GenericButton(
          btnText: 'LOGIN',
          isEnabled: state.status != SubmissionStatusEnum.sent,
          onPressed: () {
            context.read<LogInBloc>().add(LoginButtonPressedEvent());
          },
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return GenericButton(
          btnText: 'REGISTER',
          onPressed: () {
            if (state.status != SubmissionStatusEnum.sent) {
              Injector.instance!.routerManager
                  .goToNamed(context, SignUpPage.routeName);
            }
          },
        );
      },
    );
  }
}
