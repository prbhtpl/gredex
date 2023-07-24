import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';

import '../../../model/loginModel/loginModel.dart';
import '../../../model/updateSuccessfullyModel/updateSucessfullyModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';

class LoginRepo extends GetConnect {
  Future login({required Map<String, dynamic> payload}) async {
    String endPoint = ApiUrl.login;
    debugPrint("loginEndpoint: $endPoint ; loginPayload: $payload");
    var response = await post(endPoint, payload);
    debugPrint("loginResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return LoginModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
        AppUtility.showErrorSnackBar(response.body["message"]);
      } else {
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }

  Future forget({required Map<String, dynamic> payload}) async {
    String endPoint = ApiUrl.forgotPassword;
    debugPrint("forgetEndpoint: $endPoint ; forgetPayload: $payload");
    var response = await post(endPoint, payload);
    debugPrint("forgetResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return UpdatedSuccessfullyModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
        AppUtility.showErrorSnackBar(response.body["message"]);
      } else {
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }
  }
}
