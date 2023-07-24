import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/appColors.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../Utility/app_routes.dart';
import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/app_input_container.dart';
import '../../../commonWidget/bottom_navigation.dart';
import '../../../commonWidget/customButton.dart';
import '../../../getXController/registerController/registerationController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({this.sponserId, this.position, Key? key})
      : super(key: key);
  final String? sponserId;
  final String? position;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var registerFromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().primaryColor,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: Get.height / 7,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/splashImage.png',
                  scale: 4,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 33.5),
                    decoration: BoxDecoration(
                      color: Color(0xff2b2b44).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: register()),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    registerFromKey.currentState!.dispose();
    super.dispose();
  }

  String? choose;

  Widget register() {
    return GetBuilder<RegistrationController>(
        init: RegistrationController(),
        builder: (controller) {
          if (widget.sponserId != null) {
            controller.referralCode.value.text = widget.sponserId.toString();
            choose = widget.position;
            controller.leftOrRight.value = choose![0].capitalize.toString();
          }

          controller.sponserId.value= widget.sponserId;
          return AppPageLoader(isLoading: controller.loaderStatus.value,
            child: Form(
              key: registerFromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  widget.sponserId != null
                      ? AppInputContainer(
                          inputType: TextInputType.number,
                          enableEdit: false,
                          controller: controller.referralCode.value,
                          textBackgroundColor: Colors.white.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          placeholder: "Referral Code",
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          //controller: controller.suggestionController,
                        )
                      : AppInputContainer(
                          inputType: TextInputType.number,
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
                          controller: controller.referralCode.value,
                          textBackgroundColor: Colors.white.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          placeholder: "Referral Code",
                          maxLines: 1,
                          textCapitalization: TextCapitalization.words,
                          //controller: controller.suggestionController,
                        ),
                  widget.sponserId != null
                      ? SizedBox(
                          height: 20,
                        )
                      : SizedBox(
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
                 /* const SizedBox(
                    height: 20,
                  ),
                  AppInputContainer(
                    prefixWidget: CountryCodePicker(
                      padding: EdgeInsets.zero,
                      flagWidth: 20,
                      onChanged: (value) {
                        controller.countryCode = value.toString();
                        print("country Code  ${controller.countryCode}");
                      },
                      onInit: (value) {
                        controller.countryCode = value.toString();
                        print("country Code  ${controller.countryCode}");
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      //showDropDownButton: true,
                      // favorite: ['+91','IN'],
                      // countryFilter: const ['IT', 'FR'],
                      initialSelection: '+91',
                      textStyle: const TextStyle(color: Colors.white),
                      // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
                      flagDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
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
                  ),*/
              /*    const SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile(
                              activeColor: Colors.green,
                              title: AppText(
                                fontWeight:
                                    choose == "Left" ? FontWeight.bold : null,
                                text: "Left",
                                fontSize: 15,
                              ),
                              value: "Left",
                              groupValue: choose,
                              onChanged: (value) {
                                setState(() {
                                  choose = value;
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
                                fontWeight:
                                    choose == "Right" ? FontWeight.bold : null,
                                text: "Right",
                                fontSize: 15,
                              ),
                              value: "Right",
                              groupValue: choose,
                              onChanged: (value) {
                                setState(() {
                                  choose = value.toString();
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
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: "Sign Up",
                    onClickButton: () {
                      if (controller.leftOrRight.isNotEmpty) {
                        if (registerFromKey.currentState!.validate()) {
                          controller.register();
                        } else {}
                      } else {
                        AppUtility.showErrorSnackBar("Select Position First");
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        text: "Already have an account? ",
                        fontSize: 15,
                      ),
                      AppText(
                        onTap: () {
                          Get.toNamed(AppRoutes.loginPage);
                        },
                        underline: true,
                        text: "Login",
                        fontSize: 15,
                        textColor: AppColor().textOrange,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
