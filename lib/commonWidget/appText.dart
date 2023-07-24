import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils.dart';

class AppText extends StatelessWidget {
  const AppText(
      {this.text,
      this.textLine,
      this.fontSize,
      this.fontWeight,
      this.onTap,
      this.textAlign,
      this.textColor,
      this.underline = false});

  final String? text;
  final bool underline;
  final double? fontSize;
  final GestureTapCallback? onTap;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? textColor;
  final int? textLine;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return InkWell(
      onTap: onTap,
      child: Text(text ?? "",
          textAlign: textAlign ?? TextAlign.center,
          maxLines: textLine,overflow: TextOverflow.ellipsis,
          style: SafeGoogleFont(

            decoration:
                underline ? TextDecoration.underline : TextDecoration.none,
            'Roboto',
            fontSize: fontSize ?? 25,
            fontWeight: fontWeight ?? FontWeight.w700,
            //height: 1.1725*ffem/fem,
            color: textColor ?? Color(0xffffffff),
          )),
    );
  }
}
