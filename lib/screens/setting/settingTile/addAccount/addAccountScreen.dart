import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/getXController/addAccountController/addAccountController.dart';
import 'package:gredex/model/AccountDetailsModel/AccountDetailsModel.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../commonWidget/showDialoueBox.dart';

class AddAccount extends StatefulWidget {
  AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  List accountType = [
    {"name": "upi", "id": "1"},
    {"name": "bank", "id": "2"},
    {"name": "trc20", "id": "3"},
  ];
  bool visibleHistory = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAccountController>(
      init: AddAccountController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Add Account",
            appColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Choose Account",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    height10,
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                      // height: 40,
                      decoration: BoxDecoration(
                        color: AppColor().secondPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                  color: AppColor().secondPrimaryColor)),
                          style: TextStyle(color: Colors.white),
                          isExpanded: true,
                          hint: const Text("Select Account Type",
                              style: TextStyle(
                                  color: Color(0xffC8C7CE), fontSize: 15)),
                          items: accountType.map((item) {
                            return DropdownMenuItem(
                              value: item["name"],
                              child: Text(
                                item["name"].toString().toUpperCase(),
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            var aaa = accountType.where((element) {
                              print("asd  $element");
                              if (element["name"] == value) {
                                controller.selectedAccountId.value =
                                    element["id"].toString();
                              }
                              return true;
                            });

                            debugPrint(aaa.toString());
                            setState(() {
                              controller.selectedAccountType.value =
                                  value! as String?;
                            });
                          },
                          value: controller.selectedAccountType.value,
                        ),
                      ),
                    ),
                    controller.selectedAccountId == "1"
                        ? upiWidget(controller)
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    controller.selectedAccountId == "2"
                        ? addAccountWidget(controller)
                        : SizedBox(),
                    controller.selectedAccountId == "3"
                        ? erc20(controller)
                        : SizedBox(),
                    height10,
                    AppText(
                      onTap: () {
                        setState(() {
                          visibleHistory = !visibleHistory;
                        });
                      },
                      text: visibleHistory ? "Hide Account" : " View Account",
                      textColor: AppColor().oldThemeColors,
                      underline: true,
                      fontSize: 15,
                    ),
                    height10,
                    Visibility(
                        visible: visibleHistory,
                        child:
                            teamWidget(controller.accountDetailsModel.value)),
                    SizedBox(
                      height: Get.height / 3,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget teamWidget(AccountDetailsModel? data) {
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
                    const AppText(
                      text: "Mobile Number",
                      fontSize: 15,
                    ),
                    Row(
                      children: [
                        AppText(
                          text: data != null ? "${data.data.mobile}" : "N/A",
                          fontSize: 15,
                        ),
                        width10,InkWell(onTap: (){

                          ShowBox().copyClipBoard(text:data!.data.mobile.toString());
                        },child: Icon(Icons.copy,size: 15,color: Colors.white,),)
                      ],
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
                      data != null && data.data.upi != null
                          ? AppText(
                              text: "Upi Id",
                              fontSize: 15,
                            )
                          : SizedBox(),
                      data != null && data.data.upi != null
                          ? height10
                          : SizedBox(),
                      data != null && data.data.accountNo != null
                          ? const AppText(
                              text: "Account Number",
                              fontSize: 15,
                            )
                          : SizedBox(),
                      data != null && data.data.accountNo != null
                          ? height10
                          : SizedBox(),
                      data != null && data.data.trc20 != null
                          ? const AppText(
                              text: "Trc20",
                              fontSize: 15,
                            )
                          : SizedBox(),
                      data != null && data.data.trc20 != null
                          ? height10
                          : SizedBox(),

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
                      data != null && data.data.upi != null
                          ? Row(
                            children: [
                              AppText(
                                  text: data != null ? data.data.upi : "N/A",
                                  fontSize: 15,
                                ),width10,InkWell(onTap: (){

                                ShowBox().copyClipBoard(text:data.data.upi.toString());
                              },child: Icon(Icons.copy,size: 15,color: Colors.white,),)
                            ],
                          )
                          : SizedBox(),
                      data != null && data.data.upi != null
                          ? height10
                          : SizedBox(),
                      data != null && data.data.accountNo != null
                          ? Row(
                            children: [
                              AppText(
                                  text: data != null ? data.data.accountNo : "N/A",
                                  fontSize: 15,
                                ),width10,InkWell(onTap: (){

                                ShowBox().copyClipBoard(text:data.data.accountNo.toString());
                              },child: Icon(Icons.copy,size: 15,color: Colors.white,),)
                            ],
                          )
                          : SizedBox(),
                      data != null && data.data.accountNo != null
                          ? height10
                          : SizedBox(),
                      data != null && data.data.trc20 != null
                          ? Row(
                            children: [
                              AppText(
                                  text: data != null ? data.data.trc20 : "N/A",
                                  fontSize: 15,
                                ),width10,InkWell(onTap: (){

                                ShowBox().copyClipBoard(text:data.data.trc20.toString());
                              },child: Icon(Icons.copy,size: 15,color: Colors.white,),)
                            ],
                          )
                          : SizedBox(),
                      data != null && data.data.trc20 != null
                          ? height10
                          : SizedBox(),

                      AppText(
                        text: data != null
                            ? AppUtility.parseDate(data.data.createdAt)
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
        ));
  }

  upiWidget(AddAccountController controller) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

        // height: 40,
        decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: addUpi,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/design/upi.png",
                scale: 9,
              ),
              height10,
              AppInputContainer(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Amount cannot be empty";
                  }
                  return null;
                },
                controller: controller.totalAccount.value,
                onTextChange: (val) {},

                inputType: TextInputType.text,
                textBackgroundColor: Colors.white.withOpacity(0.3),

                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Add you UPI Id here",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              AppInputContainer(
                validator: (value) {
                  if (value!.length != 10) {
                    return "Number can be less then 10 digit";
                  }
                  return null;
                },
                controller: controller.mobileNumber.value,
                inputType: TextInputType.phone,
                inputformatter: [LengthLimitingTextInputFormatter(10)],
                textBackgroundColor: Colors.white.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Mobile Number",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              ElevatedButton(
                onPressed: () {
                  if (addUpi.currentState!.validate()) {
                    controller.addAccount();
                  }
                },
                child: Text("Add UPI"),
              )
            ],
          ),
        ));
  }

  erc20(AddAccountController controller) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

        // height: 40,
        decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: erc20Key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: "Trc20 Address",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              height10,
              AppInputContainer(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Erc20 Address cannot be empty";
                  }
                  return null;
                },
                controller: controller.totalAccount.value,
                onTextChange: (val) {},

                inputType: TextInputType.text,
                textBackgroundColor: Colors.white.withOpacity(0.3),

                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Add Trc20 Address here",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              AppInputContainer(
                validator: (value) {
                  if (value!.length != 10) {
                    return "Number can be less then 10 digit";
                  }
                  return null;
                },
                controller: controller.mobileNumber.value,
                inputType: TextInputType.phone,
                inputformatter: [LengthLimitingTextInputFormatter(10)],
                textBackgroundColor: Colors.white.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Mobile Number",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              ElevatedButton(
                onPressed: () {
                  if (erc20Key.currentState!.validate()) {
                    controller.addAccount();
                  }
                },
                child: Text("Add Trc20"),
              )
            ],
          ),
        ));
  }

  var addAccountKey = GlobalKey<FormState>();

  var addUpi = GlobalKey<FormState>();
  var erc20Key = GlobalKey<FormState>();

  addAccountWidget(AddAccountController controller) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

        // height: 40,
        decoration: BoxDecoration(
          color: AppColor().secondPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: addAccountKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: "Account Number",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              height10,
              AppInputContainer(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Account Number cannot be empty";
                  }
                  return null;
                },
                controller: controller.totalAccount.value,
                onTextChange: (val) {},

                inputType: TextInputType.text,
                textBackgroundColor: Colors.white.withOpacity(0.3),

                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Account Number",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              const AppText(
                text: "Confirm Account Number",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              height10,
              AppInputContainer(
                obSecure: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Account Number cannot be empty";
                  }
                  return null;
                },
                controller: controller.confirmAccountNumber.value,
                onTextChange: (val) {},

                inputType: TextInputType.text,
                textBackgroundColor: Colors.white.withOpacity(0.3),

                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Confirm Account Number",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppText(
                          text: "Account Holder Name",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        height10,
                        AppInputContainer(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Account Holder Name cannot be empty";
                            }
                            return null;
                          },
                          controller: controller.accountHolderName.value,
                          onTextChange: (val) {},

                          inputType: TextInputType.text,
                          textBackgroundColor: Colors.white.withOpacity(0.3),

                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          placeholder: "Account Holder Name",
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          //controller: controller.suggestionController,
                        ),
                      ],
                    ),
                  ),
                  width10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "IFSC Code",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        height10,
                        AppInputContainer(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "IFSC code cannot be empty";
                            }
                            return null;
                          },
                          controller: controller.ifscCode.value,
                          onTextChange: (val) {},

                          inputType: TextInputType.text,
                          textBackgroundColor: Colors.white.withOpacity(0.3),

                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          placeholder: "IFSC Code",
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          //controller: controller.suggestionController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height10,
              const AppText(
                text: "Mobile Number",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              height10,
              AppInputContainer(
                validator: (value) {
                  if (value!.length != 10) {
                    return "Number can be less then 10 digit";
                  }
                  return null;
                },
                controller: controller.mobileNumber.value,
                inputType: TextInputType.phone,
                inputformatter: [LengthLimitingTextInputFormatter(10)],
                textBackgroundColor: Colors.white.withOpacity(0.3),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                placeholder: "Mobile Number",
                maxLines: 1,
                textCapitalization: TextCapitalization.words,
                //controller: controller.suggestionController,
              ),
              height10,
              ElevatedButton(
                onPressed: () {
                  if (addAccountKey.currentState!.validate()) {
                    if (controller.totalAccount.value.text ==
                        controller.confirmAccountNumber.value.text) {
                      controller.addAccount();
                    } else {
                      AppUtility.showErrorSnackBar("Account are not matched!");
                    }
                  }
                },
                child: Text("Add Account"),
              )
            ],
          ),
        ));
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
