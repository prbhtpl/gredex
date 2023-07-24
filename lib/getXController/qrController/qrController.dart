import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:gredex/getXController/qrController/qrRepo/qrRepo.dart';

import '../../Utility/app_utility.dart';
import '../../model/BeptokenbalCheckModel/beptokenbalCheckModel.dart';
import '../../model/qrCodeModel/qrCodeModel.dart';

class QRController extends GetxController {
  RxBool loaderStatus = false.obs;
  QRRepo qRRepo = Get.put(QRRepo());
  var qrModel = Rxn<QrModel>();
  var beptokenbalCheckModel = Rxn<BeptokenbalCheckModel>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
   // BEPTokenBalance();
  }

  Future<void> BEPTokenBalance() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await qRRepo.bepToken(payload: payload).then((value) {
        if (value != null) {
          beptokenbalCheckModel.value = value;
          getQR();
        } else {
          // directRewardList=[];
        }
      });
    } catch (e) {
      debugPrint("getQR $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getQR() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await qRRepo.getQRCode(payload: payload).then((value) {
        if (value != null) {
          qrModel.value = value;
        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getQR $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
