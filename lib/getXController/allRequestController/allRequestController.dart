import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/CommanModel/CommanModel.dart';

import '../../Utility/app_utility.dart';
import '../../commonWidget/appColors.dart';
import '../../commonWidget/app_input_container.dart';
import '../../model/BuyRequestListModel/BuyRequestListModel.dart';
import '../../model/P2PAllRequestModel/P2PAllRequestModel.dart';
import '../../model/P2PRequestListModel/P2PRequestListModel.dart';
import '../../model/SelfRequestListModel/selfRequestListModel.dart';
import 'allRequestRepo/allRequestRepo.dart';

class AllRequestController extends GetxController {
  RxBool loaderStatus = false.obs;
  AllRequestRepo allRequestRepo = Get.put(AllRequestRepo());

  HomePageController homePageController = Get.put(HomePageController());
  var p2PAllRequestModel = Rxn<P2PAllRequestModel>();
  var buyRequestListModel = Rxn<BuyRequestListModel>();
  var selfRequestListModel = Rxn<SelfRequestListModel>();
  var commonModel = Rxn<CommonModel>();
  Rx<TextEditingController> transactionId = TextEditingController().obs;
  Rx<TextEditingController> otp = TextEditingController().obs;


  Rx<String> selfRequestId = "".obs;
  Rx<String> yourRequestId = "".obs;

  RxBool getYourStreamRequestList = false.obs;

  @override
  onReady() {
    super.onReady();
    initData();
  }

  clearAllValue() {
    transactionId.value.clear();
    otp.value.clear();
  }

  initData() {
    getYourStreamRequestList.value=true;


  }



}
