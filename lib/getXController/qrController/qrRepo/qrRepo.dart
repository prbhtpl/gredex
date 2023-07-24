
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/BeptokenbalCheckModel/beptokenbalCheckModel.dart';
import '../../../model/qrCodeModel/qrCodeModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class QRRepo extends GetConnect {
  Future getQRCode({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.qrCode;
    debugPrint(
        "getQRCodeEndpoint: $endPoint ; getQRCodePayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getQRCode: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return QrModel.fromJson(json);
    } catch (e) {
      print("catch me gya");
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
  Future bepToken({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = "https://gridxecosystem.io:8081/api/v1/bsc/mainnet/beptokenbalcheck";
    //String endPoint = "https://https://hellofarmers.in:8081/api/v1/bsc/mainnet/beptokenbalcheck";
    debugPrint(
        "bepTokenEndpoint: $endPoint ; bepTokenPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "$token","api_key":"Z4EV1HY-787MYJN-NMK9DFP-VZYR5MP"
        })  ;
    debugPrint("bepTokenData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BeptokenbalCheckModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Token Not Found !") {
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
}