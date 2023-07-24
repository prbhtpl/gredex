import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/P2PRequestListModel/P2PRequestListModel.dart';

import '../../Utility/app_utility.dart';

import '../../model/CommanModel/CommanModel.dart';
import 'p2pRequestRepo/P2PRequestRepo.dart';

class P2PRequestController extends GetxController {
  Rx<String> selectedAccountId = "1".obs;
  Rxn<String> selectedAccountType = Rxn("upi");
  P2PRequestRepo p2PRequestRepo = Get.put(P2PRequestRepo());
  RxBool loaderStatus = false.obs;
  HomePageController homePageController = Get.put(HomePageController());
  Rx<String> selectedWalletId = "1".obs;
  Rx<TextEditingController> amount = TextEditingController().obs;
  Rx<TextEditingController> rate = TextEditingController().obs;
  Rx<TextEditingController> convertedAmount = TextEditingController().obs;
  Rxn<String> selectedWallet = Rxn("USD");
  RxDouble gdxAmount = 1.0.obs;
  RxInt dollarAmount = 1.obs;
  RxInt amountInt = 1.obs;
  var p2PTransferRequestListModel = Rxn<P2PRequestListModel>();
  var commonModel = Rxn<CommonModel>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
    rate.value.text="1";
    homePageController.initData();
    getP2pRequestList();
  }

  clearAllValue() {
    rate.value.clear();
    amount.value.clear();
    selectedWalletId.value = "0";
    selectedWallet = Rxn();
    amountInt.value = 1;
    convertedAmount.value.clear();
    gdxAmount.value = 1.0;
    dollarAmount.value = 1;
  }

  Future<void> p2pSelBuy() async {
loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "amount": amount.value.text,
      "walletType":  "gdx",
      "userRate":rate.value.text,
      "userRateType":selectedWallet.value?.toLowerCase()
    };

    try {
      var response =
          await p2PRequestRepo.addRequest(payload: payload).then((value) {
        if(value!=null){
          commonModel.value = value;
          if (value.status != false) {
            AppUtility.showSuccessSnackBar(value.message);
            homePageController.initData();
            clearAllValue();
            getP2pRequestList();
          } else {
            print("yha aya h");
            AppUtility.showErrorSnackBar(value.message);
          }
        }else{}
      });
    } catch (e) {
      debugPrint("p2pSelBuy $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getP2pRequestList() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await p2PRequestRepo
          .getAllRequestList(payload: payload)
          .then((value) {
        p2PTransferRequestListModel.value = value;
        if (value.status != false) {
          //  AppUtility.showSuccessSnackBar(value.message);
        } else {
          print("yha aya h");
          AppUtility.showErrorSnackBar(value.message);
        }
      });
    } catch (e) {
      debugPrint("getP2pRequestList $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
  Future<void> deleteRequest({required String id}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "id":id
    };

    try {
      var response = await p2PRequestRepo
          .deleteRequest(payload: payload)
          .then((value) {
        commonModel.value = value;
        if (value.status != false) {
          getP2pRequestList();
          //  AppUtility.showSuccessSnackBar(value.message);
        } else {
          print("yha aya h");
          AppUtility.showErrorSnackBar(value.message);
        }
      });
    } catch (e) {
      debugPrint("p2pTransaction $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
