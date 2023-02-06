import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors_constants.dart';

class GenericInput extends StatelessWidget {
  const GenericInput(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.isObscureText = false,
      this.onChanged,
      this.validator,
      this.keyboardType,
      this.textCapitalization,
      this.textInputAction,
      this.focusNode,
      this.cursorColor,
      this.initialValue,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.inputFormatters,
      this.controller,
      this.onFieldSubmitted,
      this.prefixText,
      this.suffixText,
      this.prefixIcon});

  final String? hintText;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isObscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Color? cursorColor;
  final String? initialValue;
  final bool isEnabled;
  final bool isReadOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final String? prefixText;
  final String? suffixText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: isEnabled,
      readOnly: isReadOnly,
      initialValue: initialValue,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      focusNode: focusNode,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textInputAction: textInputAction,
      obscureText: isObscureText,
      cursorColor: cursorColor ?? AppColors.primaryColor,
      style: TextStyle(
        color: isEnabled ? const Color(0xFF505050) : AppColors.disabledColor,
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.accentColor,
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
