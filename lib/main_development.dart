import 'dart:io';

import 'package:flutter/widgets.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'core/global/app_config.dart';
import 'core/global/entities/enums/flavor_enum.dart';
import 'core/network/utils/custom_http_overrides.dart';
import 'di/injector.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Injector.initDev();
  await AppConfig.instance.init(FlavorEnum.development);

  await bootstrap(
    () => App(
      routerManager: Injector.instance!.getDependency(),
    ),
  );
}
