import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/Utility/app_local_db.dart';
import 'package:gredex/commonWidget/bottom_navigation.dart';
import 'package:gredex/getXController/loginController/loginRepo/loginRepository.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:slider_captcha/slider_capchar.dart';

import '../../Utility/app_utility.dart';
import '../../screens/auth/loginPage/loginSuccessfulScreen.dart';
import '../../screens/auth/otpVerification/otpVerificationScreen.dart';

class LoginController extends GetxController {
  RxBool loaderStatus = false.obs;

  Rx<TextEditingController> userId = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  final LoginRepo _loginRepo = Get.put(LoginRepo());

  List<String> imageList = <String>[
    "assets/captcha/captch1.png",
    "assets/captcha/captch2.png",
    "assets/captcha/captch3.png",
    "assets/captcha/captch4.png",
    "assets/captcha/captch5.png",
    "assets/captcha/captch6.png",
    "assets/captcha/captch7.png",
    "assets/captcha/captch8.png",
    "assets/captcha/captch9.png",
    "assets/captcha/captch10.png",
    "assets/captcha/captch11.png",
  ];

  @override
  onInit() async {
    super.onInit();

    initData();
  }

  String imageString = '';

  Future<void> initData() async {
    var rng = Random();
    imageString = imageList[rng.nextInt(10)];
  }

  clearALlValue() {
    userId.value.clear();
    password.value.clear();
  }

  Future<void> login() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "username": "GDX${userId.value.text}",
      "password": password.value.text
    };

    try {
      var response = await _loginRepo.login(payload: payload).then((value) {
        if (value != null) {
          AppUtility.showSuccessSnackBar(value.message.toString());
          clearALlValue();
          AppPreference().saveToken(value.data.tokens[0]);
          PersistentNavBarNavigator.pushNewScreen(
            Get.context!,
            screen: const LoginSuccessfulScreen(),
            // OTPVerificationScreen(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("login: ${e.toString()}");
    }

    loaderStatus.value = false;
    update();
  }
  Future<void> forgetPassword() async {

    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "userId": "GDX${userId.value.text}",

    };

    try {
      var response = await _loginRepo.forget(payload: payload).then((value) {
        if (value != null) {
          AppUtility.showSuccessSnackBar(value.message.toString());
          Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=> OTPVerificationScreen()));



        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("forgetPassword: ${e.toString()}");
    }

    loaderStatus.value = false;
    update();
  }



  final SliderController controller = SliderController();

  captchaDialogueBox() async {
    await Get.defaultDialog(
        title: 'Iam not Robot',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(builder: (context, setState) {
              return SliderCaptcha(
                controller: controller,
                image: Image.asset(imageString),
                colorBar: Colors.blue,
                colorCaptChar: Colors.blue,
                // space: 10,
                // fixHeightParent: false,
                onConfirm: (value) async {
                  return value
                      ? await Future.delayed(const Duration(seconds: 1)).then(
                          (value) {
                            Get.back();
                            login();
                          },
                        )
                      : Fluttertoast.showToast(
                          msg: "Wrong Captcha",
                          textColor: Colors.white70,
                          backgroundColor: Colors.redAccent);
                },
              );
            })
          ],
        ),
        radius: 10.0);
  }
}
