
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/BonanzaNewModel/BonanzaNewModel.dart';
import '../../../model/bonanzaCompleteModel/bonanzaCompleteModel.dart';
import '../../../model/bonanzaModel/bonanzaModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class BonanzaRepo extends GetConnect {
  Future getBonanza({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.bonanza;
    debugPrint("getBonanzaEndpoint: $endPoint ; getBonanzaPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getTeaMemberData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BonanzaModel.fromJson(json);
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
      } else {}
    }
  }
  Future getBonanzaCompleted({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.completedBonanza;
    debugPrint("getBonanzaCompletedEndpoint: $endPoint ; getBonanzaCompletedPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getBonanzaCompletedData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BonanzaCompleteModel.fromJson(json);
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
      } else {}
    }
  }
  Future getBonanzaNew({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.getBonanzaNew;
    debugPrint("getBonanzaNewEndpoint: $endPoint ;getBonanzaNewPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getBonanzaNewData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BonanzaNewModel.fromJson(json);
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
      } else {}
    }
  }
}
