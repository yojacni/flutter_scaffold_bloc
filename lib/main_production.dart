import 'package:flutter/widgets.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'core/global/app_config.dart';
import 'core/global/entities/enums/flavor_enum.dart';
import 'di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.initProd();

  await AppConfig.instance.init(FlavorEnum.production);

  await bootstrap(() => App(routerManager: Injector.instance!.getDependency()));
}
