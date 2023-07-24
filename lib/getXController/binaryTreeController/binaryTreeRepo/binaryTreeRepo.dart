import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Utility/app_local_db.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../model/binaryTreeModel/binaryErrorTreeModel.dart';
import '../../../model/binaryTreeModel/binaryTreeLeftModel.dart';
import '../../../model/binaryTreeModel/binaryTreeModel.dart';
import '../../../model/binaryTreeModel/binaryTreeRightModel.dart';
import '../../../networkLayer/api_config.dart';
import '../../../networkLayer/network_utility.dart';
import '../../../screens/auth/loginPage/login_page.dart';

class BinaryTreeRepo extends GetConnect{
  Future getBinaryData({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.binaryTree;
   debugPrint("getBinaryDataEndpoint: $endPoint ; getBinaryDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) ;
    debugPrint("getBinaryDataResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return  BinaryTreeModel.fromJson(json);
    } catch (e) {
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
        AppUtility.showErrorSnackBar(response.body["message"]);
      }
    }

  }

  Future getLeftSecondBinaryData({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.binaryTree;
   // debugPrint("getLeftSecondBinaryDataEndpoint: $endPoint ; getLeftSecondBinaryDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"}) ;
   // debugPrint("getLeftSecondBinaryDataResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BinaryTreeLeftModel.fromJson(json);
    } catch (e) {

       // AppUtility.showSuccessSnackBar(response.body["message"]);

    }

  }
  Future getRightSecondBinaryData({required Map<String, dynamic> payload}) async {
    var token = AppPreference().token;
    String endPoint = ApiUrl.binaryTree;
   // debugPrint("getBinaryDataEndpoint: $endPoint ; getBinaryDataPayload: $payload");
    var response = await post(endPoint, payload,
        headers: {"Authorization": "Bearer $token"})  ;
   // debugPrint("getBinaryDataResponse: ${response.body}");
    var json = AppNetworkUtility.responseHandler(response);

    try {
      return BinaryTreeRightModel.fromJson(json);
    } catch (e) {

       // AppUtility.showSuccessSnackBar(response.body["message"]);

    }
  }
}