import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/GDXTransSucessfulModel/GDXTransSucessfulModel.dart';
import '../../../model/updateSuccessfullyModel/updateSucessfullyModel.dart';
import '../../../model/withdrawalVerify/withdrawalVerify.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class WithdrawalTransRepo extends GetConnect{
  Future sendOtp({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.withdrawalGdx;
    debugPrint(
        "sendOtpDataEndpoint: $endPoint ;sendOtpDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("sendOtpData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return UpdatedSuccessfullyModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
        // AppUtility.showErrorSnackBar(response.body["message"].toString());
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
  Future verifyWithdrawal({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.withdrawalGdxVerify;
    debugPrint(
        "verifyWithdrawalPoint: $endPoint ;verifyWithdrawalPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("verifyWithdrawalResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return GdxTransSucessfulModel.fromJson(json);
    } catch (e) {
      print("catche me gya");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }
}