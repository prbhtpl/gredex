import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/fundRequestHistoryModel/fundRequestHistoryModel.dart';
import '../../../model/fundRequestModel/fundRequestModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class FundRequestRepo extends GetConnect {
  Future addFundRequest({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.fundRequest;
    debugPrint(
        "activateAccountEndpoint: $endPoint ; activateAccountDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("activateAccountResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return FundRequestModel.fromJson(json);
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
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }

  Future getFunRequestHistory({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.fundRequestList;
    debugPrint(
        "getFunRequestHistoryEndpoint: $endPoint ;getFunRequestHistoryDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getFunRequestHistory: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return FundRequestHistoryModel.fromJson(json);
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
