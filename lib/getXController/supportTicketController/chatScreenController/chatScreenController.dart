import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Utility/app_utility.dart';
import '../../../model/AddSupportTicketModel/AddSupportTicketModel.dart';
import '../../../model/TicketDeailModel/TicketDeailModel.dart';
import 'chatScreenRepo/chatScreenRepo.dart';

class ChatController extends GetxController {
  Rxn<String> ticketIdForChat =Rxn();
  var ticketDetailModel = Rxn<TicketDeailModel>();
  Rx<TextEditingController> message = TextEditingController().obs;
  var addSupportTicketModel = Rxn<AddSupportTicketModel>();
  ChatRepo chatRepo =
  Get.put(ChatRepo());
  RxBool loaderStatus = false.obs;
  @override
  void onInit() {
    print("heheh");
   // initData();
    super.onInit();
  }

  initData() {
    getChatDetails();


  }
  Future<void> getChatDetails() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "ticketId":ticketIdForChat.value
    };

    try {
      var response = await chatRepo.getChatDetails(payload: payload).then((value) {
        if (value != null) {
          ticketDetailModel.value = value;

        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getChatDetails $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> sendMessage() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "ticketId":ticketIdForChat.value,
      "message":message.value.text
    };

    try {
      var response = await chatRepo.sendMessage(payload: payload).then((value) {
        if (value != null) {
          addSupportTicketModel.value = value;
          getChatDetails();
          message.value.clear();
        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getChatDetails $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }


}