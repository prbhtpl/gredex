import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/screens/dashboard/dashboardScreen.dart';
import 'package:gredex/screens/myPlan/totalDepositBalance/withdrawal/scanPage/scanPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../Utility/app_utility.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../commonWidget/bottom_navigation.dart';
import '../../../../commonWidget/customButton.dart';
import '../../../../commonWidget/showDialoueBox.dart';
import '../../../../getXController/qrController/qrController.dart';
import '../../../../getXController/withdrawal/withdrawalTransController.dart';

class Withdrawal extends StatelessWidget {
  Withdrawal({Key, this.showGDXString, this.balance, key}) : super(key: key);
  final String? showGDXString;
  final String? balance;
  var withdrawalFromKey = GlobalKey<FormState>();

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
              title: " ",
              appColor: Colors.transparent,
            ),
            backgroundColor: AppColor().primaryColor,
            body: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColor().secondPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: "$showGDXString Balance",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    height10,
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    AppText(
                                      text: "$balance $showGDXString",
                                      fontSize: 12,
                                      textColor: AppColor().highLightColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      height10,
                      height10,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: topWidget()),
                      height10,
                      height10,
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: formWidget(context, controller)),
                      height10,
                      height10,
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, bottom: 0),
                        child: Obx(() => controller.showOtpField.value
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        controller.sendOtp();
                                      },
                                      child: Text("Resend Otp")),
                                ],
                              )
                            : SizedBox()),
                      ),
                      // CustomButton(
                      //   buttonText: "Verify",
                      //   onClickButton: () {
                      //
                      //   },
                      // ),
                      //     : CustomButton(
                      //   buttonText: "Withdrawal",
                      //   onClickButton: () {
                      //
                      //
                      //
                      //   },
                      // )),
                      showGDXString=="GDX"? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: AppText(
                            text:
                                "Note: Minimum 1 GDX maintain in your wallet!",
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            textColor: AppColor().red,
                          )):SizedBox(),
                      SizedBox(
                        height: 5,
                      ),

                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: downWidget(controller, context)),
                      height10,
                      SizedBox(
                        height: Get.width / 2,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  downWidget(WithdrawalController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: "Receive Amount",
                fontWeight: FontWeight.w700,
                fontSize: 12,
                textColor: AppColor().greyText,
              ),
              SizedBox(
                height: 5,
              ),
              Obx(() => AppText(
                    text: "${controller.stringAmount.value} GDX",
                    fontSize: 16,
                  )),
            ],
          ),
          Obx(() => controller.showOtpField.value
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().oldThemeColors),
                  onPressed: () {
                    if (controller.otp != "") {
                      controller.verifyWithdrawal().then(
                        (value) {
                          print("verifyWithdrawal$value");
                          if (value == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));
                          }
                        },
                      );
                    } else {
                      AppUtility.showErrorSnackBar("Enter Otp First");
                    }
                  },
                  child: const Text("Verify"),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().oldThemeColors),
                  onPressed: () {
                    if (withdrawalFromKey.currentState!.validate()) {
                      if (double.parse(controller.amount.value.text) > 5.00) {
                        ShowBox().showBox(
                            text: "Are you sure want send on this address?",
                            showCancelButton: true,
                            onButtonClick: () {
                              controller.sendOtp();
                              Get.back();
                            },
                            titleContent:
                                "Address: ${controller.address.value.text}\nAmount: ${controller.amount.value.text}",
                            buttonText: "Done");
                      } else {
                        AppUtility.showErrorSnackBar(
                            "Amount Should be greater than 5");
                      }
                    }
                  },
                  child: const Text("Withdrawal"),
                ))
        ],
      ),
    );
  }

  TextEditingController network = TextEditingController();

  formWidget(BuildContext context, WithdrawalController controller) {
    network.text = "BNB Smart Chain(BEP-20)";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Form(
        key: withdrawalFromKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              text: "Address",
              fontSize: 15,
            ),
            height10,
            AppInputContainer(
              suffixWidget: IconButton(
                onPressed: () {
                  Get.to(() => ScanPage());
                },
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.grey,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Address cannot be empty";
                }
                return null;
              },
              controller: controller.address.value,
              onTextChange: (val) {},
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "",
              maxLines: 1,
              inputType: TextInputType.text,
              //controller: controller.suggestionController,
            ),
            height10,
            const AppText(
              text: "Network",
              fontSize: 15,
            ),
            height10,
            AppInputContainer(
              enableEdit: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "User-Id cannot be empty";
                }
                return null;
              },
              //controller: controller.username.value,
              onTextChange: (val) {},
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: "BNB Smart Chain(BEP-20)",
              maxLines: 1,
              inputType: TextInputType.number,
              controller: network,
            ),
            height10,
            const AppText(
              text: "Amount",
              fontSize: 15,
            ),
            height10,
            AppInputContainer(
              suffixWidget: TextButton(
                onPressed: () {
                  if (double.parse(balance!) > 1) {
                    controller.amount.value.text =
                        (double.parse(balance!) - 1.00).toStringAsFixed(2);
                    controller.stringAmount.value =
                        controller.amount.value.text;
                  } else {
                    AppUtility.showErrorSnackBar("Balance is less  than 1");
                  }
                },
                child: AppText(
                  text: "MAX",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),

              validator: (value) {
                if (value!.isEmpty) {
                  return "User-Id cannot be empty";
                }
                return null;
              },
              controller: controller.amount.value,
              onTextChange: (val) {
                controller.stringAmount.value = val;
              },
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: showGDXString == "Shiba" ||
                      showGDXString == "Baby Doge"
                  ? "0.0 $showGDXString"
                  : "Minimum ${showGDXString == "GDX" ? 5 : 0.1} $showGDXString",
              maxLines: 1,
              inputType: TextInputType.number,
              //controller: controller.suggestionController,
            ),
          ],
        ),
      ),
    );
  }

  topWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         AppText(
          text: "Send $showGDXString",
          fontSize: 16,
        ),
        SizedBox(
          height: 5,
        ),
        AppText(
          text: "Send $showGDXString to crypto address",
          fontWeight: FontWeight.w700,
          fontSize: 15,
          textColor: AppColor().greyText,
        ),
      ],
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
