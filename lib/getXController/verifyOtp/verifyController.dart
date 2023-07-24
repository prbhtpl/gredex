import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_local_db.dart';
import 'package:gredex/commonWidget/bottom_navigation.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/loginController/loginController.dart';
import 'package:gredex/getXController/verifyOtp/verifyOtpRepo/verifyOtpRepo.dart';
import 'package:gredex/screens/auth/loginPage/loginSuccessfulScreen.dart';
import 'package:gredex/screens/auth/loginPage/login_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../Utility/app_utility.dart';
import '../../model/forgetPasswordSuccesFulModel/forgetpasswordSuccessfulModel.dart';

class VerifyController extends GetxController {
  RxBool loaderStatus = false.obs;

  Rx<String> otp = "".obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;

  final VerifyOtpRepo _verifyOtpRepo = Get.put(VerifyOtpRepo());
  final LoginController loginController = Get.put(LoginController());
  var forgetPasswordSuccessfulModel = Rxn<ForgetPasswordSuccesfullModel>();

  @override
  onInit() async {
    super.onInit();

    initData();
  }
clearAllValue(){
  newPassword.value.clear();
  confirmPassword.value.clear();
  otp.value="";
}
  Future<void> initData() async {}

  Future<void> verify() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "userId": loginController.userId.value.text,
      "newPassword": newPassword.value.text,
      "confirmPassword": confirmPassword.value.text,
      "otp": otp.value
    };

    try {
      var response =
          await _verifyOtpRepo.verifyOtp(payload: payload).then((value) {
        print("value+${value.message}");
        if (value != null) {
          if (value.message != "Incorrect OTP!") {
            AppUtility.showSuccessSnackBar(value.message.toString());
            forgetPasswordSuccessfulModel.value = value;
            Get.to(const LoginPage());
          } else {
            AppUtility.showSuccessSnackBar(value.message.toString());
          }

        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("verify: ${e.toString()}");
    }

    loaderStatus.value = false;
    update();
  }
}
