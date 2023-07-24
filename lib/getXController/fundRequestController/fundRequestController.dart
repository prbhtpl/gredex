import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/fundRequestController/fundRequestRepo/fundRequestRepo.dart';

import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/fundRequestHistoryModel/fundRequestHistoryModel.dart';
import '../../model/fundRequestModel/fundRequestModel.dart';
import '../homePageController/homePageController.dart';

class FundRequestController extends GetxController {
  RxBool loaderStatus = false.obs;

  Rx<TextEditingController> hash = TextEditingController().obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  FundRequestRepo fundRequestRepo = Get.put(FundRequestRepo());
  RxInt amountInt = 0.obs;
  var fundRequestModel = Rxn<FundRequestModel>();
  var fundRequestHistoryModel = Rxn<FundRequestHistoryModel>();
  List<FunHistoryList> fundRequestHistory = List.empty(growable: true);
  Rx<String> selectedWalletId = "0".obs;
  Rxn<String> selectedWallet = Rxn();

  @override
  onReady() async {
    super.onReady();

    initData();
  }

  initData() {
    getFundRequestHistory();
  }

  clearAllValue() {
    amount.value.clear();
    hash.value.clear();
  }

  Future<void> getFundRequestHistory() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await fundRequestRepo
          .getFunRequestHistory(payload: payload)
          .then((value) {
        if (value != null) {
          fundRequestHistoryModel.value = value;
          fundRequestHistory = fundRequestHistoryModel.value!.data;
        }else{
          fundRequestHistory=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getFundRequestHistory $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> addFund() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "gdxamount": amountInt.value,
      "hash": hash.value.text,
      "wallettype":selectedWalletId == "1" ? "ext" : "gdx"
    };

    try {
     /* if (amountInt.value > 24) {*/
        var response = await fundRequestRepo
            .addFundRequest(payload: payload)
            .then((value) {
          if (value != null) {
            fundRequestModel.value = value;
            ShowBox().showBox(
                text: "Fund Request Send Successfully",
                onButtonClick: () {
                  Get.back();
                },
                titleContent: "",
                buttonText: "Done");
            getFundRequestHistory();
            clearAllValue();
          }
        });
     /* } else {
        AppUtility.showSuccessSnackBar("Amount Should be greater than 25");
      }*/
    } catch (e) {
      debugPrint("addFund $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
