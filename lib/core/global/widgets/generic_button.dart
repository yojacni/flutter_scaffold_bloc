import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericButton extends StatelessWidget {
  const GenericButton({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.color,
    this.textColor = Colors.black,
    this.textSize = 16,
    this.width,
    this.height,
    this.borderColor,
    this.icon,
    this.padding,
    this.depth,
    this.isEnabled = true,
  });

  final Color? color;
  final String btnText;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Color? textColor;
  final double? textSize;
  final Color? borderColor;
  final IconData? icon;
  final EdgeInsetsGeometry? padding;
  final double? depth;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48.0.h,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        child: isEnabled
            ? Text(
                btnText,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : SizedBox(
                width: 25.0.w,
                height: 25.0.h,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 3.0.w,
                ),
              ),
      ),
    );
  }
}
