import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/totalbalanceHistoryController/totalBalanceRepo/totalBalanceRepo.dart';

import '../../Utility/app_utility.dart';
import '../../model/transactionModel/transactionModel.dart';

class TotalBalanceController extends GetxController {
  RxBool loaderStatus = false.obs;
  final TotalBalanceRepo totalBalanceRepo = Get.put(TotalBalanceRepo());
  var totalTransactionModel = Rxn<TotalTransactionModel>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
    allTransactionHistory();
  }

  Future<void> allTransactionHistory() async {
    loaderStatus.value = true;

    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await totalBalanceRepo
          .getAllRecentTransaction(payload: payload)
          .then((value) {
        if (value != null) {
          totalTransactionModel.value = value;
        } else {}
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("allTransactionHistory: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }
}
