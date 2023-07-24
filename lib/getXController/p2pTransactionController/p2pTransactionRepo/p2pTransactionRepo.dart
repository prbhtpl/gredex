import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/checkUserModel/checkUserModel.dart';
import '../../../model/p2pTransactionSuccesModel/p2pTransactionSuccessModel.dart';
import '../../../model/p2pTransactionhistoryModel/p2pTransactionHistoryModel.dart';
import '../../../model/wihdrawalOtpSend/withdrawalOtpSend.dart';
import '../../../model/withdrawalVerify/withdrawalVerify.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class P2PTransactionRepo extends GetConnect {
  Future p2pTransaction({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.p2pTransaction;
    debugPrint(
        "p2pTransactionEndpoint: $endPoint ; p2pTransactionDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("p2pTransactionResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return WithdrawalModelOtpSend.fromJson(json);
      //return P2PTransactionSuccesModel.fromJson(json);
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
         AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }
  Future verifyP2P({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.p2pTransactionVerify;
    debugPrint(
        "verifyP2PPoint: $endPoint ;verifyP2PPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("verifyP2PResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return WithdrawalVerify.fromJson(json);
    } catch (e) {
      print("catch me gya");
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

  Future getTransactionHistory({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.transactionHistory;
    debugPrint("getTransactionHistoryEndpoint: $endPoint ;getTransactionHistoryDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) .timeout(const Duration(seconds: 300));
    debugPrint("cgetTransactionHistoryResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return P2PTransactionHistoryModel.fromJson(json);
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

}
