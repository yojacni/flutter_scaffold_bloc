import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorTextInputWidget extends StatelessWidget {
  const ErrorTextInputWidget({
    super.key,
    required this.isVisible,
    this.errorText,
    this.padding,
    this.autoSize = true,
  });
  final bool isVisible;
  final String? errorText;
  final EdgeInsetsGeometry? padding;
  final bool autoSize;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: padding ?? EdgeInsets.only(top: 15.0.h),
        child: autoSize ? AutoSizeText(
          errorText ?? 'Required field',
          style: TextStyle(
            fontSize: 12.0.sp,
            color: Colors.red,
          ),
        ) : Text(
          errorText ?? 'Required field',
          style: TextStyle(
            fontSize: 12.0.sp,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
