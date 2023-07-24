import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gredex/getXController/transactionHistoryController/transactionHistoryRepo/transactionHistoryRepo.dart';

import '../../Utility/app_local_db.dart';
import '../../Utility/app_utility.dart';
import '../../commonWidget/showDialoueBox.dart';
import '../../model/transactionHistoryModel/trasactionHistoryModel.dart';
import '../../screens/auth/loginPage/login_page.dart';

class TransactionHistoryController extends GetxController {
  RxBool loaderStatus = false.obs;

  var transactionHistoryModel = Rxn<TransactionHistoryModel>();
  List<TransactionHistoryList> transactionHistoryList =
      List.empty(growable: true);

  RxInt pageAll = 1.obs;
  final TransactionHistoryRepo transactionHistoryRepo =
      Get.put(TransactionHistoryRepo());
  @override
  void onReady(){
    initData();
    super.onReady();
  }
  initData() {
    allTransactionHistory();
    pageAll.value = 1;
  }

  Future<void> allTransactionHistory({int pageNumber = 1}) async {
    loaderStatus.value = true;

    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };

    try {
      var response = await transactionHistoryRepo
          .getAllRecentTransaction(payload: payload)
          .then((value) {
        if (value != null) {
          pageAll.value = pageNumber;
          transactionHistoryModel.value = value;
        } else {

        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
      debugPrint("allTransactionHistory: ${e.toString()}");
    }
    loaderStatus.value = false;
    update();
  }
}
