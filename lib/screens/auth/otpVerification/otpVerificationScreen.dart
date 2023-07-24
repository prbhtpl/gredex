import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/app_input_container.dart';
import '../../../commonWidget/bottom_navigation.dart';
import '../../../getXController/verifyOtp/verifyController.dart';

class OTPVerificationScreen extends StatelessWidget {
  OTPVerificationScreen({Key? key}) : super(key: key);
  var verificationFormKey = GlobalKey<FormState>();
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
    return GetBuilder<VerifyController>(
        init: VerifyController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppToolbar(
              onPressBackButton: () {
                Navigator.pop(context);
              },
              enableBackArrow: true,
              title: "OTP Verification",
              appColor: Colors.transparent,
            ),
            backgroundColor: AppColor().primaryColor,
            body: AppPageLoader(
                isLoading: controller.loaderStatus.value,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/message.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppText(
                          text:
                              "An authentication code has been sent to your \nemail number",
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: verificationFormKey,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 33.5),
                            decoration: BoxDecoration(
                              color: Color(0xff2b2b44).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                AppInputContainer(
                                  enableEdit: false,
                                  controller:
                                      controller.loginController.userId.value,
                                  inputType: TextInputType.number,
                                  onClick: () {},
                                  prefixWidget:
                                      Icon(Icons.lock, color: Colors.white),
                                  textBackgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  placeholder: "Enter Your Id",
                                  maxLines: 1,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                AppInputContainer(
                                  obSecure: true,
                                  controller: controller.newPassword.value,
                                  inputType: TextInputType.text,
                                  onClick: () {
                                    //  controller.userId.value.text = "GDX";
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter password";
                                    } else {
                                      //call function to check password
                                      bool result = validatePassword(value);
                                      if (result) {
                                        // create account event
                                        return null;
                                      } else {
                                        return " Password should contain Capital, small letter & Number & Special";
                                      }
                                    }
                                  },
                                  prefixWidget:
                                      Icon(Icons.password, color: Colors.white),
                                  textBackgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  placeholder: "Enter New Password",
                                  maxLines: 1,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                AppInputContainer(
                                  controller: controller.confirmPassword.value,
                                  inputType: TextInputType.text,
                                  onClick: () {
                                    //  controller.userId.value.text = "GDX";
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter password";
                                    } else {
                                      //call function to check password
                                      bool result = validatePassword(value);
                                      if (result) {
                                        // create account event
                                        return null;
                                      } else {
                                        return " Password should contain Capital, small letter & Number & Special";
                                      }
                                    }
                                  },
                                  prefixWidget: const Icon(Icons.password,
                                      color: Colors.white),
                                  textBackgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  placeholder: "Confirm your password",
                                  maxLines: 1,
                                  textCapitalization: TextCapitalization.words,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    OtpTextField(
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                        obscureText: true,
                                        borderRadius: BorderRadius.circular(10),
                                        keyboardType: TextInputType.number,
                                        numberOfFields: 4,
                                        borderColor: AppColor().green,
                                        //set to true to show as box or false to show as dash
                                        showFieldAsBox: true,
                                        //runs when a code is typed in
                                        onCodeChanged: (String code) {
                                          controller.otp.value = code;
                                          //handle validation or checks here
                                        },
                                        //runs when every textfield is filled
                                        onSubmit: (String verificationCode) {
                                          controller.otp.value =
                                              verificationCode;
                                          // showDialog(
                                          //     context: context,
                                          //     builder: (context) {
                                          //       return AlertDialog(
                                          //         title: Text("Verification Code"),
                                          //         content: Text('Code entered is $verificationCode'),
                                          //       );
                                          //     });
                                        }),
                                    TextButton(
                                        onPressed: () {
                                          controller.loginController
                                              .forgetPassword();
                                        },
                                        child: const Text("Resend Otp"))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          buttonText: "Verify Now",
                          onClickButton: () {
                            if (verificationFormKey.currentState!.validate()) {
                              if (controller.otp.value != "") {
                                controller.verify();
                              } else {
                                AppUtility.showErrorSnackBar("Enter Your Otp!");
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
