import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/getXController/updatePasswordController/updatePasswordController.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
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
    return GetBuilder<UpdatePassword>(
      init: UpdatePassword(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Change Password",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: controller.changePasswordKey,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/design/illustration-Fjn.png',
                          height: 150,
                          width: 150,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          margin:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 5),

                          // height: 40,
                          decoration: BoxDecoration(
                            color: AppColor().secondPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              height10,
                              AppInputContainer(
                                controller: controller.oldPassword.value,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Old Password cannot be empty";
                                  }
                                },
                                textBackgroundColor:
                                    Colors.white.withOpacity(0.3),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                placeholder: "Old Password",
                                maxLines: 1,
                                textCapitalization: TextCapitalization.words,
                              ),
                              height10,
                              AppInputContainer(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "New Password cannot be empty";
                                  }else {
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
                                controller: controller.newPassword.value,
                                textBackgroundColor:
                                    Colors.white.withOpacity(0.3),

                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                placeholder: "New Password",
                                maxLines: 1,
                                textCapitalization: TextCapitalization.words,
                                //controller: controller.suggestionController,
                              ),
                              height10,
                              AppInputContainer(
                                obSecure: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This field cannot be empty";
                                  }else {
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
                                controller: controller.confirmPassword.value,
                                textBackgroundColor:
                                    Colors.white.withOpacity(0.3),

                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                placeholder: "Confirm Password",
                                maxLines: 1,
                                textCapitalization: TextCapitalization.words,
                                //controller: controller.suggestionController,
                              ),
                              height10,
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
                                  }),    height10,
                              ElevatedButton(onPressed: (){
                                controller.sendOtp();
                              }, child: Text("Resend Otp")),
                              height10,
                              CustomButton(
                                onClickButton: () {
                                  if (controller.changePasswordKey.currentState!
                                      .validate()) {
                                    if (controller.otp.isNotEmpty) {
                                      controller.updatePassword();
                                    } else {
                                      AppUtility.showErrorSnackBar(
                                          "Enter Otp First!");
                                    }
                                  }
                                },
                                buttonText: "Change Password",
                              ),
                              height10,
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
