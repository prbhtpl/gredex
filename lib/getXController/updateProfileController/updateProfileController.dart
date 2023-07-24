import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/updateProfileController/updateProfileRepo/updateProfileRepo.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/updateSuccessfullyModel/updateSucessfullyModel.dart';
import '../../screens/auth/loginPage/login_page.dart';

class UpdateProfileController extends GetxController {
  RxBool loaderStatus = false.obs;

  UpdateProfileRepo updateProfileRepo = Get.put(UpdateProfileRepo());
  HomePageController homePageController = Get.put(HomePageController());
  var updatedSuccessfullyModel = Rxn<UpdatedSuccessfullyModel>();
  Rx<TextEditingController> fullName = TextEditingController().obs;
  Rx<TextEditingController> gdxAddress = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> otp = TextEditingController().obs;
  String? countryCode;
  @override
  void onInit() {
    initDate();
    // TODO: implement onInit
    super.onInit();
  }

  initDate() {
    clearAllValue();
  }

  clearAllValue() {
    fullName.value.clear();
    gdxAddress.value.clear();
    mobileNumber.value.clear();
    email.value.clear();
    otp.value.clear();
  }

  Future verifyEmailAndNumber({required String type}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "type": type, //mobile can also be use
      "value": type == "email" ? email.value.text :"${countryCode!}${mobileNumber.value.text}"
    };

    try {
      var response = await updateProfileRepo
          .updateEmailMobile(payload: payload)
          .then((value) {

            if(value!=null){
              AppUtility.showSuccessSnackBar(value.message.toString());
              updatedSuccessfullyModel.value = value;
              homePageController.initData();
            }

        /*  if (value.status == true) {
          updatedSuccessfullyModel.value = value;

        } else {
          ShowBox().showBox(
              text: "Session Expired",
              onButtonClick: () {
                AppPreference().logout();
                Get.to(() => const LoginPage());
              },
              titleContent: "Please Login Again",
              buttonText: "Login");
        }*/
      });
      return updatedSuccessfullyModel.value?.status;
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("updateProfile: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> updateProfile() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "name": fullName.value.text.isNotEmpty? fullName.value.text:homePageController.allUserProfileData.value?.data.name,
      "address": gdxAddress.value.text
    };

    try {
      var response =
          await updateProfileRepo.updateProfile(payload: payload).then((value) {

        if (value!=null) {
          if(value.message!="Name Field can not be null!"){ updatedSuccessfullyModel.value = value;
          ShowBox().showBox(
              text: "Congratulations!!",
              onButtonClick: () {
                Get.back();
                /*Get.to(()=>LoginPage());*/

              },
              titleContent: "Profile Updated Successfully",
              buttonText: "Done");
          homePageController.initData();
          //clearAllValue();
          }else{   AppUtility.showErrorSnackBar(value.message.toString());}


        } else {

        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("updateProfile: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }

  Future<void> otpVerifyEmailAndNumber({required String type}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "type": type,
      "value": type == "email" ? email.value.text : mobileNumber.value.text,
      "otp": otp.value.text
    };

    try {
      var response = await updateProfileRepo
          .otpVerifyEmailAndNumber(payload: payload)
          .then((value) {

            if(value!=null){

              AppUtility.showSuccessSnackBar(value.message.toString());
              updatedSuccessfullyModel.value = value;
              homePageController.initData();
            }
        /*  if (value.status == true) {
          updatedSuccessfullyModel.value = value;

        } else {
          ShowBox().showBox(
              text: "Session Expired",
              onButtonClick: () {
                AppPreference().logout();
                Get.to(() => const LoginPage());
              },
              titleContent: "Please Login Again",
              buttonText: "Login");
        }*/
        return updatedSuccessfullyModel.value?.status;
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("otpVerifyEmailAndNumber: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }
}
