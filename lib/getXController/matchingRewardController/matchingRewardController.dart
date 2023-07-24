import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/matchingRewardController/MatchingRewardRepo/matchingRewardRepo.dart';

import '../../Utility/app_utility.dart';
import '../../model/GDXTrading/GDXTradingModel.dart';
import '../../model/matchingRewardModel/matchingRewardModel.dart';

class MatchingRewardController extends GetxController {
  RxBool loaderStatus = false.obs;
  MatchingRewardRepo matchingRewardRepo = Get.put(MatchingRewardRepo());
  HomePageController homePageController = Get.put(HomePageController());
  var matchingRewardModel = Rxn<MatchingRewardModel>();
  var gdxTradingModel = Rxn<GdxTradingModel>();
  RxInt pageAll = 1.obs;
  List<GDXTradingList> gdxTradingList = List.empty(growable: true);


  @override
  void onReady(){
    initData();
    super.onReady();
  }
  initData() {
    getGDXTrading();
    getMatchingReward();
  }

  Future<void> getMatchingReward({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };

    try {
      var response = await matchingRewardRepo
          .getMatchingReward(payload: payload)
          .then((value) {

        if (value != null) {
          matchingRewardModel.value = value;
          pageAll.value = pageNumber;


        }else{

        }
      });
      print(response);
    } catch (e) {
      debugPrint("getMatchingReward $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getGDXTrading({int pageNumber = 1}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "page": pageNumber,
    };

    try {
      var response = await matchingRewardRepo
          .getGDXTradings(payload: payload)
          .then((value) {
        if (value != null) {
          gdxTradingModel.value = value;
          pageAll.value = pageNumber;
          gdxTradingList = gdxTradingModel.value!.data;
        }else{

        }
      });

    } catch (e) {
      debugPrint("getGDXTrading $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
