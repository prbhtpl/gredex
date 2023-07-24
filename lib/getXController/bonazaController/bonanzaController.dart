import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/bonanzaModel/bonanzaModel.dart';

import '../../Utility/app_utility.dart';
import '../../model/BonanzaNewModel/BonanzaNewModel.dart';
import '../../model/bonanzaCompleteModel/bonanzaCompleteModel.dart';
import 'boanazaRepo/bonanzaRepo.dart';

class BonanzaController extends GetxController {
  RxBool loaderStatus = false.obs;
  BonanzaRepo bonanzaRepo = Get.put(BonanzaRepo());
  HomePageController homePageController = Get.put(HomePageController());
  var bonanzaModel = Rxn<BonanzaModel>();
  var bonanzaCompleteModel = Rxn<BonanzaCompleteModel>();
  var bonanzaNewModel = Rxn<BonanzaNewModel>();

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
    getBonanza();
    getBonanzaNew();
    getBonanzaCompleted();
  }

  Future<void> getBonanza() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await bonanzaRepo.getBonanza(payload: payload).then((value) {
        if (value != null) {
          bonanzaModel.value = value;
        } else {}
      });
      print(response);
    } catch (e) {
      debugPrint("getBonanza $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getBonanzaCompleted() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await bonanzaRepo.getBonanzaCompleted(payload: payload).then((value) {
        if (value != null) {
          bonanzaCompleteModel.value = value;
        } else {}
      });
      print(response);
    } catch (e) {
      debugPrint("getBonanzaCompleted $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
  Future<void> getBonanzaNew() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response =
          await bonanzaRepo.getBonanzaNew(payload: payload).then((value) {
        if (value != null) {
          bonanzaNewModel.value = value;
        } else {}
      });
      print(response);
    } catch (e) {
      debugPrint("getBonanzaNew $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
