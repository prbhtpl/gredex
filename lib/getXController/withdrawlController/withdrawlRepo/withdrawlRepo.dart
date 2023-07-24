import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/model/withdrawalVerify/withdrawalVerify.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/WithDrawalSuccessModel/WithDrawalSuccessModel.dart';
import '../../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../../model/withdrawalReportModel/withdrawalReportModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class WithdrawalRepo extends GetConnect{
  Future getWithdrawalList({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.withdrawalHistory;
    debugPrint(
        "getWithdrawalListpoint: $endPoint ;getWithdrawalListPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("getWithdrawalListResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return WithdrawalReportModel.fromJson(json);
    } catch (e) {print("catch me gya");
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
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }


  Future withdrawalOtpSend({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.withdrawal;
    debugPrint(
        "withdrawalOtpSendPoint: $endPoint ;withdrawalOtpSendPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("withdrawalOtpSendResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return WithdrawalModelOtpSend.fromJson(json);
    } catch (e) {

      debugPrint("catch me gya: ${response.body}");
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
  Future verifyWithdrawal({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.withdrawalVerify;
    debugPrint(
        "verifyWithdrawalPoint: $endPoint ;verifyWithdrawalPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("verifyWithdrawalResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return WithdrawalSuccessModel.fromJson(json);
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