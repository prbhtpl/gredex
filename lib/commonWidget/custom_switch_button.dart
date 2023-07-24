import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSwitchButton extends StatelessWidget {
  bool isReveres;
double buttonWidth;
double buttonHeight;
String lableText;
Color bgColor;
Color circleColor;
  CustomSwitchButton({Key? key, required this.isReveres,required this.buttonWidth,required this.lableText,required this.bgColor,required this.circleColor,required this.buttonHeight}) : super(key: key);

  RxList<Widget> widgetList = <Widget>[].obs;

  @override
  Widget build(BuildContext context) {
    widgetList.value = [ text()];
    return Container(

       // alignment: Alignment.centerLeft,
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70.withOpacity(0.2)),
            color: bgColor,//const Color(0xff00C6D8),
            borderRadius: BorderRadius.circular(25)),
        child: Text(
          lableText,
          style:GoogleFonts.sourceSansPro(
              textStyle:const TextStyle(
                  color: Colors.white,
                  fontSize: 15,fontWeight: FontWeight.bold
              )
          ),
        ) );
  }

  // Widget circle() => Container(
  //   margin:const EdgeInsets.all(1.5),
  //       height: 30,
  //       width: 30,
  //       decoration: BoxDecoration(
  //         color: circleColor,
  //         shape: BoxShape.circle,
  //       ),
  //     );

  Widget text() => Container(
    width: buttonWidth-40,
    alignment: Alignment.center,
    child: Text(
          lableText,
          style:GoogleFonts.sourceSansPro(
            textStyle:const TextStyle(
              color: Colors.white,
              fontSize: 15,fontWeight: FontWeight.bold
            )
          ),
        ),
  );
}
