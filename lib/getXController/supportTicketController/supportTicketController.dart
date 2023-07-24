import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/getXController/supportTicketController/supportTIcketRepo/supportTicketRepo.dart';

import '../../Utility/app_utility.dart';
import '../../model/AddSupportTicketModel/AddSupportTicketModel.dart';
import '../../model/SupportTicketListModel/SupportTicketListModel.dart';
import '../../model/TicketDeailModel/TicketDeailModel.dart';

class SupportTicketController extends GetxController {
  SupportTicketRepo supportTicketRepo =
  Get.put(SupportTicketRepo());
  RxBool loaderStatus = false.obs;
  var supportTicketListModel = Rxn<SupportTicketListModel>();

  var addSupportTicketModel = Rxn<AddSupportTicketModel>();

  Rx<TextEditingController> subject = TextEditingController().obs;

  Rx<TextEditingController> message = TextEditingController().obs;
  clearValue(){
    subject.value.text="";
    message.value.text="";
  }
  @override
  void onReady() {
    initData();
    super.onReady();
  }

  initData() {
     getSupportTicketList();


  }



  Future<void>  addSupportTicket()async{
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {
      "subject":subject.value.text,
      "optionalSubject":"",
      "description":message.value.text,
    };

    try {
      var response = await supportTicketRepo.addSupportTicket(payload: payload).then((value) {
        if (value != null) {
          addSupportTicketModel.value = value;
          AppUtility.showSuccessSnackBar(addSupportTicketModel.value!.message.toString());
          clearValue();
          initData();
        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("addSupportTicket $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void>  closeSupport({required ticketId})async{
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {

      "ticketId":ticketId,
    };

    try {
      var response = await supportTicketRepo.closeTicket(payload: payload).then((value) {
        if (value != null) {
          addSupportTicketModel.value = value;
          AppUtility.showSuccessSnackBar(addSupportTicketModel.value!.message.toString());
          initData();
        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("addSupportTicket $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }

  Future<void> getSupportTicketList() async {
    loaderStatus.value = true;
    update();
    Map<String, dynamic> payload = {};

    try {
      var response = await supportTicketRepo.getSupportTicketList(payload: payload).then((value) {
        if (value != null) {
          supportTicketListModel.value = value;
        } else {
          // directRewardList=[];
        }
      });
      print(response);
    } catch (e) {
      debugPrint("getSupportTicketList $e");
      AppUtility.showErrorSnackBar(e.toString());
    }

    loaderStatus.value = false;
    update();
  }



}