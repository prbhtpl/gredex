import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/updateSuccessfullyModel/updateSucessfullyModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class UpdateProfileRepo extends GetConnect {
  Future updateProfile({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.updateProfile;

    debugPrint(
        "getAllRecentTransactionEndpoint: $endPoint ;getAllRecentTransactionPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("getAllRecentTransactionResponse: ${response.body}");

    var json = AppNetworkUtility.responseHandler(response);

    try {
      return UpdatedSuccessfullyModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
      //  AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }

  Future updateEmailMobile({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.updateEmailMobile;

    debugPrint(
        "getAllRecentTransactionEndpoint: $endPoint ;getAllRecentTransactionPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("getAllRecentTransactionResponse: ${response.body}");

    var json = AppNetworkUtility.responseHandler(response);

    try {
      return UpdatedSuccessfullyModel.fromJson(json);
    } catch (e) {
      if (response.body["status"] == false) {
      //  AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }

  Future otpVerifyEmailAndNumber(
      {required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.otpVerifyAndUpdate;

    debugPrint(
        "otpVerifyEmailAndNumberEndpoint: $endPoint ;otpVerifyEmailAndNumberPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("otpVerifyEmailAndNumberResponse: ${response.body}");

    var json = AppNetworkUtility.responseHandler(response);

    try {
      return UpdatedSuccessfullyModel.fromJson(json);
    } catch (e) {print("catchMe gya");
      if (response.body["status"] == false) {
      //  AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
}
