import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/registerPageUnderAppController/registerUnderAppRepo/registerUnderAppRepo.dart';

import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';

class RegisterUnderAppController extends GetxController {
  RxBool loaderStatus = false.obs;
  final RegisterUnderAppRepo registerUnderAppRepo =
      Get.put(RegisterUnderAppRepo());

  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;

/*  Rx<TextEditingController> password = TextEditingController().obs;*/
  Rx<TextEditingController> referralCode = TextEditingController().obs;
  Rx<String> leftOrRight = ''.obs;

  String? choose;
  String? countryCode;

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
    choose = null;
  }

  Future registerUnderApp() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "sponsor": "GDX${referralCode.value.text}",
      // "mobile": countryCode! + mobileNumber.value.text,
      "name": fullName.value.text,
      "email": email.value.text,
      "position": leftOrRight.value,
      /*  "password": password.value.text*/
    };

    var response = await registerUnderAppRepo
        .registerUnderApp(payload: payload)
        .then((value) {
      if (value != null) {
        AppUtility.showSuccessSnackBar(value.message.toString());

        ShowBox().congratulationDialogueBox(
            imageWidget: Image.asset("assets/backGround.jpg"),
            title: "Congratulations\nYou are now part of Gridx Ecosystem",
            onButtonClick: () {
              Get.back();
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
    return true;

    loaderStatus.value = false;
    update();
  }
}
