import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/teamMemberModel/teamMemberModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class MyTeamRepo extends GetConnect {
  Future getTeaMember({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.getTeamMember;
    debugPrint(
        "getTeaMemberDataEndpoint: $endPoint ; getTeaMemberDataPayload: $payload");
    var response = await post(endPoint, payload,
            headers: {"Authorization": "Bearer $token"})
        .timeout(const Duration(seconds: 3000));
    debugPrint("getTeaMemberData: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return TeamMemberModel.fromJson(json);
    } catch (e) {
      if (response.body["message"] == "Invalid Token!") {
        //AppUtility.showErrorSnackBar(response.body["message"].toString());
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
