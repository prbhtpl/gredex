import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/model/SupportTicketListModel/SupportTicketListModel.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../commonWidget/showDialoueBox.dart';
import '../../../../getXController/supportTicketController/chatScreenController/chatScreenController.dart';
import '../../../../getXController/supportTicketController/supportTicketController.dart';
import 'chat/chatSystem.dart';

class SupportTicket extends StatefulWidget {
  SupportTicket({Key? key}) : super(key: key);

  @override
  State<SupportTicket> createState() => _SupportTicketState();
}

class _SupportTicketState extends State<SupportTicket> {
  var supportTicket = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportTicketController>(
      init: SupportTicketController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Support Ticket",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: SingleChildScrollView(
            child: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    formWidget(controller),
                    Obx(() => teamWidget(
                        controller.supportTicketListModel.value, controller)),
                    height10,
                    height10,
                    height10,
                    height10,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  formWidget(SupportTicketController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

      // height: 40,
      decoration: BoxDecoration(
        color: AppColor().secondPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: supportTicket,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppText(
              textAlign: TextAlign.start,
              text: "Subject",
              fontSize: 18,
            ),
            height10,
            AppInputContainer(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Subject cannot be empty";
                }
                return null;
              },
              controller: controller.subject.value,
              onTextChange: (val) {},

              inputType: TextInputType.text,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: " ",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            AppText(
              textAlign: TextAlign.start,
              text: "Message",
              fontSize: 18,
            ),
            height10,
            AppInputContainer(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Message cannot be empty";
                }
                return null;
              },
              controller: controller.message.value,
              onTextChange: (val) {},

              inputType: TextInputType.text,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: " ",
              maxLines: 4,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            ElevatedButton(
                onPressed: () {
                  controller.addSupportTicket();
                },
                child: Text("Submit")),
          ],
        ),
      ),
    );
  }

  Widget teamWidget(
      SupportTicketListModel? data, SupportTicketController controller) {
    return ListView.builder(
      itemCount: data != null ? data.data[0].list.length : 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var dataItem = data?.data[0].list[index];

        return data!.data.isNotEmpty
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor().secondPrimaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Subject:",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.yellow,
                          ),
                          width10,
                          Expanded(
                            child: Text(
                              data != null ? "${dataItem?.subject}" : "N/A",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    height10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Message:",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.yellow,
                          ),
                          width10,
                          Expanded(
                            child: Text(
                              data != null ? "${dataItem?.description}" : "N/A",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    height10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Status:",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.yellow,
                          ),
                          width10,
                          Expanded(
                            child: Text(
                              data != null
                                  ? dataItem?.status == 0
                                      ? "Active"
                                      : "Inactive"
                                  : "N/A",
                              style: TextStyle(
                                fontSize: 15,
                                color: data != null
                                    ? dataItem?.status == 0
                                        ? AppColor().green
                                        : AppColor().red
                                    : null,
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () async {
                                setState((){
                                  ChatController chatController=Get.put(ChatController());
                                  chatController.ticketIdForChat.value=dataItem!.id;
                                });
                                print("dataItem!.id ${   Get.find<ChatController>().ticketIdForChat.value}");


                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(seconds: 1),
                                        type: PageTransitionType.fade,
                                        child:  ChatScreen( )));
                              },
                              child: const Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 20,
                              )),
                          width10,
                          InkWell(
                            onTap: () async {
                              await ShowBox().showBox(
                                  showCancelButton: true,
                                  text: "",
                                  onButtonClick: () {
                                    controller.closeSupport(
                                        ticketId: dataItem?.id);
                                    Get.back();
                                  },
                                  titleContent:
                                      "Are you sure want to delete this request?",
                                  buttonText: "OK");
                            },
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    height10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "Date Time:",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.yellow,
                              ),
                              height10,
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppText(
                                text: data != null
                                    ? AppUtility.parseDate(dataItem!.createdAt)
                                    : "N/A",
                                fontSize: 15,
                              ),
                              height10,
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ))
            : const NoData();
      },
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
