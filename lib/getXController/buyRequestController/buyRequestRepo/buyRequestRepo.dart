import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/CommanModel/CommanModel.dart';
import '../../../model/commonClassModel/commonClassModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class BuyRequestRepo extends GetConnect{
  Future sendRequestToBuyer({required Map<String, dynamic> payload,}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.sendRequestSellerToBuyer;
    debugPrint(
        "sendRequestToBuyerPoint: $endPoint ; sendRequestToBuyerPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 300));
    debugPrint("sendRequestToBuyerResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return CommonModel.fromJson(json);
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
        AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
}