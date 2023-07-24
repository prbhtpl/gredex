import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../../../../commonWidget/app_input_container.dart';
import '../../../../getXController/updateProfileController/updateProfileController.dart';

class ProfileReward extends StatefulWidget {
  ProfileReward({Key? key}) : super(key: key);

  @override
  State<ProfileReward> createState() => _ProfileRewardState();
}

class _ProfileRewardState extends State<ProfileReward> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateProfileController>(
      init: UpdateProfileController(),
      builder: (controller) {
        var data = controller.homePageController.allUserProfileData.value?.data;
        Color borderColor;
        if (data?.activMember == 0) {
          borderColor = const Color(0xff000000);
        } else if (data?.activMember == 1) {
          borderColor = const Color(0xff008000);
        } else if (data?.activMember == 2) {
          borderColor = const Color(0xff00B9E8);
        } else {
          borderColor = const Color(0xffffa500);
        }
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "My Profile",
            appColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              // imageZCC (0:12343)
                              margin:
                                  EdgeInsets.only(right: 5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: borderColor, width: 5),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  'assets/user.png',
                                  repeat: ImageRepeat.repeat,
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: borderColor, width: 5),
                            //     borderRadius: BorderRadius.circular(50),
                            //   ),
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(60),
                            //     // Image border
                            //     child: SizedBox.fromSize(
                            //         size: Size.fromRadius(50), // Image radius
                            //         child: Image.asset("assets/user.png")),
                            //   ),
                            // ),
                            Positioned(
                              bottom: 15,
                              right: 5,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red),
                                  height: 30,
                                  width: 30,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      // Expanded(child:Image.asset("assets/approved.png",scale: 5,)),
                    ],
                  ),

                  height10,
                  formWidget(controller),
                  height10,
                  CustomButton(
                    onClickButton: () {
                      if (/*controller.homePageController.allUserProfileData.value?.data.ev == 1 &&
                          controller.homePageController.allUserProfileData.value
                                  ?.data.sv ==
                              1 &&
                          controller.homePageController.allUserProfileData.value
                                  ?.data.gdxAddressChangeStatus ==
                              false &&
                          controller.homePageController.allUserProfileData.value
                                  ?.data.nameChangeStatus ==
                              1*/
                          controller.homePageController.allUserProfileData.value
                                  ?.data.changeStatus ==
                              1) {
                        AppUtility.showErrorSnackBar(
                            "Your Profile Already Verified");
                      } else {
                        controller.updateProfile();
                      }
                    },
                    buttonText: "Submit",
                  ),
                  SizedBox(
                    height: Get.height / 2,
                  )
                ],
              ),
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

  formWidget(UpdateProfileController controller) {
    return Container(
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
          height10,
          const AppText(
            text: "My ReferralCode",
            fontSize: 15,
          ),
          height10,
          Row(
            children: [
              Expanded(
                child: AppInputContainer(
                  enableEdit: false,

                  textBackgroundColor: Colors.white.withOpacity(0.3),

                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  placeholder: controller.homePageController.allUserProfileData
                      .value!.data.username,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  //controller: controller.suggestionController,
                ),
              ),
              IconButton(
                  onPressed: () {
                    ShowBox().copyClipBoard(
                        text: controller.homePageController.allUserProfileData
                            .value!.data.username
                            .toString());
                  },
                  icon: Icon(Icons.copy))
            ],
          ),
          height10,
          height10,
          const AppText(
            text: "Full Name",
            fontSize: 15,
          ),
          height10,
          AppInputContainer(
            enableEdit: (controller.homePageController.allUserProfileData.value
                        ?.data.changeStatus ==
                    0)
                ? true
                : false,
            suffixWidget: Obx(() => controller.homePageController
                        .allUserProfileData.value?.data.changeStatus ==
                    0
                ? SizedBox()
                : Icon(
                    Icons.verified,
                    color: AppColor().highLightColor,
                    size: 15,
                  )),
            controller: controller.fullName.value,
            validator: (value) {
              if (value!.isEmpty) {
                return "Full name cannot be empty";
              }
            },
            textBackgroundColor: Colors.white.withOpacity(0.3),

            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder:
                "${controller.homePageController.allUserProfileData.value?.data.name}",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            //controller: controller.suggestionController,
          ),
          height10,
         /* height10,
          const AppText(
            text: "Mobile Number",
            fontSize: 15,
          ),
          height10,
          AppInputContainer(  prefixWidget: CountryCodePicker(
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
            textStyle: TextStyle(color: Colors.white),
            // flag can be styled with BoxDecoration's `borderRadius` and `shape` fields
            flagDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
          ),
            enableEdit: controller.homePageController.allUserProfileData.value
                        ?.data.changeStatus ==
                    0
                ? true
                : false,

            inputformatter: [LengthLimitingTextInputFormatter(10)],
            inputType: TextInputType.number,
            controller: controller.mobileNumber.value,
            validator: (value) {
              if (value!.isEmpty) {
                return "Mobile number cannot be empty";
              }
            },
            suffixWidget: Obx(() => controller.homePageController
                        .allUserProfileData.value?.data.changeStatus ==
                    0
                ? TextButton(
                    onPressed: () {
                      if (controller.mobileNumber.value.text.isNotEmpty) {
                        controller
                            .verifyEmailAndNumber(type: "mobile")
                            .then((value) {
                          if (value == true) {
                            ShowBox().otpVerify(
                                showCancelButton: true,
                                text: "Verify Your Otp",
                                onButtonClick: () {
                                  if (controller.otp.value.text.isNotEmpty) {
                                    var response =
                                        controller.otpVerifyEmailAndNumber(
                                            type: "mobile");
                                    if (response != null) {
                                      Future.delayed(Duration(seconds: 0), () {
                                        Get.back();
                                      });
                                    }
                                  } else {
                                    AppUtility.showErrorSnackBar(
                                        "Enter OTP  First");
                                  }
                                },
                                buttonText: "Verify");
                          }
                        });
                      } else {
                        AppUtility.showErrorSnackBar(
                            "Enter Mobile Number First");
                      }
                    },
                    child: AppText(
                      text: "Verify",
                      fontSize: 14,
                    ))
                : Icon(
                    Icons.verified,
                    color: AppColor().highLightColor,
                    size: 15,
                  )),
            textBackgroundColor: Colors.white.withOpacity(0.3),

            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder:
                "${controller.homePageController.allUserProfileData.value?.data.mobile}",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            //controller: controller.suggestionController,
          ),
          height10,*/
          height10,
          AppText(
            text: "Email ",
            fontSize: 15,
          ),
          height10,
          AppInputContainer(
            enableEdit: controller.homePageController.allUserProfileData.value
                        ?.data.changeStatus ==
                    0
                ? true
                : false,
            controller: controller.email.value,
            validator: (value) {
              if (value!.isEmpty) {
                return "Email cannot be empty";
              }
            },
            suffixWidget: Obx(() => controller.homePageController
                        .allUserProfileData.value?.data.changeStatus ==
                    0
                ? TextButton(
                    onPressed: () {
                      if (controller.email.value.text.isNotEmpty) {
                        controller
                            .verifyEmailAndNumber(type: "email")
                            .then((value) {
                          if (value == true) {
                            ShowBox().emailVerify(
                                showCancelButton: true,
                                text: "Verify Your Email",
                                onButtonClick: () {
                                  if (controller.otp.value.text.isNotEmpty) {
                                    var response = controller
                                        .otpVerifyEmailAndNumber(type: "email");
                                    if (response != null) {
                                      Future.delayed(Duration(seconds: 0), () {
                                        Get.back();
                                      });
                                    }
                                  } else {
                                    AppUtility.showErrorSnackBar(
                                        "Enter OTP  First");
                                  }
                                },
                                buttonText: "Verify");
                          }
                        });
                      } else {
                        AppUtility.showErrorSnackBar("Enter Your Email First");
                      }
                    },
                    child: AppText(
                      text: "Verify",
                      fontSize: 14,
                    ))
                : Icon(
                    Icons.verified,
                    color: AppColor().highLightColor,
                    size: 15,
                  )),
            textBackgroundColor: Colors.white.withOpacity(0.3),

            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder:
                "${controller.homePageController.allUserProfileData.value?.data.email}",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            //controller: controller.suggestionController,
          ),
          height10,
          height10,
          const AppText(
            text: "GDX Address ",
            fontSize: 15,
          ),
          height10,
          AppInputContainer(
            enableEdit: controller.homePageController.allUserProfileData.value!
                        .data.changeStatus ==
                    0
                ? true
                : false,
            controller: controller.gdxAddress.value,
            suffixWidget: Obx(() => controller.homePageController
                        .allUserProfileData.value!.data.changeStatus ==
                    0
                ? const SizedBox()
                : Icon(
                    Icons.verified,
                    color: AppColor().highLightColor,
                    size: 15,
                  )),
            validator: (value) {
              if (value!.isEmpty) {
                return "GDX address cannot be empty";
              }
            },
            textBackgroundColor: Colors.white.withOpacity(0.3),

            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder:
                "${controller.homePageController.allUserProfileData.value?.data.address}",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            //controller: controller.suggestionController,
          ),
        ],
      ),
    );
  }
}
