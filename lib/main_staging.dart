import 'package:flutter/widgets.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'di/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injector.initStaging();

  await bootstrap(() => App(routerManager: Injector.instance!.getDependency()));
}
