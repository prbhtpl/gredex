import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/getXController/p2pTransactionController/p2pTransactionController.dart';
import 'package:gredex/model/p2pTransactionhistoryModel/p2pTransactionHistoryModel.dart';
import 'package:gredex/model/profileModel/profileModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';

class P2PTransfer extends StatefulWidget {
  const P2PTransfer({Key? key}) : super(key: key);

  @override
  State<P2PTransfer> createState() => _P2PTransferState();
}

class _P2PTransferState extends State<P2PTransfer> {
  bool visibleHistory = false;

@override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<P2PTransactionController>(
      init: P2PTransactionController(),

      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "P2P Transfer",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => topWidget(controller
                        .homePageController.allUserProfileData.value)),
                    formWidget(controller),
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
                        child: controller.p2pTransactionHistoryModel != null
                            ? ListView.builder(
                                itemCount: controller
                                        .p2pP2pTransactionHistoryList.length ??
                                    0,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return teamWidget(controller
                                      .p2pP2pTransactionHistoryList[index]);
                                },
                              )
                            : NoData()),
                    height10,
                    height10,  height10,  height10,  height10,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List wallet = [
    {"name": "Internal Wallet", "id": "1"},
    {"name": "GDX Wallet", "id": "2"},
  ];


  formWidget(P2PTransactionController controller) {
    return Form(
      key:controller. p2pFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

        // height: 40,
        decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height10,
            const AppText(
              text: "User ID",
              fontSize: 15,
            ),
            height10,
            AppInputContainer(prefixWidget: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                width: 40,
                child: Row(
                  children: [


                    SizedBox(
                        width: 35,
                        height: 20,
                        child: AppText(
                          text: "GDX",
                          fontSize: 15,
                          textColor: Colors.white70,
                        ))
                  ],
                ),
              ),
            ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "User-Id cannot be empty";
                }
                return null;
              },
              controller: controller.username.value,
              onTextChange: (val) {
                controller.checkUser();
              },
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            AppText(
              text: controller.checkUserModel.value?.data.name ??
                  controller.checkUserModel.value?.message,
              fontSize: 15,
              textColor: controller.checkUserModel.value?.data.name != null
                  ? AppColor().highLightColor
                  : AppColor().red,
            ),
            height10,
            const AppText(
              text: "Account Type",
              fontSize: 15,
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

                    debugPrint(aaa.toString());
                    setState(() {
                      controller.selectedWallet.value = value! as String?;
                    });
                  },
                  value: controller.selectedWallet.value,
                ),
              ),
            ),

            /*AppInputContainer(
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),*/

            height10,
            AppText(
              text: "Amount",
              fontSize: 15,
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
                  "${controller.amountInt.value} GDX = \$ ${controller.homePageController.gdxLiveRateModel.value != null ?( (controller.amountInt.value) * double.parse(controller.homePageController.gdxLiveRateModel.value!.data.rate.toStringAsFixed(2))).toStringAsFixed(2) : "0.0" ?? 0.0} ",
                  fontSize: 15,
                ),
              ),
            ]),
            height10,
            AppInputContainer(controller: controller.amount.value,
              onTextChange: (val) {

              if(val.isNotEmpty){
                controller.amountInt.value = int.parse(val);
               }else{
                controller.amountInt.value=1;
              }

              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Amount cannot be empty";
                }
                return null;
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
                      controller.p2pTransaction();
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
                  controller.verifyP2P();
                } else {
                  AppUtility.showErrorSnackBar("Enter Otp First");
                }
              },
            )
                : CustomButton(
              buttonText: "Transfer Now",
              onClickButton: () {
                if (controller.selectedWalletId != "0") {
                  if (controller.p2pFormKey.currentState!.validate()) {
                    controller.p2pTransaction();
                  } else {
                    AppUtility.showErrorSnackBar(
                        "Enter Amount First");
                  }
                } else {
                  AppUtility.showErrorSnackBar(
                      "Select Account Type First");
                }
              },
            )),
            // CustomButton(
            //   onClickButton: () {
            //     if (controller.selectedWalletId != "0") {
            //       if (p2pFormKey.currentState!.validate()) {
            //         controller.p2pTransaction();
            //       }
            //     } else {
            //       AppUtility.showErrorSnackBar("Select Account Type First");
            //     }
            //   },
            //   buttonText: "Transfer Now",
            // ),
            height10,
          ],
        ),
      ),
    );
  }

  Widget teamWidget(P2pTransactionHistoryList p2pP2pTransactionHistoryList) {
    return Container(
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    AppText(
                      text: p2pP2pTransactionHistoryList.debitorName,
                      fontSize: 15,
                    ),
                    AppText(
                      text: "${p2pP2pTransactionHistoryList.debitorId}",
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
                      height10,
                      AppText(
                        text: "Amount",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: p2pP2pTransactionHistoryList.creditorName,
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Wallet Type",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Type",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Date Time",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      height10,
                      AppText(text:"\$${p2pP2pTransactionHistoryList.usdamount.toStringAsFixed(2)}" ,
                        // text: p2pP2pTransactionHistoryList.walletType == "int"
                        //     ? "\$${p2pP2pTransactionHistoryList.usdamount.toStringAsFixed(2)}"
                        //     : p2pP2pTransactionHistoryList.usdamount
                        //         .toStringAsFixed(2),
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: p2pP2pTransactionHistoryList.creditorId,
                        fontSize: 15,
                        textColor: AppColor().green,
                      ),
                      height10,
                      AppText(
                          text: p2pP2pTransactionHistoryList.walletType == "int"
                              ? "Internal"
                              : "GDX",
                          fontSize: 15,
                          textColor: AppColor().textOrange),
                      height10,
                      AppText(
                        text: p2pP2pTransactionHistoryList.type,
                        fontSize: 15,
                        textColor: p2pP2pTransactionHistoryList.type == "Debit"
                            ? AppColor().orange
                            : AppColor().green,
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(
                            p2pP2pTransactionHistoryList.createdAt),
                        fontSize: 15,
                        textColor: AppColor().greyText,
                      ),
                      height10,
                    ],
                  ),
                ],
              ),
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
                  text:
                      "\$ ${value?.data.internalGdxWallet.toStringAsFixed(2)}",
                  fontSize: 15,
                  textColor: AppColor().green,
                ),
              ],
            ),
          ],
        ));
  }
}
