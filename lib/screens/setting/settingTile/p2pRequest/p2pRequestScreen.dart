import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/commonWidget/appColors.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/getXController/p2pTransferRequestController/p2pRequestController.dart';
import 'package:gredex/model/P2PRequestListModel/P2PRequestListModel.dart';
import 'package:gredex/model/qrCodeModel/qrCodeModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../Utility/app_utility.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../commonWidget/customButton.dart';
import '../../../../commonWidget/noData.dart';
import '../../../../commonWidget/showDialoueBox.dart';
import '../../../../model/profileModel/profileModel.dart';

class p2pRequest extends StatefulWidget {
  p2pRequest({super.key});

  @override
  State<p2pRequest> createState() => _p2pRequestState();
}

class _p2pRequestState extends State<p2pRequest> {
  bool visibleHistory = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<P2PRequestController>(
      init: P2PRequestController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "P2P Request",
            appColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Column(
                  children: [
                    Obx(() =>
                        topWidget(controller.homePageController.qrModel.value)),
                    height10,
                    formWidget(controller, context),
                    height10,
                    CustomButton(
                      buttonText: "Send Request",
                      onClickButton: () {
                        if (controller.selectedWalletId.value != "0") {
                          if (p2pTransferRequest.currentState!.validate()) {
                            controller.p2pSelBuy();
                          } else {
                            AppUtility.showErrorSnackBar("Enter Amount First");
                          }
                        } else {
                          AppUtility.showErrorSnackBar(
                              "Select Account Type First");
                        }
                      },
                    ),
                    height10,
                    AppText(
                      onTap: () {
                        setState(() {
                          visibleHistory = !visibleHistory;
                        });
                      },
                      text: visibleHistory ? "Hide History" : " View History",
                      textColor: AppColor().oldThemeColors,
                      underline: true,
                      fontSize: 15,
                    ),
                    height10,
                    Visibility(
                        visible: visibleHistory,
                        child: teamWidget(
                            controller.p2PTransferRequestListModel.value,
                            controller)),
                SizedBox(height: Get.width/3,)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget teamWidget(
      P2PRequestListModel? data, P2PRequestController controller) {
    return data != null && data.data.isNotEmpty
        ? ListView.builder(
            itemCount: data != null ? data.data[0].list.length : 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var dataItem = data.data[0].list;
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

              return data.data.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
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
                                      begin: const FractionalOffset(0.0, 0.0),
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
                                    fontSize: 15,
                                  ),
                                  AppText(
                                    text: dataItem != null
                                        ? "\$${dataItem[index].balanceusdamount.toStringAsFixed(2)}"
                                        : "N/A",
                                    fontSize: 15,
                                  ),
                                ],
                              )),
                          height10,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    const AppText(
                                      text: "Balance Amount",
                                      fontSize: 15,
                                    ), height10,
                                    AppText(
                                      text: "Price (${dataItem[index].userRateType.toUpperCase()})",
                                      fontSize: 15,
                                    ),  height10,
                                    AppText(
                                      text: dataItem != null
                                          ? dataItem[index]
                                          .userRateType
                                          .toUpperCase()
                                          : "N/A",
                                      fontSize: 15,
                                    ),
                                    height10,
                                    const AppText(
                                      text: "Username",
                                      fontSize: 15,
                                    ),


                                    height10,
                                    const AppText(
                                      text: "Status",
                                      fontSize: 15,
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
                                      fontSize: 15,
                                    ),
                                    height10,
                                    AppText(
                                      text: dataItem != null
                                          ? dataItem[index]
                                          .userRate
                                          .toString()
                                          : "N/A",
                                      fontSize: 15,
                                    ),   height10,
                                    AppText(
                                      text: dataItem != null
                                          ? (dataItem[index].balanceamount *
                                          dataItem[index].userRate)
                                          .toStringAsFixed(2)
                                          : "N/A",
                                      fontSize: 15,
                                    ),
                                    height10,
                                    AppText(
                                      text: dataItem != null
                                          ? dataItem[index].userId
                                          : "N/A",
                                      fontSize: 15,
                                    ),


                                    height10,
                                    AppText(
                                      text:
                                      dataItem != null ? status : "N/A",
                                      fontSize: 15,
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
                          status!="Rejected" && status!="Success"? InkWell(
                            onTap: () async {
                              await ShowBox().showBox(
                                  showCancelButton: true,
                                  text: "",
                                  onButtonClick: () {
                                    controller.deleteRequest(
                                        id: dataItem[index].id);
                                    Get.back();
                                  },
                                  titleContent:
                                      "Are you sure want to delete this request?",
                                  buttonText: "OK");
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: const FractionalOffset(0.0, 0.0),
                                        end: const FractionalOffset(1.0, 0.0),
                                        colors: [
                                          AppColor().red,
                                          AppColor().red,
                                        ]),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    )),
                                child: AppText(
                                  text: "Cancel Request",
                                  fontSize: 15,
                                )),
                          ):SizedBox(),
                        ],
                      ))
                  : const NoData();
            },
          )
        : NoData();
  }

  var p2pTransferRequest = GlobalKey<FormState>();
  List currencyType = [
    {"name": "USD", "id": "1"},
    /*{"name": "INR", "id": "2"},*/
  ];
  List accountType = [
    {"name": "upi", "id": "1"},
    {"name": "bank", "id": "2"},
    {"name": "trc20", "id": "3"},
  ];

  formWidget(P2PRequestController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

      // height: 40,
      decoration: BoxDecoration(
        color: AppColor().secondPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: p2pTransferRequest,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppText(
            //   text: "Choose Account Type",
            //   fontSize: 15,
            //   fontWeight: FontWeight.w600,
            // ),
            // height10,
            // Container(
            //   // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            //   margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            //
            //   // height: 40,
            //   decoration: BoxDecoration(
            //     color: AppColor().primaryColor,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton2(
            //       dropdownStyleData: DropdownStyleData(
            //           decoration: BoxDecoration(
            //               color: AppColor().primaryColor)),
            //       style: TextStyle(color: Colors.white),
            //       isExpanded: true,
            //       hint: const Text("Select Account Type",
            //           style: TextStyle(
            //               color: Color(0xffC8C7CE), fontSize: 15)),
            //       items: accountType.map((item) {
            //         return DropdownMenuItem(
            //           value: item["name"],
            //           child: Text(
            //             item["name"].toString().toUpperCase(),
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         );
            //       }).toList(),
            //       onChanged: (value) {
            //         var aaa = accountType.where((element) {
            //           print("asd  $element");
            //           if (element["name"] == value) {
            //             controller.selectedAccountId.value =
            //                 element["id"].toString();
            //           }
            //           return true;
            //         });
            //
            //         debugPrint(aaa.toString());
            //         setState(() {
            //           controller.selectedAccountType.value =
            //           value! as String?;
            //         });
            //       },
            //       value: controller.selectedAccountType.value,
            //     ),
            //   ),
            // ),
            height10,
            AppText(
              text: "Amount",
              fontSize: 18,
            ), height10,
            AppInputContainer(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Amount cannot be empty";
                }
                return null;
              },
              controller: controller.amount.value,
              onTextChange: (val) {
                /*if (val.isNotEmpty) {
                  controller.dollarAmount.value = int.parse(val);

                  controller.convertedAmount.value.text =
                  controller.selectedWalletId == "1"
                      ? (double.parse(val) *
                      double.parse(controller.homePageController
                          .gdxLiveRateModel.value!.data.rate
                          .toStringAsFixed(2)))
                      .toStringAsFixed(2)
                      : double.parse(val).toStringAsFixed(2);
                  controller.gdxAmount.value =
                  controller.selectedWalletId == "1"
                      ? double.parse(
                      controller.convertedAmount.value.text.toString())
                      : double.parse(controller.convertedAmount.value.text);
                } else {
                  controller.convertedAmount.value.text = "";
                }*/
              },

              inputType: TextInputType.number,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "Enter Amount",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),


           /* height10,
            AppText(
              text: "Account Type",
              fontSize: 18,
            ),
            height10,
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
                child: DropdownButton2(dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(
                    color: AppColor().secondPrimaryColor
                )),style:  TextStyle(color: Colors.white ),
                  isExpanded: true,
                  hint: const Text("Select Wallet",
                      style: TextStyle(color: Color(0xffC8C7CE), fontSize: 15)),
                  items: currencyType.map((item) {
                    return DropdownMenuItem(
                      value: item["name"],
                      child: Text(
                        item["name"].toString(),style:  TextStyle(color: Colors.white ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var aaa = currencyType.where((element) {
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
                  },
                  value: controller.selectedWallet.value,
                ),
              ),
            ),*/
            height10,
            AppText(
              text: "Price",
              fontSize: 18,
            ),
            height10,
            AppInputContainer(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Rate cannot be empty";
                }
                return null;
              },
              controller: controller.rate.value,
              onTextChange: (val) {
                if (val.isNotEmpty) {
                //  controller.dollarAmount.value = int.parse(val);
                  controller.convertedAmount.value.text= "${double.parse(val) *double.parse(controller.amount.value.text)}";

                } else {
                  controller.convertedAmount.value.text = "";
                }
              },

              inputType: TextInputType.number,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "Enter your price",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            const AppText(
              text: "Request Amount (\$)",
              fontSize: 18,
            ),
          /*  height10,
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              AppText(
                text: "GDX Live Rate",
                fontSize: 15,
                textColor: AppColor().orange,
              ),
              Obx(
                    () => AppText(
                  textColor: AppColor().green,
                  text:
                  "${controller.amountInt.value} GDX = \$ ${controller.homePageController.gdxLiveRateModel.value != null ? (controller.amountInt.value) * double.parse(controller.homePageController.gdxLiveRateModel.value!.data.rate.toStringAsFixed(2)) : "0.0" ?? 0.0} ",
                  fontSize: 15,
                ),
              ),
            ]),*/
            height10,
            AppInputContainer(
              enableEdit: false,

              controller: controller.convertedAmount.value,
              onTextChange: (val) {},

              inputType: TextInputType.number,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: " ",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),

          ],
        ),
      ),
    );
  }

  topWidget(QrModel? value) {
    return Container(
        // addmoneyNfi (0:3484)
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

        // height: 40,
        decoration: BoxDecoration(
          color: Color(0xff2b2b44),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                width10,
                const AppText(
                  text: "GDX Balance",
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                AppText(
                  text: "${value?.data.balance.toStringAsFixed(2)}",
                  fontSize: 15,
                  textColor: AppColor().green,
                ),
              ],
            ),
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
