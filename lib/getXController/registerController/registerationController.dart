import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/commonWidget/bottom_navigation.dart';
import 'package:gredex/getXController/registerController/registerationRepo/registrationRepo.dart';
import 'package:gredex/screens/auth/loginPage/login_page.dart';
import 'package:gredex/screens/auth/otpVerification/otpVerificationScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../screens/auth/loginPage/loginSuccessfulScreen.dart';

class RegistrationController extends GetxController {
  RxBool loaderStatus = false.obs;
  final RegistrationRepo _registrationRepo = Get.put(RegistrationRepo());

  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;

  /* Rx<TextEditingController> password = TextEditingController().obs;*/
  Rx<TextEditingController> referralCode = TextEditingController().obs;
  Rx<String> leftOrRight = ''.obs;
  String? countryCode;
  Rxn<String> sponserId = Rxn();

  @override
  onInit() async {
    super.onInit();

    initData();
  }

  Future<void> initData() async {}

  clearALlValue() {
    fullName.value.clear();
    email.value.clear();
    mobileNumber.value.clear();
    /* password.value.clear();*/
    referralCode.value.clear();
    leftOrRight.value = "";
  }

  Future<void> register() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "sponsor": sponserId != null
          ? referralCode.value.text
          : "GDX${referralCode.value.text}",
      //"mobile": countryCode! + mobileNumber.value.text,
      "name": fullName.value.text,
      "email": email.value.text,
      "position": leftOrRight.value,
      /* "password": password.value.text*/
    };

    try {
      var response =
          await _registrationRepo.register(payload: payload).then((value) {
        if (value != null) {
          AppUtility.showSuccessSnackBar(value.message.toString());

          AppPreference().saveToken(value.data.tokens[0]);
          ShowBox().congratulationDialogueBox(
              imageWidget: Image.asset("assets/backGround.jpg"),
              title: "Congratulations\nYou are now part of Gridx Ecosystem",
              onButtonClick: () {
                Get.to(()=>LoginPage());
              },
              userId:"${value.data.username}",
              name: fullName.value.text,
              password: "${value.data.password}",
              buttonText: "Done",
              context: Get.context!);


          clearALlValue();

          // Get.to(() =>const OTPVerificationScreen());
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("register: ${e.toString()}");
    }

    loaderStatus.value = false;
    update();
  }
}
