import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_utility.dart';
import '../../../model/registerModel/registerModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';

class RegisterUnderAppRepo extends GetConnect{
  Future registerUnderApp({required Map<String, dynamic> payload}) async {
    String endPoint = ApiUrl.register;
    debugPrint("registerEndpoint: $endPoint ; registerPayload: $payload");
    var response = await post(endPoint, payload) .timeout(const Duration(seconds: 300));
    debugPrint("registerResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return RegisterModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
        AppUtility.showErrorSnackBar(response.body["message"]);
      } else {
        AppUtility.showErrorSnackBar(response.body["data"]["errors"][0]["msg"]);
      }
    }
  }
}