import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/CommanModel/CommanModel.dart';
import '../../../model/P2PRequestListModel/P2PRequestListModel.dart';

import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class P2PRequestRepo extends GetConnect {
  Future addRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.p2pSell;
    debugPrint("addRequestPoint: $endPoint ;addRequestPayload: $payload");
    var response = await post(endPoint, payload,
            headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("addRequestResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
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

  Future getAllRequestList({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.myP2pSellList;
    debugPrint(
        "getAllRequestListSendPoint: $endPoint ;getAllRequestListPayload: $payload");
    var response = await post(endPoint, payload,
            headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("getAllRequestListSendResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return P2PRequestListModel.fromJson(json);
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


  Future deleteRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.myP2pSellCancel;
    debugPrint(
        "getAllRequestListSendPoint: $endPoint ;getAllRequestListPayload: $payload");
    var response = await post(endPoint, payload,
            headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("getAllRequestListSendResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
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
}
