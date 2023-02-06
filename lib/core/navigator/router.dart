import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../feature/account_management/presentation/pages/home_page.dart';
import '../../feature/account_management/presentation/pages/login/login_page.dart';
import '../../feature/account_management/presentation/pages/sign_up/sign_up_page.dart';
import '../utils/logger.dart';

abstract class RouterManager {
  void goBack(BuildContext context);

  void goToNamed(BuildContext context, String path, {Object? data});

  void popToNamed(BuildContext context, String path);

  void replace(BuildContext context, String path, {Object? data});

  BeamerDelegate get beamerDelegate;

  void dispose() {}
}

class BeamerRouter extends RouterManager {
  BeamerRouter(this._logger);

  final Logger _logger;

  @override
  BeamerDelegate get beamerDelegate => _beamerDelegate;

  final _beamerDelegate = BeamerDelegate(
    initialPath: LoginPage.routeName,
    locationBuilder: RoutesLocationBuilder(
      routes: {
        LoginPage.routeName: (context, state, data) => const LoginPage(),
        SignUpPage.routeName: (context, state, data) => const SignUpPage(),
        HomePage.routeName: (context, state, data) => const HomePage(),
      },
    ),
  );

  @override
  void goBack(BuildContext context) {
    context.beamBack();
  }

  @override
  void goToNamed(BuildContext context, String path, {Object? data}) {
    _logger
      ..debug('GO TO PATH: $path')
      ..debug('WITH DATA: $data');

    context.beamToNamed(path, data: data);
  }

  @override
  void popToNamed(BuildContext context, String path) {
    _logger.debug('POP TO PATH: $path');
    context.popToNamed(path);
  }

  @override
  void replace(BuildContext context, String path, {Object? data}) {
    _logger
      ..debug('REPLACED WITH: $path')
      ..debug('WITH DATA: $data');
    context.beamToReplacementNamed(path, data: data);
  }
}
