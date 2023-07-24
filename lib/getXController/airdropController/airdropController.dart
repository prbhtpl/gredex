import 'package:get/get.dart';
import 'package:gredex/getXController/airdropController/airdropRepo/airdropRepo.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';

import '../../Utility/app_utility.dart';
import '../../model/airdropModel/airdropModel.dart';

class AirdropController extends GetxController {
  AirdropRepo airdropRepo = Get.put(AirdropRepo());
  HomePageController homePageController = Get.put(HomePageController());
  RxBool loaderStatus = false.obs;
  var airDropModel = Rxn<AirDropModel>();

  initData({required String airdropFilterString}) {
    getAllAirDrop(airdropFilterString: airdropFilterString);
  }

  Future<void> getAllAirDrop({required String airdropFilterString}) async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {"dropstype": airdropFilterString};

    try {
      var response =
          await airdropRepo.getAllAirdrop(payload: payload).then((value) {
        if (value != null) {
          airDropModel.value = value;

          update();
        } else {
          airDropModel.value = null;
        }
      });
    } catch (e) {
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }
}
