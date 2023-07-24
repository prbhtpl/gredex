import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/AddSupportTicketModel/AddSupportTicketModel.dart';
import '../../../model/SupportTicketListModel/SupportTicketListModel.dart';
import '../../../model/TicketDeailModel/TicketDeailModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class SupportTicketRepo extends GetConnect{
  Future addSupportTicket({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.createTicket;
    debugPrint(
        "addSupportTicketEndpoint: $endPoint ; addSupportTicketPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("addSupportTicket: ${response.body}");
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
  Future closeTicket({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.closeTicket;
    debugPrint(
        "closeTicketEndpoint: $endPoint ; closeTicketPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("closeTicket: ${response.body}");
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


  Future getSupportTicketList({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.ticketList;
    debugPrint(
        "getSupportTicketListEndpoint: $endPoint ; getSupportTicketListPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
    debugPrint("getSupportTicketList: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return SupportTicketListModel.fromJson(json);
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