import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_constants.dart';

class AppStyles {
  AppStyles._();

  static const commonBoxDecorationContainer = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.secondaryColor, AppColors.secondaryColor],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      transform: GradientRotation(math.pi / 2),
    ),
  );
}
