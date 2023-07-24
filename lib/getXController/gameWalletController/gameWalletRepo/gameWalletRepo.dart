import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/GameWalletListModel/GameWalletListModel.dart';
import '../../../model/WithDrawalSuccessModel/WithDrawalSuccessModel.dart';
import '../../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../../model/withdrawalReportModel/withdrawalReportModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class GameWalletRepo extends GetConnect{
  Future getGameWalletList({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.gameWalletHistories;
    debugPrint(
        "getWithdrawalListpoint: $endPoint ;getWithdrawalListPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("getGameWalletListResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return GameWalletListModel.fromJson(json);
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
  Future gameWalletOtpSend({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.fundTransferToGameWallet;
    debugPrint(
        "gameWalletOtpSendPoint: $endPoint ;gameWalletOtpSendPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("gameWalletOtpSendResponse: ${response.body}");
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
  Future verifyGameWallet({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.fundTransferToGameWalletVerify;
    debugPrint(
        "verifyGameWalletPoint: $endPoint ;verifyGameWalletPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("verifyGameWalletResponse: ${response.body}");
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