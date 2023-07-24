
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/networkLayer/api_config.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/activateModel/activateModel.dart';
import '../../../model/activationHistoryModel/activationHistoryModel.dart';
import '../../../model/activationSucessful/activationSucessful.dart';
import '../../../model/checkUserModel/checkUserModel.dart';
import '../../../model/renewalModel/renewalModel.dart';

import '../../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../../model/withdrawalVerify/withdrawalVerify.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class ActivationHistoryRepo extends GetConnect {
  Future getActivationData({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.activationHistory;
    debugPrint(
        "getActivationDataEndpoint: $endPoint ; getActivationDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
         ;
    debugPrint("getActivationData: ${response.body}");
   var json = AppNetworkUtility.responseHandler(response);

    try {
      return ACtivationHistoryModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {

        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        // AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
  Future verifyActivation({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.packageVerify;
    debugPrint(
        "verifyActivationPoint: $endPoint ;verifyActivationPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("verifyWithdrawalResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return ActivationSucessfulModel.fromJson(json);
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
  Future checkUser({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.checkUser;
    debugPrint("checkUserEndpoint: $endPoint ;checkUserDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("checkUserResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CheckUserModel.fromJson(json);
    } catch (e) {
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
        //AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
   Future activateAccount({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.package;
    debugPrint(
        "activateAccountEndpoint: $endPoint ; activateAccountDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) ;
    debugPrint("activateAccountResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return WithdrawalModelOtpSend.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {

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

  Future getRenewalHistory({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.renewalHistory;
    debugPrint(
        "getRenewalHistoryEndpoint: $endPoint ; getRenewalHistoryDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
         ;

    debugPrint("getRenewalHistoryResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return RenewalModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {

        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
        //  AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
}
