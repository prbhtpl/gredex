import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/getXController/withdrawlController/withdrawlController.dart';
import 'package:gredex/model/withdrawalReportModel/withdrawalReportModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../Utility/app_utility.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../commonWidget/customButton.dart';
import '../../../../commonWidget/noData.dart';
import '../../../../model/profileModel/profileModel.dart';

class WithdrawnAmount extends StatefulWidget {
  const WithdrawnAmount({Key? key}) : super(key: key);

  @override
  State<WithdrawnAmount> createState() => _WithdrawnAmountState();
}

class _WithdrawnAmountState extends State<WithdrawnAmount> {
  HomePageController homePageController = Get.put(HomePageController());

  bool visibleHistory = false;
  var withdrawalFromKey = GlobalKey<FormState>();

  @override
  void initState() {
   // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawalController>(
      init: WithdrawalController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Withdrawal",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: SingleChildScrollView(
            child: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Column(
                  children: [
                    Obx(() =>
                        topWidget(homePageController.allUserProfileData.value)),
                    height10,
                    formWidget(controller),
                    height10,

                    height10,
                    Obx(() => controller.showOtpField.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OtpTextField(
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                  keyboardType: TextInputType.number,
                                  numberOfFields: 4,
                                  borderColor: AppColor().green,
                                  //set to true to show as box or false to show as dash
                                  showFieldAsBox: true,
                                  //runs when a code is typed in
                                  onCodeChanged: (String code) {
                                    //handle validation or checks here
                                  },
                                  //runs when every textfield is filled
                                  onSubmit: (String verificationCode) {
                                    controller.otp.value = verificationCode;
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return AlertDialog(
                                    //         title: Text("Verification Code"),
                                    //         content: Text('Code entered is $verificationCode'),
                                    //       );
                                    //     });
                                  }),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.withdrawalAmount();
                                  },
                                  child: Text("Resend Otp")),
                            ],
                          )
                        : SizedBox()),
                    height10,
                    Obx(() => controller.showOtpField.value
                        ? CustomButton(
                      buttonText: "Verify",
                      onClickButton: () {
                        if (controller.otp != "") {
                          controller.verifyWithdrawal();
                        } else {
                          AppUtility.showErrorSnackBar("Enter Otp First");
                        }
                      },
                    )
                        : CustomButton(
                      buttonText: "Withdrawal",
                      onClickButton: () {
                        if (controller.selectedWalletId != "0") {
                          if (withdrawalFromKey.currentState!.validate()) {
                            controller.withdrawalAmount();
                          } else {
                            AppUtility.showErrorSnackBar("Enter Amount First");
                          }
                        } else {
                          AppUtility.showErrorSnackBar(
                              "Select Account Type First");
                        }
                      },
                    )),
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
                        child:
                            teamWidget(controller.withdrawalReportModel.value)),
                    height10,
                    height10
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget teamWidget(WithdrawalReportModel? data) {
    return ListView.builder(
      itemCount: data != null ? data.data.length : 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var dataItem = data?.data;
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
          }
        }

        return data!.data.isNotEmpty
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppText(
                              text: "Amount",
                              fontSize: 15,
                            ),
                            AppText(
                              text: data != null
                                  ? "\$${data.data[index].withdrawalAmount.toStringAsFixed(2)}"
                                  : "N/A",
                              fontSize: 15,
                            ),
                          ],
                        )),
                    height10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                text: "Usd Amount",
                                fontSize: 15,
                              ),
                              height10,
                              const AppText(
                                text: "Description",
                                fontSize: 15,
                              ),
                              height10,
                              const   AppText(
                                text: "Status",
                                fontSize: 15,
                              ),
                              height10,
                              const   AppText(
                                text: "Txn",
                                fontSize: 15,
                              ),
                              height10,
                              const    AppText(
                                text: "Withdrawal Gdx",
                                fontSize: 15,
                              ),
                              height10,
                              const    AppText(
                                text: "Date Time",
                                fontSize: 15,
                              ),
                              height10,
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppText(
                                text: data != null
                                    ? data.data[index].usdAmount
                                        .toStringAsFixed(2)
                                    : "N/A",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: data != null
                                    ? data.data[index].amountType == "ent" ||  data.data[index].amountType == "int"
                                        ? "Internal Wallet"
                                        : "GDX Wallet"
                                    : "N/A",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: data != null ? status : "N/A",
                                fontSize: 15,
                                textColor: data != null ? statusColor : null,
                              ),
                              height10,
                              AppText(
                                text: data != null
                                    ? data.data[index].tnx.toStringAsFixed(2)
                                    : "N/A",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: data != null
                                    ? data.data[index].gdxAmount
                                        .toStringAsFixed(2)
                                    : "N/A",
                                fontSize: 15,
                              ),
                              height10,
                              AppText(
                                text: dataItem != null
                                    ? AppUtility.parseDate(
                                        dataItem[index].createdAt)
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

  List wallet = [
    {"name": "Internal Wallet", "id": "1"},
    {"name": "GDX Wallet", "id": "2"},
  ];

  formWidget(WithdrawalController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

      // height: 40,
      decoration: BoxDecoration(
        color: AppColor().secondPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: withdrawalFromKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  items: wallet.map((item) {
                    return DropdownMenuItem(
                      value: item["name"],
                      child: Text(
                        item["name"].toString(),style:  TextStyle(color: Colors.white ),
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

                    controller.amount.value.clear();
                    controller.convertedAmount.value.clear();
                    debugPrint(aaa.toString());
                    setState(() {
                      controller.selectedWallet.value = value! as String?;
                    });
                  },
                  value: controller.selectedWallet.value,
                ),
              ),
            ),
            height10,
            AppText(
              text: "Amount",
              fontSize: 18,
            ),
            height10,
            AppInputContainer(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Amount cannot be empty";
                }
                return null;
              },
              controller: controller.amount.value,
              onTextChange: (val) {
                if (val.isNotEmpty) {
                  controller.dollarAmount.value = int.parse(val);

                  controller.convertedAmount.value.text =
                      controller.selectedWalletId == "1"
                          ? (double.parse(val) /
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
                }
              },

              inputType: TextInputType.number,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: " ",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            const AppText(
              text: "Converted Amount",
              fontSize: 18,
            ),
            height10,
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
            ]),
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
            height10,

          ],
        ),
      ),
    );
  }

  topWidget(ProfileModel? value) {
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
                AppText(
                  text: "Internal Wallet",
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                AppText(
                  text: "\$ ${value?.data.internalWallet.toStringAsFixed(2)}",
                  fontSize: 15,
                  textColor: AppColor().green,
                ),
              ],
            ),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                width10,
                const AppText(
                  text: "GDX Wallet",
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                AppText(
                  text: "${value?.data.internalGdxWallet.toStringAsFixed(2)}",
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
