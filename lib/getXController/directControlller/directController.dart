import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';

import '../../Utility/app_utility.dart';
import '../../model/USDTTradingModel/UsdtTradingModel.dart';
import '../../model/directRewardModel/directRewardModel.dart';
import '../../model/matchingRewardModel/matchingRewardModel.dart';
import 'directRepo/directRepo.dart';

class DirectRewardController extends GetxController{
  RxBool loaderStatus = false.obs;
  DirectRewardRepo directRewardRepo =Get.put(DirectRewardRepo());
  HomePageController homePageController =Get.put(HomePageController());
  var directRewardModel=Rxn<DirectRewardModel>();
  var usdtTradingHistoryModel=Rxn<UsdtTradingHistoryModel>();
  List<DirectRewardList> directRewardList=List.empty(growable: true);
  List<USDTTradingList> usdtTradingList=List.empty(growable: true);
  RxInt pageAll = 1.obs;
  @override
  void onReady(){
    initData();
    super.onReady();
  }
  initData() {
    pageAll.value=1;
    getDirectReward();
    getUSDTTrading();
  }
  Future<void> getDirectReward({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };

    try {
      var response =
      await directRewardRepo.directReward(payload: payload).then((value) {

        if (value != null) {
          directRewardModel.value = value;
          pageAll.value = pageNumber;
          directRewardList = directRewardModel.value!.data;
        }else{
          // directRewardList=[];
        }
      });

    } catch (e) {
      debugPrint("getDirectReward $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
  Future<void> getUSDTTrading({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };

    try {
      var response =
      await directRewardRepo.getUSDTTrading(payload: payload).then((value) {
        if (value != null) {
          usdtTradingHistoryModel.value = value;
          pageAll.value = pageNumber;
          usdtTradingList = usdtTradingHistoryModel.value!.data;
        }else{

        }
      });

    } catch (e) {
      debugPrint("getDirectReward $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}