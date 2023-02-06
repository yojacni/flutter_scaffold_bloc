import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/colors_constants.dart';
import 'core/global/theme/theme.dart';
import 'core/navigator/router.dart';
import 'l10n/l10n.dart';

class App extends StatefulWidget {
  const App({super.key, required this.routerManager});

  final RouterManager routerManager;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     statusBarColor: AppColors.primaryColor,
    //   ),
    // );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BeamerProvider(
          routerDelegate: widget.routerManager.beamerDelegate,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'The Automedic',
            routerDelegate: widget.routerManager.beamerDelegate,
            routeInformationParser: BeamerParser(),
            backButtonDispatcher: BeamerBackButtonDispatcher(
              delegate: widget.routerManager.beamerDelegate,
            ),
            builder: (context, child) {
              return child!;
            },
            theme: getTheme(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            locale: const Locale('en'),
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    widget.routerManager.dispose();
    super.dispose();
  }
}
