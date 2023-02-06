// ignore_for_file: unused_element
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scaffold_bloc/core/global/widgets/error_text_input_widget.dart';
import 'package:flutter_scaffold_bloc/core/navigator/router.dart';
import 'package:flutter_scaffold_bloc/feature/account_management/presentation/pages/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/entities/enums/submission_status_enum.dart';
import '../../../../../core/global/widgets/generic_button.dart';
import '../../../../../core/global/widgets/generic_input.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../di/injector.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static String routeName = '/sign-up';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        Injector.instance!.getDependency(),
        Injector.instance!.getDependency(),
      ),
      child: GestureDetector(
        onTap: () => Utils.hideKeyBoard(context),
        child: const _SignUpView(),
      ),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Injector.instance!.routerManager.goBack(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.status == SubmissionStatusEnum.success) {
            Injector.instance!.routerManager.replace(
              context,
              LoginPage.routeName,
            );
          }
        },
        buildWhen: (previous, current) {
          return previous.status != current.status;
        },
        builder: (context, state) {
          return SafeArea(
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const _Header(),
                        SizedBox(
                          height: 80.h,
                        ),
                        const _SignUpForm(),
                        SizedBox(
                          height: 50.h,
                        ),
                        const _SignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Create your\nAccount',
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
            prefixIcon: const Icon(Icons.person_2_outlined),
            hintText: 'Full Name',
            onChanged: (value) {
              context
                  .read<SignUpBloc>()
                  .add(SignUpNameChangedEvent(name: value));
            },
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) {
              return previous.name != current.name;
            },
            builder: (context, state) {
              return ErrorTextInputWidget(
                isVisible: state.nameErrorText.isNotEmpty,
              );
            },
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Row(
            children: [
              Flexible(
                flex: 3,
                child: GenericInput(
                  isReadOnly: true,
                  initialValue: '+1',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.phone),
                  hintText: ' Code',
                  onChanged: (value) {},
                ),
              ),
              Flexible(
                child: Container(),
              ),
              Flexible(
                flex: 5,
                child: GenericInput(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.phone_iphone_outlined),
                  hintText: 'Phone Number',
                  onChanged: (value) {
                    context
                        .read<SignUpBloc>()
                        .add(SignUpPhoneNumberChangedEvent(phoneNumber: value));
                  },
                ),
              )
            ],
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) {
              return previous.phoneNumber != current.phoneNumber;
            },
            builder: (context, state) {
              return ErrorTextInputWidget(
                isVisible: state.phoneErrorText.isNotEmpty,
              );
            },
          ),
          SizedBox(
            height: 20.0.h,
          ),
          GenericInput(
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: 'Email',
            onChanged: (value) {
              context
                  .read<SignUpBloc>()
                  .add(SignUpEmailChangedEvent(email: value));
            },
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
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
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_outline),
            isObscureText: true,
            hintText: 'Password',
            onChanged: (value) {
              context
                  .read<SignUpBloc>()
                  .add(SignUpPasswordChangedEvent(password: value));
            },
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) {
              return previous.password != current.password;
            },
            builder: (context, state) {
              return ErrorTextInputWidget(
                isVisible: state.passwordErrorText.isNotEmpty,
              );
            },
          ),
          SizedBox(
            height: 20.0.h,
          ),
          GenericInput(
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_outline),
            isObscureText: true,
            hintText: 'Confirmation Password',
            onChanged: (value) {
              context.read<SignUpBloc>().add(
                    SignUpConfirmationPasswordChangedEvent(
                      confirmationPassword: value,
                    ),
                  );
            },
          ),
          BlocBuilder<SignUpBloc, SignUpState>(
            buildWhen: (previous, current) {
              return previous.confirmationPassword !=
                  current.confirmationPassword;
            },
            builder: (context, state) {
              return ErrorTextInputWidget(
                isVisible: state.confirmationPasswordErrorText.isNotEmpty,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return GenericButton(
          btnText: 'Sign Up',
          isEnabled: state.status != SubmissionStatusEnum.sent,
          onPressed: () {
            context.read<SignUpBloc>().add(SignUpSubmittedEvent());
          },
        );
      },
    );
  }
}
