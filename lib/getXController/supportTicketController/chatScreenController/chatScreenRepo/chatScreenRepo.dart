import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Utility/app_local_db.dart';
import '../../../../Utility/app_utility.dart';
import '../../../../commonWidget/showDialoueBox.dart';
import '../../../../model/AddSupportTicketModel/AddSupportTicketModel.dart';
import '../../../../model/TicketDeailModel/TicketDeailModel.dart';
import '../../../../networkLayer/api_config.dart';
import '../../../../networkLayer/network_utility.dart';
import '../../../../screens/auth/loginPage/login_page.dart';

class ChatRepo extends GetConnect{
  Future getChatDetails({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.ticketDetails;
    debugPrint(
        "getChatDetailsEndpoint: $endPoint ; getChatDetailsPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getChatDetails: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return TicketDeailModel.fromJson(json);
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
  }  Future sendMessage({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.sendMessage;
    debugPrint(
        "getChatDetailsEndpoint: $endPoint ; getChatDetailsPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getChatDetails: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return AddSupportTicketModel.fromJson(json);
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
}