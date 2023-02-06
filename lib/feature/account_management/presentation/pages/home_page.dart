import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold_bloc/di/injector.dart';
import 'package:flutter_scaffold_bloc/feature/account_management/domain/entity/user_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global/widgets/custom_will_pop_scope.dart';
import '../../../../core/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.hideKeyBoard(context),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return CustomWillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const _Header(),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        'Welcome',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0.sp,
        ),
      ),
    );
  }
}
