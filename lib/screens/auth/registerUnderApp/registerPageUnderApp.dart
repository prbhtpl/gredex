import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../Utility/app_utility.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/app_input_container.dart';
import '../../../commonWidget/customButton.dart';
import '../../../getXController/registerPageUnderAppController/registerUnderAppController.dart';

class RegisterUnderApp extends StatefulWidget {
  const RegisterUnderApp({required this.referralCode, Key? key})
      : super(key: key);
  final String referralCode;

  @override
  State<RegisterUnderApp> createState() => _RegisterUnderAppState();
}

class _RegisterUnderAppState extends State<RegisterUnderApp> {
  var registerUnderAppFromKey = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterUnderAppController>(
      init: RegisterUnderAppController(),builder: (controller) {
      return Scaffold(
        appBar: AppToolbar(
          onPressBackButton: () {
            Navigator.pop(context);
          },
          enableBackArrow: true,
          title: "Register",
          appColor: Colors.transparent,
        ),
        backgroundColor: AppColor().primaryColor,
        body: SingleChildScrollView(
            child: AppPageLoader(
              isLoading: controller.loaderStatus.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 33.5),
                            decoration: BoxDecoration(
                              color: Color(0xff2b2b44).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: register(controller)),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: Get.width / 1.8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      );
    },);
  }

  @override
  void dispose() {
    registerUnderAppFromKey.currentState!.dispose();
    super.dispose();
  }

  Widget register(RegisterUnderAppController controller) {
    controller.referralCode.value.text = widget.referralCode;
    return Form(
            key: registerUnderAppFromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppInputContainer(
                  prefixWidget: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      width: 30,
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
                  inputType: TextInputType.number,
                  enableEdit: false,
                  controller: controller.referralCode.value,
                  textBackgroundColor: Colors.white.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  placeholder: "Referral Code",
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  //controller: controller.suggestionController,
                ),
                SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
                AppInputContainer(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                  controller: controller.fullName.value,
                  textBackgroundColor: Colors.white.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  placeholder: "Full Name",
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  //controller: controller.suggestionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppInputContainer(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                  controller: controller.email.value,
                  textBackgroundColor: Colors.white.withOpacity(0.3),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  placeholder: "Email",
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  //controller: controller.suggestionController,
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // AppInputContainer(
                //   prefixWidget: CountryCodePicker(
                //     padding: EdgeInsets.zero,
                //     flagWidth: 20,
                //     onChanged: (value) {
                //       controller.countryCode = value.toString();
                //       print("country Code  ${controller.countryCode}");
                //     },
                //     onInit: (value) {
                //       controller.countryCode = value.toString();
                //       print("country Code  ${controller.countryCode}");
                //     },
                //     // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                //     //showDropDownButton: true,
                //     // favorite: ['+91','IN'],
                //     // countryFilter: const ['IT', 'FR'],
                //     initialSelection: '+91',
                //     textStyle: TextStyle(color: Colors.white),
                //     // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                //     flagDecoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(2),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value!.length != 10) {
                //       return "Number can be less then 10 digit";
                //     }
                //     return null;
                //   },
                //   controller: controller.mobileNumber.value,
                //   inputType: TextInputType.phone,
                //   inputformatter: [LengthLimitingTextInputFormatter(10)],
                //   textBackgroundColor: Colors.white.withOpacity(0.3),
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   placeholder: "Mobile Number",
                //   maxLines: 1,
                //   textCapitalization: TextCapitalization.words,
                //   //controller: controller.suggestionController,
                // ),
                /*const SizedBox(
                  height: 20,
                ),
                AppInputContainer(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                  },
                  controller: controller.password.value,
                  textBackgroundColor: Colors.white.withOpacity(0.3),

                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  placeholder: "Password",
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  //controller: controller.suggestionController,
                ),*/

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            activeColor: Colors.green,
                            title: AppText(
                              fontWeight: controller.choose == "Left"
                                  ? FontWeight.bold
                                  : null,
                              text: "Left",
                              fontSize: 15,
                            ),
                            value: "Left",
                            groupValue: controller.choose,
                            onChanged: (value) {
                              setState(() {
                                controller.choose = value;
                                controller.leftOrRight.value =
                                    value![0].capitalize.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: Colors.green,
                            title: AppText(
                              fontWeight: controller.choose == "Right"
                                  ? FontWeight.bold
                                  : null,
                              text: "Right",
                              fontSize: 15,
                            ),
                            value: "Right",
                            groupValue: controller.choose,
                            onChanged: (value) {
                              setState(() {
                                controller.choose = value.toString();
                                controller.leftOrRight.value =
                                    value![0].capitalize.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                CustomButton(
                  buttonText: "Sign Up",
                  onClickButton: () {
                    // ShowBox().congratulationDialogueBox(
                    //     title: "Congratulations\nYou now part of Gridx Ecosystem",
                    //     onButtonClick: () {
                    //       Get.back();
                    //     },
                    //     userId: "controller.u",
                    //     name: controller.fullName.value.text,
                    //     password:  controller.password.value.text,
                    //     buttonText: "Done",
                    //     context: Get.context!);

                    if (controller.leftOrRight.isNotEmpty) {
                      if (registerUnderAppFromKey.currentState!.validate()) {
                        controller.registerUnderApp().then((value) {
                          print("value+ ${value}");
                          if (value != null) {
                            Navigator.pop(context);
                          }
                        });
                      } else {}
                    } else {
                      AppUtility.showErrorSnackBar("Select Position First");
                    }
                  },
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const AppText(
                //       text: "Already have an acco unt? ",
                //       fontSize: 15,
                //     ),
                //     AppText(
                //       onTap: () {
                //         Get.toNamed(AppRoutes.loginPage);
                //       },
                //       underline: true,
                //       text: "Login",
                //       fontSize: 15,
                //       textColor: AppColor().textOrange,
                //     )
                //   ],
                // )
              ],
            ),
          );

  }
}
