import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/p2pTransferController/p2pTransferController.dart';

import '../../Utility/app_utility.dart';
import '../../model/CommanModel/CommanModel.dart';
import '../allRequestController/allRequestController.dart';
import '../homePageController/homePageController.dart';
import 'buyRequestRepo/buyRequestRepo.dart';

class BuyRequestController extends GetxController {
  RxBool loaderStatus = false.obs;
  HomePageController homePageController = Get.put(HomePageController());

  P2PTransferController p2pTransferController = Get.put(P2PTransferController());
  RxDouble gdxAmount = 1.0.obs;
  RxInt amountInt = 1.obs;
  BuyRequestRepo buyRequestRepo = Get.put(BuyRequestRepo());
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> convertedAmount = TextEditingController().obs;
  Rx<TextEditingController> convertedAmountUsdInr = TextEditingController().obs;
  RxInt dollarAmount = 1.obs;
  Rx<String> selectedWalletId = "1".obs;
  var commonModel = Rxn<CommonModel>();

  clearAllValue() {
    amount.value.clear();
    selectedWalletId.value = "0";
    convertedAmountUsdInr.value.clear();
    amountInt.value = 1;
    convertedAmount.value.clear();
    gdxAmount.value = 1.0;
    dollarAmount.value = 1;
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {}

  Future<void> p2pSelBuy() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "id": p2pTransferController.requestId.value,
      "requestAmount": amount.value.text,
    };

    try {
      var response = await buyRequestRepo
          .sendRequestToBuyer(payload: payload)
          .then((value) {
        if (value != null) {
          commonModel.value = value;
          if (value.status != false) {
            clearAllValue();
            AppUtility.showSuccessSnackBar(value.message);
            //getP2pRequestList();
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        } else {}
      });
    } catch (e) {
      debugPrint("p2pSelBuy $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
