
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/screens/auth/loginPage/login_page.dart';

import '../../Utility/app_local_db.dart';
import '../../commonWidget/appColors.dart';
import '../../commonWidget/bottom_navigation.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});



  @override


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: AnimatedSplashScreen(splashIconSize: 50,
        backgroundColor:AppColor().primaryColor,
        duration: 2500,
        animationDuration:Duration(seconds: 3) ,
        splash: 'assets/splashImage.png',
        nextScreen: AppPreference().token!=""? BottomNavigation():const LoginPage(),
        splashTransition: SplashTransition.rotationTransition,

      ),
    );
  }
}
enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}
