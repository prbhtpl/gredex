import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/forgetPasswordSuccesFulModel/forgetpasswordSuccessfulModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class VerifyOtpRepo extends GetConnect {
  Future verifyOtp({required Map<String, dynamic> payload}) async {
    String endPoint = ApiUrl.forgotPasswordSave;
    debugPrint("verifyOtpnEndpoint: $endPoint ; verifyOtpPayload: $payload");
    var response = await post(endPoint, payload) .timeout(const Duration(seconds: 300));
    debugPrint("verifyOtpResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return ForgetPasswordSuccesfullModel.fromJson(json);
    } catch (e) {
      print("catch me gya");
      AppUtility.showSuccessSnackBar(response.body["message"]);
    }
  }
}
