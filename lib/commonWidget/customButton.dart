import 'package:flutter/cupertino.dart';
import 'package:gredex/commonWidget/appColors.dart';

import '../utils.dart';

class CustomButton extends StatelessWidget {
   CustomButton({this.buttonText="",this.onClickButton,this.buttonColor=const Color(0xff4F96E8)});
final String buttonText;
final Color buttonColor;
final GestureTapCallback? onClickButton;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(onTap: onClickButton,
      child: Container(
        // signinbtnFEQ (0:463)
        //padding: EdgeInsets.fromLTRB(123.04, 16, 121.96, 15),
        //width: double.infinity,
        height: 45,
        decoration: BoxDecoration (
          color:buttonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          // signin22NZv (0:467)
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              buttonText,
              style: SafeGoogleFont (
                'Roboto',
                fontSize: 16,
                fontWeight: FontWeight.w700,

                color: Color(0xfffffaed),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
