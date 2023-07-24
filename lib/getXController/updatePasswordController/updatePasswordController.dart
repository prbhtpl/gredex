import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gredex/getXController/updatePasswordController/updatePasswordRepo/updatePasswordRepo.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/commonClassModel/commonClassModel.dart';
import '../../model/updateSuccessfullyModel/updateSucessfullyModel.dart';
import '../../screens/auth/loginPage/login_page.dart';

class UpdatePassword extends GetxController {
  var changePasswordKey = GlobalKey<FormState>();

  RxBool loaderStatus = false.obs;
  Rx<TextEditingController> oldPassword = TextEditingController().obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;

  Rx<String> otp = "".obs;

  var updatedSuccessfullyModel = Rxn<UpdatedSuccessfullyModel>();
  var commonClassModel = Rxn<CommonClassModel>();
  UpdatePasswordRepo updatePasswordRepo = Get.put(UpdatePasswordRepo());

  @override
  onInit() async {
    super.onInit();
    initData();
  }

  initData() {
    sendOtp();
  }
  clearAllValue(){
  oldPassword.value.clear();
    newPassword.value.clear() ;
     confirmPassword.value.clear();
     otp.value = "";
  }

  Future<void> sendOtp() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await updatePasswordRepo.sendOtp(payload: payload).then((value) {

        if (value != null) {AppUtility.showSuccessSnackBar(value.message.toString());
          updatedSuccessfullyModel.value = value;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("sendOtp: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> updatePassword() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "oldPassword": oldPassword.value.text,
      "newPassword": newPassword.value.text,
      "confirmPassword": confirmPassword.value.text,
      "otp": otp.value
    };

    try {
      var response = await updatePasswordRepo
          .updatePassword(payload: payload)
          .then((value) {

        if (value != null) {
          AppUtility.showSuccessSnackBar(value.message.toString());
          commonClassModel.value = value;
          AppPreference().logout();
        ShowBox().showBox(
            text: "Password Updated ",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("updatePassword: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }
}
