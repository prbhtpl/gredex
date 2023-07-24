import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/appColors.dart';
import 'package:gredex/getXController/updateProfileController/updateProfileController.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class ShowBox {
  showBox(
      {required String text,
      required GestureTapCallback? onButtonClick,
      required String titleContent,
      required String buttonText,
      bool showCancelButton = false}) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Text(text),
            content: Text(titleContent),
            actions: [
              showCancelButton
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"))
                  : SizedBox(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().primaryColor),
                  onPressed: onButtonClick,
                  child: Text(buttonText))
            ],
          );
        });
  }

  copyClipBoard({String text = ""}) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      AppUtility.showSuccessSnackBar("Copied to clipboard $text");
    });
  }

  otpVerify(
      {required String text,
      required GestureTapCallback? onButtonClick,
      required String buttonText,
      bool showCancelButton = false}) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          UpdateProfileController updateProfileController =
              Get.put(UpdateProfileController());
          return AlertDialog(
            backgroundColor: AppColor().oldThemeColors,
            title: Text(text),
            content: OtpTextField(
                textStyle: const TextStyle(color: Colors.white),
                obscureText: true,
                borderRadius: BorderRadius.circular(10),
                keyboardType: TextInputType.number,
                numberOfFields: 4,
                borderColor: AppColor().green,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  /* controller.otp.value=code;*/
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  updateProfileController.otp.value.text = verificationCode;
                  print("OTP Number Verify" +
                      updateProfileController.otp.value.text);

                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //       );
                  //     });
                }),
            actions: [
              showCancelButton
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"))
                  : SizedBox(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().primaryColor),
                  onPressed: onButtonClick,
                  child: Text(buttonText))
            ],
          );
        });
  }

  emailVerify(
      {required String text,
      required GestureTapCallback? onButtonClick,
      required String buttonText,
      bool showCancelButton = false}) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          UpdateProfileController updateProfileController =
              Get.put(UpdateProfileController());

          return AlertDialog(
            backgroundColor: AppColor().oldThemeColors,
            title: Text(text),
            content: OtpTextField(
                textStyle: const TextStyle(color: Colors.white),
                obscureText: true,
                borderRadius: BorderRadius.circular(10),
                keyboardType: TextInputType.number,
                numberOfFields: 4,
                borderColor: AppColor().green,
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  /* controller.otp.value=code;*/
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  updateProfileController.otp.value.text = verificationCode;
                  print("OTP emailVerify" +
                      updateProfileController.otp.value.text);
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return AlertDialog(
                  //         title: Text("Verification Code"),
                  //         content: Text('Code entered is $verificationCode'),
                  //       );
                  //     });
                }),
            actions: [
              showCancelButton
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"))
                  : SizedBox(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().primaryColor),
                  onPressed: onButtonClick,
                  child: Text(buttonText))
            ],
          );
        });
  }

  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  congratulationDialogueBoxActivation(
      {required String title,
        required String userId,
        required String name,
        required Widget imageWidget,
        required String password,
        required GestureTapCallback onButtonClick,
        required String buttonText,
        bool showCancelButton = false,
        required BuildContext context}) {
    Dialogs.materialDialog(
      // titleStyle: TextStyle(
      //     color: AppColor().primaryColor, fontWeight: FontWeight.bold),
        color: Color(0xff2E1149),
        //   msg: content,
        msgAlign: TextAlign.center,
        // title: title,
        // lottieBuilder: Lottie.asset(
        //   'assets/cong_example.json',
        //   fit: BoxFit.contain,
        // ),

        customView: RepaintBoundary(
          key: previewContainer,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Stack(
              children: [
                imageWidget,

                Positioned(
                  bottom: 50,
                  right: 0,left: 0,
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "--------------------------------------",
                          style: TextStyle(color: Colors.black),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "$userId",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              password,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                        const Text(
                          "--------------------------------------",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: onButtonClick,
            text: buttonText,
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              ShareFilesAndScreenshotWidgets().shareScreenshot(previewContainer,
                  originalSize, "Title", "Name.png", "image/png",
                  text: "Welcome to Gridx Ecosystem");
            },
            text: "Share",
            iconData: Icons.share,
            color: AppColor().green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
  congratulationDialogueBox(
      {required String title,
      required String userId,
      required String name,
        required Widget imageWidget,
      required String password,
      required GestureTapCallback onButtonClick,
      required String buttonText,
      bool showCancelButton = false,
      required BuildContext context}) {
    Dialogs.materialDialog(
        // titleStyle: TextStyle(
        //     color: AppColor().primaryColor, fontWeight: FontWeight.bold),
        color: Color(0xff2E1149),
        //   msg: content,
        msgAlign: TextAlign.center,
        // title: title,
        // lottieBuilder: Lottie.asset(
        //   'assets/cong_example.json',
        //   fit: BoxFit.contain,
        // ),

        customView: RepaintBoundary(
          key: previewContainer,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Stack(
              children: [
                imageWidget,

                Positioned(
                  bottom: Get.height / 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width / 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "--------------------------------------",
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "User-Id: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Name: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Password: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$userId",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  password,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Text(
                          "--------------------------------------",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: onButtonClick,
            text: buttonText,
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              ShareFilesAndScreenshotWidgets().shareScreenshot(previewContainer,
                  originalSize, "Title", "Name.png", "image/png",
                  text: "Welcome to Gridx Ecosystem");
            },
            text: "Share",
            iconData: Icons.share,
            color: AppColor().green,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  warningMessage(
      {required String title,
      required String userId,
      required String name,
      required String password,
      required GestureTapCallback onButtonClick,
      required String buttonText,
      bool showCancelButton = false,
      required BuildContext context}) {
    Dialogs.materialDialog(
        barrierDismissible: false,
        // titleStyle: TextStyle(
        //     color: AppColor().primaryColor, fontWeight: FontWeight.bold),
        color: AppColor().primaryColor,
        //   msg: content,
        msgAlign: TextAlign.center,
        // title: title,
        // lottieBuilder: Lottie.asset(
        //   'assets/cong_example.json',
        //   fit: BoxFit.contain,
        // ),

        customView: RepaintBoundary(
          key: previewContainer,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor().primaryColor),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                    child: Row(
                      children: [
                        Text(
                          "$userId",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.warning_amber,
                          color: Colors.yellow,
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "-------------------------------------------------",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        password,
                        style: TextStyle(fontSize: 12, color: Colors.red),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const Text(
                    "-------------------------------------------------",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: onButtonClick,
            text: buttonText,
            iconData: Icons.done,
            color: Colors.blue,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  withdrawalWarning(
      {required String wholeData,
      required GestureTapCallback onButtonClick,
      required String buttonText,
      required BuildContext context}) {
    Dialogs.materialDialog(
        barrierDismissible: false,
        // titleStyle: TextStyle(
        //     color: AppColor().primaryColor, fontWeight: FontWeight.bold),
        color: AppColor().primaryColor,
        //   msg: content,
        msgAlign: TextAlign.center,
        // title: title,
        // lottieBuilder: Lottie.asset(
        //   'assets/cong_example.json',
        //   fit: BoxFit.contain,
        // ),

        customView: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor().primaryColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.red),
                //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                //   child: Row(
                //     children: [
                //       Text(
                //         "$userId",
                //         style: TextStyle(
                //           fontSize: 18,fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //         ),
                //
                //       ), SizedBox(width: 10,), Icon(Icons.warning_amber,color: Colors.yellow,)
                //     ],
                //   ),
                // ),

                Text(
                  wholeData,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        customViewPosition: CustomViewPosition.BEFORE_ACTION,
        context: context,
        actions: [
          IconsButton(
            onPressed: onButtonClick,
            text: buttonText,
            iconData: Icons.done,
            color: Colors.green.shade400,
            textStyle: TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }
}
