import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Utility/app_toolbar.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/app_input_container.dart';
import '../../../commonWidget/app_page_loader.dart';
import '../../../commonWidget/noData.dart';
import '../../../getXController/activationHistoryController/activationHistoryController.dart';
import '../../../getXController/homePageController/homePageController.dart';
import '../../../model/profileModel/profileModel.dart';

class ActivateAccount extends StatefulWidget {
  const ActivateAccount({Key? key}) : super(key: key);

  @override
  State<ActivateAccount> createState() => _ActivateAccountState();
}

class _ActivateAccountState extends State<ActivateAccount> {
  bool visibleHistory = false;
  HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActivationHistoryController>(
        init: ActivationHistoryController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppToolbar(
              onPressBackButton: () {
                Navigator.pop(context);
              },
              enableBackArrow: true,
              title: "Activation",
              appColor: Colors.transparent,
            ),
            backgroundColor: AppColor().primaryColor,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() =>
                        topWidget(homePageController.allUserProfileData.value)),
                    Obx(() => formWidget(controller)),
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
                        child: Obx(() => teamWidget(controller))),
                    height10,
                    SizedBox(
                      height: Get.height / 3,
                    ),
                    height10,
                  ],
                ),
              ),
            ),
          );
        });
  }

  List wallet = [
    {"name": "External Wallet", "id": "1"},
    {"name": "GDX Wallet", "id": "2"},
    {"name": "Auto GDX Activation", "id": "3"},
  ];

  Widget teamWidget(ActivationHistoryController controller) {
    var data = controller.activationHistoryModel.value;
    return AppPageLoader(
      isLoading: controller.loaderStatus.value,
      child: data != null
          ? ListView.builder(
              itemCount: data != null ? data.data.length : 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var dataItem = data.data;
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
                                padding: const EdgeInsets.symmetric(
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
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AppText(
                                      text: "Plan Amount",
                                      fontSize: 15,
                                    ),
                                    AppText(
                                      text: dataItem != null
                                          ? "\$${dataItem[index].usdamount.toStringAsFixed(2)}"
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AppText(
                                        text: "GDX",
                                        fontSize: 15,
                                      ),
                                      height10,
                                      const AppText(
                                        text: "User Id",
                                        fontSize: 15,
                                      ),
                                      height10,
                                      const AppText(
                                        text: "Amount Type",
                                        fontSize: 15,
                                      ),
                                      height10,
                                      const AppText(
                                        text: "Activation Status",
                                        fontSize: 15,
                                      ),
                                      height10,
                                      const AppText(
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
                                        text: dataItem != null
                                            ? "${dataItem[index].gdxamount.toStringAsFixed(2)}"
                                            : "N/A",
                                        fontSize: 15,
                                      ),
                                      height10,
                                      AppText(
                                        text: dataItem != null
                                            ? dataItem[index].username
                                            : "N/A",
                                        fontSize: 15,
                                        textColor: AppColor().green,
                                      ),
                                      height10,
                                      AppText(
                                        text: "External Wallet",
                                        fontSize: 15,
                                        textColor: AppColor().textOrange,
                                      ),
                                      height10,
                                      AppText(
                                        text: dataItem[index].status == 0
                                            ? "Renewal"
                                            : "Active",
                                        fontSize: 15,
                                        textColor: dataItem[index].status == 0
                                            ? AppColor().highLightColor
                                            : AppColor().textOrange,
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
            )
          : NoData(),
    );
  }

  String? choose;

  topWidget(ProfileModel? value) {
    return Container(
        // addmoneyNfi (0:3484)
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

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
                  text: "External Wallet",
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                AppText(
                  text: "\$ ${value?.data.externalWallet.toStringAsFixed(2)}",
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
                      "\$ ${value?.data.externalGdxWallet.toStringAsFixed(2)}",
                  fontSize: 15,
                  textColor: AppColor().green,
                ),
              ],
            ),
          ],
        ));
  }

  var activation = GlobalKey<FormState>();

  formWidget(ActivationHistoryController controller) {
    return AppPageLoader(
      isLoading: controller.loaderStatus.value,
      child: Form(
        key: activation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),

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
              AppInputContainer(
                prefixWidget: Padding(
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
                inputType: TextInputType.number,
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
                  )),
                    style: const TextStyle(color: Colors.white ),                    isExpanded: true,
                    hint: const Text("Select Wallet",
                        style:
                            TextStyle(color: Color(0xffC8C7CE), fontSize: 15)),
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
                        "\$${controller.amountInt.value}  =  ${controller.homePageController.gdxLiveRateModel.value != null ? "${((controller.amountInt.value) / double.parse(controller.homePageController.gdxLiveRateModel.value!.data.rate.toStringAsFixed(2))).toStringAsFixed(2)} GDX" : "0.0" ?? 0.0} ",
                    fontSize: 15,
                  ),
                ),
              ]),
              height10,
              AppInputContainer(controller: controller.amount.value,
                onTextChange: (val) {
                  if (val.isNotEmpty) {
                    controller.amountInt.value = int.parse(val);
                  } else {
                    controller.amountInt.value = 1;
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
                            textStyle: const TextStyle(color: Colors.white),
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
                              controller.activateAccount();
                            },
                            child: Text("Resend Otp")),
                      ],
                    )
                  : SizedBox()),
              height10,
              Obx(
                () => controller.showOtpField.value
                    ? CustomButton(
                        buttonText: "Verify",
                        onClickButton: () {
                          if (controller.otp != "") {
                            controller.verifyActivation();
                          } else {
                            AppUtility.showErrorSnackBar("Enter Otp First");
                          }
                        },
                      )
                    : CustomButton(
                        onClickButton: () {
                          if (controller.selectedWalletId != "0") {
                            if (activation.currentState!.validate()) {
                              controller.activateAccount();
                            }
                          } else {
                            AppUtility.showErrorSnackBar(
                                "Select Account Type First");
                          }
                        },
                        buttonText: "Submit",
                      ),
              ),
              height10,
            ],
          ),
        ),
      ),
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
