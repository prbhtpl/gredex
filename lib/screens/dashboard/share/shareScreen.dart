import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gredex/commonWidget/appText.dart';
import 'package:gredex/commonWidget/commonDecoration.dart';
import 'package:gredex/commonWidget/customButton.dart';
import 'package:gredex/commonWidget/showDialoueBox.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';

class ShareScreen extends StatefulWidget {
  ShareScreen({this.userId, Key? key}) : super(key: key);
  final String? userId;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  share({required BuildContext context, required String text}) async {
    ByteData imagebyte = await rootBundle
        .load('assets/gdx.png');
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image1.jpg';
    File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
    await Share.shareFiles([path], text: 'Image Shared');
    final box = context.findRenderObject() as RenderBox?;
    await Share.shareFiles(['${path}'],text:  text,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
 );
  }

  String _linkMessage='';
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
  }

  String kUriPrefix = 'https://gridxecosys.page.link';

  Future<void> _createDynamicLink(bool short, String link) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: kUriPrefix,
      link: Uri.parse(kUriPrefix + link),
      androidParameters: const AndroidParameters(
        packageName: 'com.gridx.ecosystem',
        minimumVersion: 0,
      ),
    );

    Uri url;

    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbar(
        onPressBackButton: () {
          Navigator.pop(context);
        },
        enableBackArrow: true,
        title: "Share & Earn",
        appColor: Colors.transparent,
      ),
      backgroundColor: AppColor().primaryColor,
      body: Column(
        children: [
          Image.asset("assets/shareAndEarn.png"),
          SizedBox(height: 5,),
          _linkMessage!="" ? Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Expanded(
                    child: AppText(
                  text:  _linkMessage,
                  fontSize: 10,
                )),
                IconButton(
                    onPressed: () {
                      ShowBox().copyClipBoard(
                          text:
                          _linkMessage);
                      SnackBar(content: Text('Copied Link! $_linkMessage'));
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 20,
                    )),
                IconButton(
                    onPressed: () {
                 share(context: context, text: "Welcome to Gridx ${_linkMessage}",);

                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 20,
                    )),


              ],
            ),
          ):SizedBox(),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: SizedBox(
                    height: 25,
                    child: CustomButton(
                      buttonText: "Left",
                      onClickButton: !_isCreatingLink
                          ? () => _createDynamicLink(true,
                              '/productpage?id=${widget.userId}&position=Left')
                          : null,
                    )),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: SizedBox(
                    height: 25,
                    child: CustomButton(
                      buttonText: "Right",
                      onClickButton: !_isCreatingLink
                          ? () => _createDynamicLink(true,
                              '/productpage?id=${widget.userId}&position=Right')
                          : null,
                    )),
              )),
            ],
          ),
         /* InkWell(
            onTap: () async {
              print(_linkMessage);
              //await launchUrl(Uri.parse(_linkMessage!));
            },
            child: Text(
              _linkMessage ?? '',
              style: const TextStyle(color: Colors.blue),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget get width10 => const SizedBox(
        width: 10,
      );

  Widget get height10 => const SizedBox(
        height: 10,
      );
}
