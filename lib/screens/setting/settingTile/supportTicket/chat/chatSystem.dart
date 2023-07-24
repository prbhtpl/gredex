import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/app_input_container.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/getXController/supportTicketController/supportTicketController.dart';

import '../../../../../Utility/app_toolbar.dart';
import '../../../../../commonWidget/appColors.dart';
import '../../../../../getXController/supportTicketController/chatScreenController/chatScreenController.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    chatController.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (controller) {
        return Scaffold(floatingActionButton:
        Container(  padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(10),
              color:AppColor().secondPrimaryColor),
          child: Row(
            children: [
              Expanded(
                child: AppInputContainer(

                  controller: controller.message.value,
                  onTextChange: (val) {},

                  inputType: TextInputType.text,
                  textBackgroundColor: Colors.white.withOpacity(0.3),

                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  placeholder: "Type Message Here!",
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  //controller: controller.suggestionController,
                ),
              ),IconButton(icon: Icon(Icons.send,color: Colors.green,),onPressed: (){
                if(controller.message.value.text.isNotEmpty){ controller.sendMessage();}else{
                  AppUtility.showErrorSnackBar("Message Cannot be empty!");

                }

              },)
            ],
          ),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          appBar: AppToolbar(
            onPressBackButton: () {
              controller.ticketIdForChat.value = null;
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Chat",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Column(
              children: [
                Expanded(
                child:Obx(() => controller.ticketDetailModel.value != null
                    ? controller.ticketDetailModel.value!.data[0].ticketReplies
                            .isNotEmpty
                        ?  ListView.builder(
                              itemCount: controller.ticketDetailModel.value
                                  ?.data[0].ticketReplies.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var replies = controller.ticketDetailModel.value
                                    ?.data[0].ticketReplies[index];
                                print("reply${replies?.description}");
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          replies?.replyFrom == "User"
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        replies?.replyFrom == "User"
                                            ? Expanded(child: SizedBox.shrink())
                                            : SizedBox(),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    replies?.replyFrom == "User"
                                                        ? Colors.white10
                                                        : Colors.blue),
                                            child: Column(
                                              crossAxisAlignment:
                                                  replies?.replyFrom == "User"
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                          .start,
                                              children: [
                                                Text(
                                                  replies!.description,
                                                  textAlign:
                                                      replies.replyFrom ==
                                                              "User"
                                                          ? TextAlign.end
                                                          : TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  AppUtility.parseDate(
                                                      replies.createdAt),
                                                  textAlign:
                                                      replies.replyFrom ==
                                                              "User"
                                                          ? TextAlign.end
                                                          : TextAlign.start,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        replies.replyFrom == "Admin"
                                            ? Expanded(child: SizedBox.shrink())
                                            : SizedBox(),
                                      ],
                                    ),
                                    height10
                                  ],
                                );
                              },

                          )
                        : NoData()
                    : NoData())),

                height10,
                height10,
              ],
            ),
          ),
        );
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
