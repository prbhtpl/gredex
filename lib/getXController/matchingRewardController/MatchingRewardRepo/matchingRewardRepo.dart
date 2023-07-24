import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/GDXTrading/GDXTradingModel.dart';
import '../../../model/matchingRewardModel/matchingRewardModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class MatchingRewardRepo extends GetConnect {
  Future getMatchingReward({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.matchingReward;
    debugPrint(
        "getMatchingRewardDataEndpoint: $endPoint ; getMatchingRewardDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getMatchingRewardData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return MatchingRewardModel.fromJson(json);
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
          AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }

  Future getGDXTradings({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.gdxTrading;
    debugPrint(
        "getGDXTradingsDataEndpoint: $endPoint ; getGDXTradingsDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getGDXTradingsData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return GdxTradingModel.fromJson(json);
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
}
