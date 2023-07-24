import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_utility.dart';
import '../../../model/registerModel/registerModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';

class RegistrationRepo extends GetConnect {
  Future register({required Map<String, dynamic> payload}) async {
    String endPoint = ApiUrl.register;
    debugPrint("registerEndpoint: $endPoint ; registerPayload: $payload");
    var response =
        await post(endPoint, payload) ;
    debugPrint("registerResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return RegisterModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
        AppUtility.showErrorSnackBar(response.body["message"]);
      } else {
        AppUtility.showErrorSnackBar(response.body["message"] );
      }
    }
  }
}
