import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gredex/commonWidget/appColors.dart';
import 'package:gredex/model/GDXLiveRateModel/GDXLiveRateModel.dart';
import 'package:gredex/model/profileModel/profileModel.dart';
import 'package:page_transition/page_transition.dart';

import '../../../commonWidget/appText.dart';
import '../../../commonWidget/commonDecoration.dart';
import '../../../commonWidget/commonTextStyle.dart';
import '../../../model/qrCodeModel/qrCodeModel.dart';
import '../../myPlan/totalDepositBalance/deposit/depositScreen.dart';
import '../../myPlan/totalDepositBalance/totalDepositBalance.dart';

class TokenGrowthTile extends StatelessWidget {
  const TokenGrowthTile(
      {Key? key,
        required this.bnbToDollar,
      required this.profileValue,
      required this.qrModel,
      required this.gdxLiveRateModel})
      : super(key: key);
final double bnbToDollar;
  final QrModel qrModel;
  final ProfileModel profileValue;
  final GdxLiveRateModel gdxLiveRateModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(seconds: 1),
                    type: PageTransitionType.fade,
                    child: DepositScreen(
                      balance: '${qrModel.data.balance.toStringAsFixed(2)}',
                      qrCodeString: qrModel.data.publicAddress,
                      showGDXString: "GDX",
                    )));
            /* Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: TotalDepositBalance(
                      showGDXString: "GDX",
                      amount: "${qrModel.data.balance.toStringAsFixed(2)}",
                      name: "GDX",
                    )));*/
          },
          child: Container(
            // transction01Lvk (0:3468)
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.fromLTRB(15, 16, 17.16, 16),

            height: 82,
            decoration: BoxDecoration(
              color: Color(0xff2b2b44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      // image3EFS (0:3476)
                      margin: EdgeInsets.fromLTRB(0, 0, 14.63, 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          /*  index.isEven?*/
                          'assets/gdx.png' /*:'assets/code.png'*/,
                          repeat: ImageRepeat.repeat,
                          scale: 1,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: /*index.isEven?*/ 'GDX' /*:'Alex'*/,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text:
                              "\$ ${gdxLiveRateModel != null ? gdxLiveRateModel.data.rate.toStringAsFixed(2) : "0.0" ?? 0.0} ",
                          fontSize: 12,
                          textColor: AppColor().greyText,
                        ),
                        /*  AppText(
                          text: '  ',
                          textColor: AppColor().greyText,
                          fontSize: 13,
                        ),*/
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      fontSize: 16,
                      text: /*index.isEven?*/
                          '${qrModel.data.balance.toStringAsFixed(2)}' /*:'+340'*/,
                      textColor: qrModel.data.balance != 0
                          ? Colors.green
                          : AppColor().red,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text:
                          "\$ ${gdxLiveRateModel != null ? (qrModel.data.balance * gdxLiveRateModel.data.rate).toStringAsFixed(2) : "0.0" ?? 0.0} ",
                      fontSize: 12,
                      textColor: AppColor().greyText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(seconds: 1),
                    type: PageTransitionType.fade,
                    child: DepositScreen(
                      showGDXString: "BNB",
                      qrCodeString: "${qrModel.data.publicAddress}",
                      balance: '${qrModel.data.bnbToken.toStringAsFixed(4)}',
                    )));
            /* Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: TotalDepositBalance(
                      showGDXString: "BNB",
                      amount: "${qrModel.data.bnbToken.toStringAsFixed(4)}",
                      name: "BNB",
                    )));*/
          },
          child: Container(
            // transction01Lvk (0:3468)
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.fromLTRB(15, 16, 17.16, 16),

            height: 82,
            decoration: BoxDecoration(
              color: Color(0xff2b2b44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      // image3EFS (0:3476)
                      margin: EdgeInsets.fromLTRB(0, 0, 14.63, 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          /*  index.isEven?*/
                          'assets/bnb.png' /*:'assets/code.png'*/,
                          repeat: ImageRepeat.repeat,
                          scale: 1,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: /*index.isEven?*/ 'BNB' /*:'Alex'*/,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text:
                        "\$ ${bnbToDollar != null ? bnbToDollar.toStringAsFixed(2) : "0.0" ?? 0.0} ",
                          fontSize: 12,
                          textColor: AppColor().greyText,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      fontSize: 16,
                      text: /*index.isEven?*/
                          '${qrModel.data.bnbToken.toStringAsFixed(4)}' /*:'+340'*/,
                      textColor: qrModel.data.bnbToken != 0
                          ? Colors.green
                          : AppColor().red,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText(
                      text:
                      "\$ ${bnbToDollar != null ? (bnbToDollar*qrModel.data.bnbToken).toStringAsFixed(2) : "0.0" ?? 0.0} ",
                      fontSize: 12,
                      textColor: AppColor().greyText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        /* InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: TotalDepositBalance(
                      showGDXString: "BUSD",
                      amount: "00.00",
                      name: "BUSD",
                    )));
          },
          child: Container(
            // transction01Lvk (0:3468)
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.fromLTRB(15, 16, 17.16, 16),

            height: 82,
            decoration: BoxDecoration(
              color: Color(0xff2b2b44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      // image3EFS (0:3476)
                      margin: EdgeInsets.fromLTRB(0, 0, 14.63, 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          */ /*  index.isEven?*/ /*
                          'assets/busd.png' */ /*:'assets/code.png'*/ /*,
                          repeat: ImageRepeat.repeat,
                          scale: 1,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: */ /*index.isEven?*/ /* 'BUSD' */ /*:'Alex'*/ /*,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: '  ',
                          textColor: AppColor().greyText,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      fontSize: 16,
                      text: */ /*index.isEven?*/ /* ' 0.00' */ /*:'+340'*/ /*,
                      textColor: AppColor().red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),*/
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(seconds: 1),
                    type: PageTransitionType.fade,
                    child: DepositScreen(
                      showGDXString: "Shiba",
                      qrCodeString: "${qrModel.data.publicAddress}",
                      balance: '${profileValue.data.shibawallet}',
                    )));
            /* Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: TotalDepositBalance(
                      showGDXString: "Shiba",
                      amount: "${profileValue.data.shibawallet}",
                      name: "Shiba",
                    )));*/
          },
          child: Container(
            // transction01Lvk (0:3468)
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.fromLTRB(15, 16, 17.16, 16),

            height: 82,
            decoration: BoxDecoration(
              color: Color(0xff2b2b44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      // image3EFS (0:3476)
                      margin: EdgeInsets.fromLTRB(0, 0, 14.63, 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          /*  index.isEven?*/
                          'assets/shiba2.png' /*:'assets/code.png'*/,
                          repeat: ImageRepeat.repeat,
                          scale: 1,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: /*index.isEven?*/ 'SHIBA' /*:'Alex'*/,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: '  ',
                          textColor: AppColor().greyText,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      fontSize: 16,
                      text: /*index.isEven?*/
                          '${profileValue.data.shibawallet}' /*:'+340'*/,
                      textColor: profileValue.data.shibawallet != 0
                          ? Colors.green
                          : AppColor().red,
                    ),
                    /* Image.asset(
                      */ /*  index.isEven?*/ /*
                      'assets/design/arrow-graph-down-right-zN4.png' */ /*:'assets/design/arrow-graph-up-right-SKA.png'*/ /*,
                      width: 31.5,
                      height: 18,
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(seconds: 1),
                    type: PageTransitionType.fade,
                    child: DepositScreen(
                      balance: '${profileValue.data.babydogewallet}',
                      qrCodeString: qrModel.data.publicAddress,
                      showGDXString: "Baby Doge",
                    )));
            /* Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: TotalDepositBalance(
                      showGDXString: "Baby Doge",
                      amount: "${profileValue.data.babydogewallet}",
                      name: "Baby Doge",
                    )));*/
          },
          child: Container(
            // transction01Lvk (0:3468)
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.fromLTRB(15, 16, 17.16, 16),

            height: 82,
            decoration: BoxDecoration(
              color: Color(0xff2b2b44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      // image3EFS (0:3476)
                      margin: EdgeInsets.fromLTRB(0, 0, 14.63, 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          /*  index.isEven?*/
                          'assets/babyDodge.png' /*:'assets/code.png'*/,
                          repeat: ImageRepeat.repeat,
                          scale: 1,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: /*index.isEven?*/ 'BABY DOGE' /*:'Alex'*/,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: '  ',
                          textColor: AppColor().greyText,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      fontSize: 16,
                      text: /*index.isEven?*/
                          '${profileValue.data.babydogewallet}' /*:'+340'*/,
                      textColor: profileValue.data.babydogewallet != 0
                          ? Colors.green
                          : AppColor().themeColors,
                    ),
                    /* Image.asset(
                      */ /*  index.isEven?*/ /*
                      'assets/design/arrow-graph-down-right-zN4.png' */ /*:'assets/design/arrow-graph-up-right-SKA.png'*/ /*,
                      width: 31.5,
                      height: 18,
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
        /*   InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: TotalDepositBalance(
                      showGDXString: "LPP",
                      amount: "0.00",
                      name: "LPP",
                    )));
          },
          child: Container(
            // transction01Lvk (0:3468)
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            padding: EdgeInsets.fromLTRB(15, 16, 17.16, 16),

            height: 82,
            decoration: BoxDecoration(
              color: Color(0xff2b2b44),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      // image3EFS (0:3476)
                      margin: EdgeInsets.fromLTRB(0, 0, 14.63, 0),
                      width: 50,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          */ /*  index.isEven?*/ /*
                          'assets/web.png' */ /*:'assets/code.png'*/ /*,
                          repeat: ImageRepeat.repeat,
                          scale: 1,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: */ /*index.isEven?*/ /* 'LPP' */ /*:'Alex'*/ /*,
                          fontSize: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AppText(
                          text: '  ',
                          textColor: AppColor().greyText,
                          fontSize: 13,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      fontSize: 16,
                      text: */ /*index.isEven?*/ /* ' 0.00' */ /*:'+340'*/ /*,
                      textColor: */ /*index.isEven?*/ /*
                          Colors.redAccent */ /*:AppColor().themeColors*/ /*,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),*/
        SizedBox(
          height: 40,
        )

        /* ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              // transction01Lvk (0:3468)
              margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
              padding: EdgeInsets.fromLTRB(15   , 16   , 17.16   , 16   ),

              height: 82   ,
              decoration: BoxDecoration (
                color: Color(0xff2b2b44),
                borderRadius: BorderRadius.circular(10   ),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [

                    Container(
                    // image3EFS (0:3476)
                    margin: EdgeInsets.fromLTRB(0   , 0   , 14.63   , 0   ),
                    width: 50   ,
                    height: 50   ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        index.isEven?'assets/web.png':'assets/code.png',
                        repeat: ImageRepeat.repeat,
                        scale: 1,
                      ),
                    ),
                  ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                         text: index.isEven?'James Roy':'Alex',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10,),
                        AppText(
                          text: '  ',
                          textColor: AppColor().greyText,
                          fontSize: 13   ,

                        ),
                      ],
                    ),],),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(fontSize: 16,
                        text:  index.isEven?' 0.00':'+340',
                        textColor: index.isEven?Colors.redAccent:AppColor().themeColors,
                      ),

             Image.asset(
                          index.isEven?'assets/design/arrow-graph-down-right-zN4.png':'assets/design/arrow-graph-up-right-SKA.png',
                          width: 31.5   ,
                          height: 18   ,
                        ),

                    ],
                  ),
                ],
              ),
            );
          },
        )*/
      ],
    );
  }
}
