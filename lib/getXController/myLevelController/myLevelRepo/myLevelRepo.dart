import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/allLevelMember/allLevelLeftMemberModel.dart';
import '../../../model/allLevelMember/allLevelMemberModel.dart';
import '../../../model/allLevelMember/allLevelRightMemberModel.dart';

import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class MyLevelRepo extends GetConnect {
  Future getAllLevelMember({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.getMemberByLevel;
    debugPrint(
        "getAllLevelMemberEndpoint: $endPoint ; getAllLevelMemberPayload: $payload");
    var response = await post(endPoint, payload,
            headers: {"Authorization": "Bearer $token"})
         ;

    debugPrint("getAllLevelMemberResponse: ${response.body}");
    debugPrint("getAllLevelMemberResponseStatusCode: ${response.body}");

    var json = AppNetworkUtility.responseHandler(response);
    //    var json = jsonDecode(response.data);

    try {
      return AllLevelMemberModel.fromJson(json);
    } catch (e) {
print("getAllLevelMember cache me gya");
      if (response.body["message"] == "Invalid Token!") {
        AppUtility.showErrorSnackBar(response.body["message"].toString());
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

  Future getAllLeftLevelMember({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.getMemberByLevel;
    debugPrint(
        "getAllLeftLevelMemberEndpoint: $endPoint ; getAllLeftLevelMemberPayload: $payload");

    var response = await post(endPoint, payload,
            headers: {"Authorization": "Bearer $token"})
         ;
    /* var response = await Dio().post(endPoint, data: payload,
      options: Options(
          headers: {"Authorization": "Bearer $token"}
      ),
    );*/
    debugPrint("getAllLeftLevelMemberResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return AllLevelLeftMemberModel.fromJson(json);
    } catch (e) {
      print("getAllLeftLevelMember cache me gya");
      if (response.body["message"] == "Invalid Token!") {
        //   AppUtility.showErrorSnackBar(response.data["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
      //  AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }

  Future getAllRightLevelMember({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.getMemberByLevel;
    debugPrint(
        "getAllRightLevelMemberEndpoint: $endPoint ; getAllRightLevelMemberPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})
         ;

    debugPrint("getAllRightLevelMemberResponse: ${response.body}");
   var json = AppNetworkUtility.responseHandler(response);

    try {
      return AllLevelrightMemberModel.fromJson(json);
    } catch (e) {
      print("getAllRightLevelMember cache me gya");
      if (response.body["message"] == "Invalid Token!") {
        AppUtility.showErrorSnackBar(response.body["message"].toString());
        ShowBox().showBox(
            text: "Session Expired",
            onButtonClick: () {
              AppPreference().logout();
              Get.to(() => const LoginPage());
            },
            titleContent: "Please Login Again",
            buttonText: "Login");
      } else {
       // AppUtility.showSuccessSnackBar(response.body["message"]);
      }
    }
  }
}
