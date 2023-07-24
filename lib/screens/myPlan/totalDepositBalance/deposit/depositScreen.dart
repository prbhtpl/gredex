import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';
import 'package:gredex/getXController/qrController/qrController.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Utility/app_toolbar.dart';
import '../../../../commonWidget/appColors.dart';
import '../../../../commonWidget/appText.dart';
import '../withdrawal/withdrawal.dart';

class DepositScreen extends StatefulWidget {
  DepositScreen({Key, this.showGDXString,this.balance,this.qrCodeString, key}) : super(key: key);
  final String? showGDXString;
  final String? balance;
  final String? qrCodeString;


  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  GlobalKey previewContainer = new GlobalKey();
  bool buttonColor = false;
  int originalSize = 800;

  Future<void> _launchUrl({String url = ""}) async {
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Image? _image;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QRController>(
      init: QRController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Deposit",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppPageLoader(
                isLoading: controller.loaderStatus.value,
                child: Column(
                  children: [
                    RepaintBoundary(
                      key: previewContainer,
                      child: Column(
                        children: [
                          CustomPaint(
                            painter: QrPainter(
                              color: Colors.white,
                              data:widget.qrCodeString!,
                              version: QrVersions.auto,

                            ) ,
                          )
                         ,
                          height10,
                          const AppText(
                            text: "Send only BEP-20 to this deposit address",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          height10,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Network",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const AppText(
                                    text: "BNB Smart Chain",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: detailBox(
                                      title: "Go to Explorer",
                                      onClick: () {
                                        _launchUrl(
                                            url:
                                                "https://bscscan.com/address/${widget.qrCodeString}");
                                      }))
                            ],
                          ),
                          height10,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              AppText(
                                text: "Wallet Address",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: AppText(
                                  text: widget.qrCodeString,
                                  fontSize: 12,
                                  textColor: AppColor().green,
                                )),
                                IconButton(
                                    onPressed: () {
                                      ShowBox().copyClipBoard(
                                        text: widget.qrCodeString!,);
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
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
                                  text: "${widget.showGDXString} Balance",
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
                                  text: "${widget.balance} ${widget.showGDXString}",
                                  fontSize: 12,
                                  textColor: AppColor().highLightColor,
                                  fontWeight: FontWeight.w400,
                                ),


                              ],
                            ),
                          ],
                        )),
                    height10,
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 0),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppText(
                        text:
                            "Please maintain a gas fee of minimum 0.007 BNB,\n otherwise transaction may be fail or revert.",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textColor: AppColor().red,
                      ),
                    ),
                    height10,
                    height10,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                buttonColor = false;
                              });

                              /* ShareFilesAndScreenshotWidgets()
                                  .takeScreenshot(previewContainer, originalSize)
                                  .then((Image value) {
                                setState(() {
                                  _image = value;
                                });
                              } as FutureOr Function(Image? value));*/
                              // ShareFilesAndScreenshotWidgets().shareScreenshot(previewContainer,
                              //     originalSize, "Title", "Name.png", "image/png",
                              //     text: "Welcome to Gridx Ecosystem");
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // Creates border
                                  color: buttonColor
                                      ? AppColor().greyText
                                      : AppColor().oldThemeColors),
                              child: AppText(
                                text: "Deposit",
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                buttonColor = true;
                              });
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(seconds: 1),
                                      type: PageTransitionType.fade,
                                      child: Withdrawal(balance:widget.balance ,
                                        showGDXString: widget.showGDXString,
                                      )));
                              /*     ShareFilesAndScreenshotWidgets().shareScreenshot(
                                  previewContainer,
                                  originalSize,
                                  "Title",
                                  "Name.png",
                                  "image/png",
                                  text: "Welcome to Gridx Ecosystem");*/
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  // Creates border
                                  color: buttonColor
                                      ? AppColor().oldThemeColors
                                      : AppColor().greyText),
                              child: AppText(
                                text: "Withdrawal",
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    height10,
                    height10,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget detailBox({String title = '', GestureTapCallback? onClick}) {
    return InkWell(
      onTap: onClick,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor().secondPrimaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AppText(
                  text: title,
                  fontSize: 13,
                ),
              ),
              Icon(
                CupertinoIcons.forward,
                color: Colors.white70,
              ),

              // Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     decoration: BoxDecoration(
              //         color: AppColor().oldThemeColors,
              //         borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(10),
              //           bottomRight: Radius.circular(10),
              //         )),
              //     child: Icon(bottomIcon!??Icons.wallet,size: 20,)
              // ),
            ],
          )),
    );
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
