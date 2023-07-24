import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/app_input_container.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:page_transition/page_transition.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/noData.dart';
import '../../../commonWidget/showDialoueBox.dart';
import '../../../getXController/p2pTransferController/p2pTransferController.dart';
import '../../setting/settingTile/addAccount/addAccountScreen.dart';

import '../../setting/settingTile/allRequest/buyRequest/buyRequestScreen.dart';
import '../../setting/settingTile/p2pRequest/p2pRequestScreen.dart';

class P2PTradingScreen extends StatefulWidget {
  const P2PTradingScreen({super.key});

  @override
  State<P2PTradingScreen> createState() => _P2PTradingScreenState();
}

class _P2PTradingScreenState extends State<P2PTradingScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<P2PTransferController>(
      init: P2PTransferController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColor().primaryColor,
            appBar: AppToolbar(
              onPressBackButton: () {
                controller.allRequestStream.value = false;
                controller.getSelfStreamRequestList.value = false;
                controller.getYourStreamRequestList.value = false;
                Navigator.pop(context);
              },
              enableBackArrow: true,
              title: "P2P Trading",
              appColor: Colors.transparent,
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: AddAccount()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor().secondPrimaryColor,
                          ),
                          child: const AppText(
                            text: "Add Account",
                            fontSize: 12,
                          ),
                        ),
                      )),
                      width10,
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: p2pRequest()));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor().secondPrimaryColor,
                          ),
                          child: const AppText(
                            text: "Add Request",
                            fontSize: 12,
                          ),
                        ),
                      )),
                    ],
                  ),
                  height10,
                  height10,
                  SizedBox(
                    height: 30,
                    child: TabBar(
                      controller: _controller,
                      indicatorWeight: 0,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // Creates border
                          color: AppColor().oldThemeColors),
                      tabs: [
                        Tab(
                          icon: AppText(
                            text: "All Request",
                            fontSize: 12,
                          ),
                        ),
                        Tab(
                          icon: AppText(
                            text: "Sell Request",
                            fontSize: 12,
                          ),
                        ),
                        Tab(
                          icon: AppText(
                            text: "Buy Request",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height10,
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        Obx(() => allRequestWidget(controller)),
                        Obx(() => yourRequestWidget(controller)),
                        Obx(() => selfRequestWidget(controller))
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  yourRequestWidget(P2PTransferController controller) {
    return AppPageLoader(
        isLoading: controller.loaderStatus.value,
        enablePullToRefresh: true,
        onRefresh: () {
          controller.getYourRequestList();
          controller.getSelfRequestList();
          controller.getAllRequestList();
        },
        child: controller.buyRequestListModel.value != null &&
                controller.buyRequestListModel.value!.data.isNotEmpty &&
                controller.buyRequestListModel.value!.data[0].list.isNotEmpty
            ? ListView.builder(
                itemCount:
                    controller.buyRequestListModel.value!.data[0].list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var dataItem =
                      controller.buyRequestListModel.value!.data[0].list;
                  String status = "";

                  Color statusColor = Colors.white70;
                  if (dataItem != null) {
                    if (dataItem[index].status == 0) {
                      status = "Pending";
                      statusColor = AppColor().orange;
                    } else if (dataItem[index].status == 1) {
                      status = "Success";
                      statusColor = AppColor().green;
                    } else if (dataItem[index].status == 2) {
                      status = "Rejected";
                      statusColor = AppColor().red;
                    } else if (dataItem[index].status == 3) {
                      status = "Partially Completed";
                      statusColor = AppColor().highLightColor;
                    }
                  }

                  return dataItem.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor().secondPrimaryColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          colors: [
                                            AppColor().purple,
                                            AppColor().themeColors,
                                            AppColor().themeColors,
                                          ]),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppText(
                                        text: "Amount",
                                        fontSize: 12,
                                      ),
                                      AppText(
                                        text: dataItem != null
                                            ? "${dataItem[index].amount.toStringAsFixed(2)} GDX"
                                            : "N/A",
                                        fontSize: 12,
                                      ),
                                    ],
                                  )),
                              height10,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "Price (USD)",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        const AppText(
                                          text: "USD",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        const AppText(
                                          text: "INR",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        const AppText(
                                          text: "User Id",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        const AppText(
                                          text: "User Name",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        const AppText(
                                          text: "Status",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        dataItem[index].transactionId != null
                                            ? AppText(
                                                text: "Transaction ID",
                                                fontSize: 12,
                                              )
                                            : SizedBox(),
                                        dataItem[index].transactionId != null
                                            ? height10
                                            : SizedBox(),
                                        dataItem[index].otp != null
                                            ? AppText(
                                                text: "OTP",
                                                fontSize: 12,
                                              )
                                            : SizedBox(),
                                        dataItem[index].otp != null
                                            ? height10
                                            : SizedBox(),
                                        // dataItem[index].otpTime != null
                                        //     ? AppText(
                                        //         text: "OTP Time",
                                        //         fontSize: 12,
                                        //       )
                                        //     : SizedBox(),
                                        // dataItem[index].otp != null
                                        //     ? height10
                                        //     : SizedBox(),
                                        const AppText(
                                          text: "Date Time",
                                          fontSize: 12,
                                        ),
                                        height10,
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AppText(
                                          text: dataItem != null
                                              ? "${dataItem[index].price}"
                                              : "N/A",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        AppText(
                                          text: dataItem != null
                                              ? "${dataItem[index].amount * dataItem[index].price}"
                                              : "N/A",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        AppText(
                                          text: dataItem != null
                                              ? "${(dataItem[index].amount * dataItem[index].price) * 90}"
                                              : "N/A",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        AppText(
                                          text: dataItem != null
                                              ? dataItem[index].userId
                                              : "N/A",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        AppText(
                                          text: dataItem != null
                                              ? dataItem[index].userName
                                              : "N/A",
                                          fontSize: 12,
                                        ),
                                        height10,
                                        AppText(
                                          text:
                                              dataItem != null ? status : "N/A",
                                          fontSize: 12,
                                          textColor: dataItem != null
                                              ? statusColor
                                              : null,
                                        ),
                                        height10,
                                        dataItem[index].transactionId != null
                                            ? Row(
                                                children: [
                                                  AppText(
                                                    text: dataItem != null
                                                        ? dataItem[index]
                                                            .transactionId
                                                            .toString()
                                                        : "N/A",
                                                    fontSize: 12,
                                                    textColor:
                                                        AppColor().orange,
                                                  ),
                                                  width10,
                                                  InkWell(
                                                    onTap: () {
                                                      ShowBox().copyClipBoard(
                                                          text: dataItem[index]
                                                              .transactionId
                                                              .toString());
                                                    },
                                                    child: Icon(
                                                      Icons.copy,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              )
                                            : SizedBox(),
                                        dataItem[index].transactionId != null
                                            ? height10
                                            : SizedBox(),
                                        dataItem[index].otp != null
                                            ? AppText(
                                                text: dataItem != null
                                                    ? dataItem[index]
                                                        .otp
                                                        .toString()
                                                    : "N/A",
                                                fontSize: 12,
                                                textColor:
                                                    AppColor().highLightColor,
                                              )
                                            : SizedBox(),
                                        dataItem[index].otp != null
                                            ? height10
                                            : SizedBox(),
                                        // dataItem[index].otpTime != null
                                        //     ? AppText(
                                        //         text: dataItem != null
                                        //             ? AppUtility.parseDate(
                                        //                 dataItem[index]
                                        //                     .otpTime
                                        //                     .toString())
                                        //             : "N/A",
                                        //         fontSize: 12,
                                        //       )
                                        //     : SizedBox(),
                                        // dataItem[index].otpTime != null
                                        //     ? height10
                                        //     : SizedBox(),
                                        AppText(
                                          text: dataItem != null
                                              ? AppUtility.parseDate(
                                                  dataItem[index].createdAt)
                                              : "N/A",
                                          fontSize: 12,
                                        ),
                                        height10
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              height10,
                              status != "Rejected"
                                  ? dataItem[index].otpStatus == 0
                                      ? InkWell(
                                          onTap: () async {
                                            controller.sellRequestId.value =
                                                dataItem[index].id;
                                            await ShowBox().showBox(
                                                showCancelButton: true,
                                                text: "",
                                                onButtonClick: () {
                                                  controller
                                                      .cancelSellRequest();
                                                  Get.back();
                                                },
                                                titleContent:
                                                    "Are you sure want to cancel this request?",
                                                buttonText: "OK");
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          const FractionalOffset(
                                                              0.0, 0.0),
                                                      end: const FractionalOffset(1.0, 0.0),
                                                      colors: [
                                                        AppColor().red,
                                                        Colors.red
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              child: AppText(
                                                text: "Cancel",
                                                fontSize: 12,
                                              )),
                                        )
                                      : status != "Success"
                                          ? InkWell(
                                              onTap: () {
                                                setState(() {
                                                  controller
                                                          .sellRequestId.value =
                                                      dataItem[index].id;
                                                });
                                                ShowBox().showBox(
                                                    showCancelButton: true,
                                                    text: "",
                                                    onButtonClick: () {
                                                      controller.approveOtp();
                                                      Get.back();
                                                    },
                                                    titleContent:
                                                        "Are you sure want to approve?",
                                                    buttonText: "Yes");
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin:
                                                              const FractionalOffset(
                                                                  0.0, 0.0),
                                                          end: const FractionalOffset(1.0, 0.0),
                                                          colors: [
                                                            AppColor().orange,
                                                            Colors.green
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      )),
                                                  child: AppText(
                                                    text: "Approve",
                                                    fontSize: 12,
                                                  )),
                                            )
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          const FractionalOffset(
                                                              0.0, 0.0),
                                                      end:
                                                          const FractionalOffset(
                                                              1.0, 0.0),
                                                      colors: [
                                                        AppColor().green,
                                                        AppColor().green,
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  )),
                                              child: AppText(
                                                text: "Approved",
                                                fontSize: 12,
                                              ))
                                  : SizedBox()
                            ],
                          ))
                      : const NoData();
                },
              )
            : NoData());
  }

  selfRequestWidget(P2PTransferController controller) {
    return AppPageLoader(
        isLoading: controller.loaderStatus.value,
        enablePullToRefresh: true,
        onRefresh: () {
          controller.getYourRequestList();
          controller.getSelfRequestList();
          controller.getAllRequestList();
        },
        child: controller.selfRequestListModel.value != null &&
                controller.selfRequestListModel.value!.data.isNotEmpty &&
                controller.selfRequestListModel.value!.data[0].list.isNotEmpty
            ? ListView.builder(
                itemCount:
                    controller.selfRequestListModel.value!.data[0].list.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var dataItem =
                      controller.selfRequestListModel.value!.data[0].list;
                  String status = "";
                  Color statusColor = Colors.white70;
                  if (dataItem != null) {
                    if (dataItem[index].status == 0) {
                      status = "Pending";
                      statusColor = AppColor().orange;
                    } else if (dataItem[index].status == 1) {
                      status = "Success";
                      statusColor = AppColor().green;
                    } else if (dataItem[index].status == 2) {
                      status = "Rejected";
                      statusColor = AppColor().red;
                    } else if (dataItem[index].status == 3) {
                      status = "Partially Completed";
                      statusColor = AppColor().highLightColor;
                    }
                  }

                  return dataItem.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColor().secondPrimaryColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          colors: [
                                            AppColor().purple,
                                            AppColor().themeColors,
                                            AppColor().themeColors,
                                          ]),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AppText(
                                        text: "Amount",
                                        fontSize: 12,
                                      ),
                                      AppText(
                                        text: dataItem != null
                                            ? "${dataItem[index].amount.toStringAsFixed(2)} GDX"
                                            : "N/A",
                                        fontSize: 12,
                                      ),
                                    ],
                                  )),
                              height10,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Price (USD)",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        width10,
                                        Text(
                                          dataItem != null
                                              ? "${dataItem[index].price}"
                                              : "N/A",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    height10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: "USD",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Text(
                                          dataItem != null
                                              ? "${dataItem[index].amount * dataItem[index].price}"
                                              : "N/A",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    height10,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "INR",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Expanded(
                                          child: Text(textAlign: TextAlign.end,
                                            dataItem != null
                                                ? "${(dataItem[index].amount * dataItem[index].price) * 90}"
                                                : "N/A",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height10,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "User Id",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Expanded(
                                          child: Text(    textAlign: TextAlign.end,
                                            dataItem != null
                                                ? dataItem[index].userId
                                                : "N/A",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),

                                      ],
                                    ),
                                    height10,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: "User Name",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Expanded(
                                          child: Text(
                                            textAlign: TextAlign.end,
                                            dataItem != null
                                                ? dataItem[index].userName
                                                : "N/A",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height10,
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "Status",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Expanded(
                                          child:  Text(textAlign: TextAlign.end,
                                            dataItem != null ? status : "N/A",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: dataItem != null
                                                  ? statusColor
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    dataItem[index].upi != null
                                        ? height10
                                        : SizedBox(),
                                    dataItem[index].upi != null
                                        ? Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      const AppText(
                                          text: "Upi Id",
                                          fontSize: 12,
                                        )
                                            ,
                                        width10,
                                 Row(
                                          children: [
                                            Text(
                                              dataItem != null
                                                  ? dataItem[index]
                                                  .upi
                                                  .toUpperCase()
                                                  : "N/A",textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                            width10,
                                            InkWell(
                                              onTap: () {
                                                ShowBox().copyClipBoard(
                                                    text: dataItem[
                                                    index]
                                                        .upi
                                                        .toString());
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ): SizedBox(),

                                    dataItem[index].accountNo != null
                                        ? height10
                                        : SizedBox(),
                                    dataItem[index].accountNo != null
                                        ? Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AppText(
                                          text: "Account No",
                                          fontSize: 12,
                                        )
                                        ,
                                        width10,
                                        Row(
                                          children: [
                                            AppText(
                                              text: dataItem != null
                                                  ? dataItem[index]
                                                  .accountNo
                                                  : "N/A",
                                              fontSize: 12,
                                            ),
                                            width10,
                                            InkWell(
                                              onTap: () {
                                                ShowBox().copyClipBoard(
                                                    text: dataItem[
                                                    index]
                                                        .accountNo
                                                        .toString());
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ): SizedBox(),


                                    dataItem[index].accountHolderName !=
                                        null
                                        ? height10
                                        : SizedBox(),
                                    dataItem[index].accountHolderName != null
                                        ? Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AppText(
                                          text: "Account Holder Name",
                                          fontSize: 12,
                                        )
                                        ,
                                        width10,
                                        Row(
                                          children: [
                                            AppText(
                                              text: dataItem != null
                                                  ? dataItem[index]
                                                  .accountHolderName
                                                  : "N/A",
                                              fontSize: 12,
                                            ),
                                            width10,
                                            InkWell(
                                              onTap: () {
                                                ShowBox().copyClipBoard(
                                                    text: dataItem[
                                                    index]
                                                        .accountHolderName
                                                        .toString());
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ): SizedBox(),
                                    dataItem[index].ifscCode != null
                                        ? height10
                                        : SizedBox(),
                                    dataItem[index].ifscCode != null
                                        ? Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AppText(
                                          text: "Ifsc Code",
                                          fontSize: 12,
                                        )
                                        ,
                                        width10,
                                        Row(
                                          children: [
                                            AppText(
                                              text: dataItem != null
                                                  ? dataItem[index]
                                                  .ifscCode
                                                  : "N/A",
                                              fontSize: 12,
                                            ),
                                            width10,
                                            InkWell(
                                              onTap: () {
                                                ShowBox().copyClipBoard(
                                                    text: dataItem[
                                                    index]
                                                        .ifscCode
                                                        .toString());
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ): SizedBox(),
                                    height10,
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const AppText(
                                          text: "Mobile Number",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Row(
                                          children: [
                                            Text(
                                              dataItem != null
                                                  ? dataItem[index].mobile
                                                  : "N/A",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white
                                              ),
                                            ),
                                            width10,
                                            InkWell(
                                              onTap: () {
                                                ShowBox().copyClipBoard(
                                                    text: dataItem[index]
                                                        .mobile
                                                        .toString());
                                              },
                                              child: Icon(
                                                Icons.copy,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    height10,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        const AppText(
                                          text: "Date Time",
                                          fontSize: 12,
                                        ),
                                        width10,
                                        Expanded(
                                          child:  AppText(textAlign: TextAlign.end,
                                            text: dataItem != null
                                                ? AppUtility.parseDate(
                                                dataItem[index].createdAt)
                                                : "N/A",
                                            fontSize: 12,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              height10,
                              status != "Rejected"
                                  ? dataItem[index].otpStatus == 0
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    controller.buyRequestId
                                                            .value =
                                                        dataItem[index].id;
                                                  });
                                                  await ShowBox().showBox(
                                                      showCancelButton: true,
                                                      text: "",
                                                      onButtonClick: () {
                                                        controller
                                                            .cancelBuyRequest();
                                                        Get.back();
                                                      },
                                                      titleContent:
                                                          "Are you sure want to cancel this request?",
                                                      buttonText: "OK");
                                                },
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin:
                                                                const FractionalOffset(
                                                                    0.0, 0.0),
                                                            end:
                                                                const FractionalOffset(
                                                                    1.0, 0.0),
                                                            colors: [
                                                              AppColor().red,
                                                              AppColor().red,
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        )),
                                                    child: AppText(
                                                      text: "Cancel",
                                                      fontSize: 12,
                                                    )),
                                              ),
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    controller.buyRequestId
                                                            .value =
                                                        dataItem[index].id;
                                                  });
                                                  await showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              AppColor()
                                                                  .secondPrimaryColor,
                                                          title: Text(
                                                            "Verify",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          content: SizedBox(
                                                            height: 180,
                                                            child: Column(
                                                              children: [
                                                                OtpTextField(
                                                                    textStyle: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    numberOfFields:
                                                                        4,
                                                                    borderColor:
                                                                        AppColor()
                                                                            .green,
                                                                    //set to true to show as box or false to show as dash
                                                                    showFieldAsBox:
                                                                        true,
                                                                    //runs when a code is typed in
                                                                    onCodeChanged:
                                                                        (String
                                                                            code) {
                                                                      /* controller.otp.value=code;*/
                                                                      //handle validation or checks here
                                                                    },
                                                                    //runs when every textfield is filled
                                                                    onSubmit:
                                                                        (String
                                                                            verificationCode) {
                                                                      controller
                                                                          .otp
                                                                          .value
                                                                          .text = verificationCode;
                                                                    }),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                AppInputContainer(
                                                                  filledColor:
                                                                      Colors
                                                                          .white,
                                                                  controller:
                                                                      controller
                                                                          .transactionId
                                                                          .value,
                                                                  placeholder:
                                                                      "Enter Transaction Id",
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                      controller
                                                                          .sendOtpSelfRequest();
                                                                    },
                                                                    child: Text(
                                                                        "Resend Otp")),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Cancel")),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                        primary:
                                                                            AppColor()
                                                                                .primaryColor),
                                                                onPressed: () {
                                                                  if (controller
                                                                          .otp
                                                                          .value
                                                                          .text
                                                                          .isNotEmpty &&
                                                                      controller
                                                                          .transactionId
                                                                          .value
                                                                          .text
                                                                          .isNotEmpty) {
                                                                    controller
                                                                        .verifySelfRequestOtp();
                                                                    Get.back();
                                                                  } else {
                                                                    AppUtility
                                                                        .showErrorSnackBar(
                                                                            "Fill All Fields");
                                                                  }

                                                                  /*.then((value) {
                                                      print("valueValue $value");
                                                      if(value=="false"){
                                                        Navigator.pop(context);
                                                      }

                                                    });*/
                                                                },
                                                                child: Text(
                                                                    "Verify"))
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin:
                                                                const FractionalOffset(
                                                                    0.0, 0.0),
                                                            end: const FractionalOffset(1.0, 0.0),
                                                            colors: [
                                                              AppColor().orange,
                                                              Colors.green
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        )),
                                                    child: AppText(
                                                      text: "Verify",
                                                      fontSize: 12,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox()
                                  : SizedBox()
                            ],
                          ))
                      : const NoData();
                },
              )
            : NoData());
  }

  List wallet = [
    {"name": "All", "id": "0"},
    {"name": "All Team", "id": "1"},
    {"name": "Total Left Team", "id": "2"},
    {"name": "Total Right Team", "id": "3"},
  ];

  allRequestWidget(P2PTransferController controller) {
    return AppPageLoader(
        isLoading: controller.loaderStatus.value,
        enablePullToRefresh: true,
        onRefresh: () {
          controller.getYourRequestList();
          controller.getSelfRequestList();
          controller.getAllRequestList();
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              padding: EdgeInsets.only(left: 8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: AppColor().secondPrimaryColor, width: 0.5),
                color: AppColor().primaryColor,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  dropdownStyleData: DropdownStyleData(
                      decoration:
                          BoxDecoration(color: AppColor().secondPrimaryColor)),
                  style: TextStyle(color: Colors.white),
                  isExpanded: true,
                  hint: const Text("Select Team",
                      style: TextStyle(color: Color(0xffC8C7CE), fontSize: 12)),
                  items: wallet.map((item) {
                    return DropdownMenuItem(
                      value: item["name"],
                      child: Text(
                        item["name"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var aaa = wallet.where((element) {
                      print("asd  $element");
                      if (element["name"] == value) {
                        controller.selectedWalletId.value =
                            element["id"].toString();
                      }
                      return true;
                    });

                    debugPrint(aaa.toString());
                    setState(() {
                      controller.selectedWallet.value = value! as String?;
                    });
                    controller.getAllRequestList();
                  },
                  value: controller.selectedWallet.value,
                ),
              ),
            ),
            Expanded(
              child: controller.p2PAllRequestModel.value != null &&
                      controller.p2PAllRequestModel.value!.data.list.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          controller.p2PAllRequestModel.value!.data.list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var dataItem =
                            controller.p2PAllRequestModel.value!.data.list;
                        String status = "";
                        Color statusColor = Colors.white70;
                        if (dataItem != null) {
                          if (dataItem[index].status == 0) {
                            status = "Pending";
                            statusColor = AppColor().orange;
                          } else if (dataItem[index].status == 1) {
                            status = "Success";
                            statusColor = AppColor().green;
                          } else if (dataItem[index].status == 2) {
                            status = "Rejected";
                            statusColor = AppColor().red;
                          } else if (dataItem[index].status == 3) {
                            status = "Partially Completed";
                            statusColor = AppColor().highLightColor;
                          }
                        }

                        return dataItem.isNotEmpty
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor().secondPrimaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: const FractionalOffset(
                                                    0.0, 0.0),
                                                end: const FractionalOffset(
                                                    1.0, 0.0),
                                                colors: [
                                                  AppColor().purple,
                                                  AppColor().themeColors,
                                                  AppColor().themeColors,
                                                ]),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const AppText(
                                              text: "Amount",
                                              fontSize: 12,
                                            ),
                                            AppText(
                                              text: dataItem != null
                                                  ? "${dataItem[index].totalamount.toStringAsFixed(2)} GDX"
                                                  : "N/A",
                                              fontSize: 12,
                                            ),
                                          ],
                                        )),
                                    height10,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const AppText(
                                                text: "Balance Amount",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text:
                                                    "Price (${dataItem[index].userRateType.toUpperCase()})",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? dataItem[index]
                                                        .userRateType
                                                        .toUpperCase()
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? "INR"
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              const AppText(
                                                text: "Username",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              const AppText(
                                                text: "Status",
                                                fontSize: 12,
                                              ),
                                              height10,
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              AppText(
                                                text: dataItem != null
                                                    ? "${dataItem[index].balanceamount.toStringAsFixed(2)} GDX"
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? dataItem[index]
                                                        .userRate
                                                        .toString()
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? (dataItem[index]
                                                                .balanceamount *
                                                            dataItem[index]
                                                                .userRate)
                                                        .toStringAsFixed(2)
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? ((dataItem[index]
                                                                    .balanceamount *
                                                                dataItem[index]
                                                                    .userRate) *
                                                            90)
                                                        .toStringAsFixed(2)
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? dataItem[index].userId
                                                    : "N/A",
                                                fontSize: 12,
                                              ),
                                              height10,
                                              AppText(
                                                text: dataItem != null
                                                    ? status
                                                    : "N/A",
                                                fontSize: 12,
                                                textColor: dataItem != null
                                                    ? statusColor
                                                    : null,
                                              ),
                                              height10,
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    height10,
                                    dataItem[index].userId !=
                                            controller
                                                .homePageController
                                                .allUserProfileData
                                                .value
                                                ?.data
                                                .username
                                        ? InkWell(
                                            onTap: () {
                                              controller.requestId.value =
                                                  dataItem[index].id;
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: BuyRequestScreen(
                                                        rateType:
                                                            dataItem[index]
                                                                .userRateType
                                                                .toUpperCase(),
                                                        userRate:
                                                            dataItem[index]
                                                                .userRate
                                                                .toString(),
                                                        amount: dataItem[index]
                                                            .balanceamount
                                                            .toString(),
                                                      )));
                                              //controller.deleteRequest(id: dataItem![index].id);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            const FractionalOffset(
                                                                0.0, 0.0),
                                                        end:
                                                            const FractionalOffset(
                                                                1.0, 0.0),
                                                        colors: [
                                                          AppColor().green,
                                                          AppColor().green,
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    )),
                                                child: AppText(
                                                  text: "Buy",
                                                  fontSize: 12,
                                                )),
                                          )
                                        : InkWell(
                                            onTap: () async {
                                              await ShowBox().showBox(
                                                  showCancelButton: true,
                                                  text: "",
                                                  onButtonClick: () {
                                                    controller
                                                        .deleteYourRequest(
                                                            requestId:
                                                                dataItem[index]
                                                                    .id);
                                                    Get.back();
                                                  },
                                                  titleContent:
                                                      "Are you sure want to cancel this request?",
                                                  buttonText: "OK");
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin:
                                                            const FractionalOffset(
                                                                0.0, 0.0),
                                                        end:
                                                            const FractionalOffset(
                                                                1.0, 0.0),
                                                        colors: [
                                                          AppColor().red,
                                                          AppColor().red,
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    )),
                                                child: AppText(
                                                  text: "Cancel Request",
                                                  fontSize: 12,
                                                )),
                                          ),
                                  ],
                                ))
                            : const NoData();
                      },
                    )
                  : NoData(),
            )
          ],
        ));
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
