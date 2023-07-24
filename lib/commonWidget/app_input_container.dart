import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'appColors.dart';

class AppInputContainer extends StatelessWidget {
  final EdgeInsets? margin, padding;
  final TextInputType? inputType;
  final int? maxLength, maxLines;
  final Color? textBackgroundColor,filledColor;
  final String placeholder;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputFormatter? textInputFormatter;
  final Function(String value)? onTextChange;
  final List<TextInputFormatter>? inputformatter;
  final bool obSecure, enableEdit;

  final Widget? prefixWidget, suffixWidget;
  final String? Function(String?)? validator;
  final GestureTapCallback? onClick;

  AppInputContainer(
      {this.validator,
        this.filledColor,
      this.enableEdit = true,
      this.textBackgroundColor,
      this.margin,
      this.suffixWidget,
      this.prefixWidget,
      this.padding,
      this.inputType,
      this.obSecure = false,
      this.maxLength,
      this.maxLines,
      this.controller,
      this.onTextChange,
      this.placeholder = '',
      this.inputformatter,
      this.textCapitalization,
      this.textInputFormatter,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onClick,
      enabled: enableEdit,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obSecure,
      inputFormatters: inputformatter,
      style:
          TextStyle(color: textBackgroundColor != null ? Colors.white : null),
      keyboardType: inputType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      maxLength: maxLength,
      onChanged: onTextChange,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 15),
          fillColor: filledColor??AppColor().primaryColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none),
          prefixIcon: prefixWidget,
          suffixIcon: suffixWidget,
          hintText: placeholder,
          counterText: "",
          hintStyle: TextStyle(
              color: textBackgroundColor != null ? Colors.grey.shade700 : null),
          border: InputBorder.none),
    );
  }
}
