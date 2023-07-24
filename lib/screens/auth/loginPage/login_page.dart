import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gredex/Utility/app_routes.dart';
import 'package:gredex/commonWidget/appColors.dart';

import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/commonWidget/noPageFound.dart';
import 'package:gredex/screens/auth/otpVerification/otpVerificationScreen.dart';

import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:video_player/video_player.dart';

import '../../../commonWidget/app_input_container.dart';

import '../../../getXController/loginController/loginController.dart';
import '../register/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    _controller = VideoPlayerController.asset(
      'assets/hero-video.mp4',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      setState(() {});
    });
 // _controller.setLooping(true);
 //  Future.delayed(Duration(seconds: 2),(){  _controller.play();});
  }

  bool forgetPassword = true;
  late VideoPlayerController _controller;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> initDynamicLinks() async {
    print("dynamicLinkData.link.path 123");
    dynamicLinks.onLink.listen((dynamicLinkData) {
      final Uri uri = dynamicLinkData.link;
      final queryParams = uri.queryParameters;
      if (queryParams.isNotEmpty) {
        print("queryParams id ${queryParams["id"]} queryParams position ${queryParams["position"]}");
        String productId = queryParams["id"]??"";
        String position = queryParams["position"]??"";

        Navigator.push(context, PageTransition(duration: Duration(seconds: 1),type: PageTransitionType.fade, child: RegisterPage(
                      sponserId: productId,
                      position: position,
                    )));
        // print( "dynamicLinkData.link.path"+dynamicLinkData.link.path);

        // Navigator.pushNamed(context, dynamicLinkData.link.path,
        //     arguments: {"productId": int.parse(productId!),
        //     "position":position});
      } else {
        Navigator.push(context, PageTransition(duration: Duration(seconds: 1),type: PageTransitionType.fade, child:const NoPageFound()));
      }
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  // Future<void> initDynamicLinks() async {
  //   print("dynamicLinkData.link.path   dddddd");
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     final Uri uri = dynamicLinkData.link;
  //     final queryParams = uri.queryParameters;
  //     if (queryParams.isNotEmpty) {
  //       String? productId = queryParams["id"];
  //       print("dynamicLinkData.link.path" + dynamicLinkData.link.path);
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => RegisterPage(
  //                     sponserId: int.parse(productId!),
  //                   )));
  //       /*   Navigator.pushNamed(context, dynamicLinkData.link.path,
  //           arguments: {"productId": int.parse(productId!)});*/
  //     } else {
  //       Navigator.pushNamed(
  //         context,
  //         dynamicLinkData.link.path,
  //       );
  //     }
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    loginFromKey.currentState!.dispose();
    super.dispose();
  }

  var loginFromKey = GlobalKey<FormState>();
  var forgetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return exit(0);
        },
        child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: AppPageLoader(
                    isLoading: controller.loaderStatus.value,
                    child: Stack(
                      children: [
                        _controller.value.isInitialized
                            ? SingleChildScrollView(
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 8,
                                    child: VideoPlayer(_controller),
                                  ),
                                ),
                              )
                            : Container(),
                        SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: Get.height / 5.5,
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
                                    height: 20,
                                  ),
                                  AppText(
                                      text: forgetPassword
                                          ? "Login Account"
                                          : "Forget Password",
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 30, 20, 33.5),
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xff2b2b44).withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          forgetPassword
                                              ? login(controller)
                                              : forgetPasswordWidget(controller),

                                          AppText(onTap:(){
                                            launchUrl(Uri.parse("https://gridxecosystem.com/privacy-policy.html"));
                                          },text: "Terms & Conditions",fontSize: 12,textColor: Colors.blue,underline: true,)
                                        ],
                                      )
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ));
            }));
  }
bool obSecure=true;
  Widget login(LoginController controller) {
    return Form(
      //    autovalidateMode: AutovalidateMode.onUserInteraction,
      key: loginFromKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInputContainer(
            inputType: TextInputType.number,
            onClick: () {},
            prefixWidget: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                width: 70,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
            textBackgroundColor: Colors.white.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder: "Enter Your User-ID",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            controller: controller.userId.value,
          ),
          const SizedBox(
            height: 20,
          ),
          AppInputContainer(
            suffixWidget: IconButton(icon: Icon(obSecure?Icons.remove_red_eye:FontAwesomeIcons.eyeSlash,color: Colors.white70,size: 15,),
              onPressed: (){
                setState(() {
                  obSecure=!obSecure;
                });

              },
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Password cannot be empty";
              }
              return null;
            },
            prefixWidget: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            obSecure: obSecure,
            textBackgroundColor: Colors.white.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder: "Password",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            controller: controller.password.value,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: Get.width,
            child: AppText(
              underline: true,
              text: "Forget Password?",
              textAlign: TextAlign.right,
              fontWeight: FontWeight.bold,
              textColor: AppColor().textOrange,
              fontSize: 15,
              onTap: () {
                setState(() {
                  forgetPassword = !forgetPassword;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            buttonText: "Sign In",
            onClickButton: () {
              if (loginFromKey.currentState!.validate()) {
                controller.captchaDialogueBox();
              } else {}

              //Get.toNamed( AppRoutes.dashboardPage);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppText(
                text: "Don't have an account? ",
                fontSize: 15,
              ),
              Expanded(
                child: AppText(
                  onTap: () {
                    Get.toNamed(AppRoutes.registerPage);
                  },
                  underline: true,
                  text: "Register New",
                  fontSize: 15,
                  textColor: Colors.lightBlue,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget forgetPasswordWidget(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 40,
        ),
        Form(
          key: forgetFormKey,
          child: AppInputContainer(
            controller: controller.userId.value,
            inputType: TextInputType.number,
            onClick: () {},
            validator: (value) {
              if (value!.isEmpty) {
                return "User-Id cannot be empty";
              }
              return null;
            },
            prefixWidget: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                width: 70,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(
                      width: 10,
                    ),
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
            textBackgroundColor: Colors.white.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder: "Enter Your Id",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
          buttonText: "Submit",
          onClickButton: () {
            if (forgetFormKey.currentState!.validate()) {
              controller.forgetPassword();
            }

            //  Get.toNamed(AppRoutes.dashboardPage);
          },
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppText(
              text: "Have an account? ",
              fontSize: 15,
            ),
            AppText(
              underline: true,
              onTap: () {
                setState(() {
                  forgetPassword = !forgetPassword;
                });
              },
              text: "Login",
              fontSize: 15,
              textColor: Colors.lightBlue,
            )
          ],
        )
      ],
    );
  }
}
