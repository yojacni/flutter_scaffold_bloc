// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:overlay_support/overlay_support.dart';
// import 'package:the_automedic/core/global/app_globals.dart';

import 'package:flutter/material.dart';

class Utils {
  static void hideKeyBoard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
  }
}
