import 'package:flutter/material.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';

class GDXBalance extends StatelessWidget {
  const GDXBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().primaryColor,
      appBar: AppToolbar(
        onPressBackButton: () {
          Navigator.pop(context);
        },
        appColor: Colors.transparent,
        enableBackArrow: true,
        title: "GDX Balance",
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:  AppColor().secondPrimaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),

                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(flex:2,child: AppText(text: "Description",textColor: AppColor().greyText,fontWeight: FontWeight.bold,fontSize: 15,)),
                      VerticalDivider(color: Colors.white70, width: 1),
                      Expanded(child: AppText(text: "Debit",textColor: AppColor().greyText,fontWeight: FontWeight.bold,fontSize: 15,)),
                      VerticalDivider(color: Colors.white70, width: 1),
                      Expanded(child: AppText(text: "Credit",textColor: AppColor().greyText,fontWeight: FontWeight.bold,fontSize: 15,)),
                    ],
                  ),
                ),
              ),
              height10,
              Container(padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:  AppColor().secondPrimaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),

                child: ListView.builder(itemCount: 13,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(flex:2,child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(text: "GDX Reward",textColor: Colors.white70,fontWeight: FontWeight.bold,fontSize: 13,),
                                height10,
                                AppText(text: "12:40 PM, 20 Mar, 2024",textColor: Colors.grey,fontWeight: FontWeight.bold,fontSize: 12,),
                              ],
                            )),
                            VerticalDivider(color: Colors.white70, width: 1),
                            Expanded(child: Column(
                              children: [
                                AppText(text: "4000",textColor: AppColor().red,fontWeight: FontWeight.bold,fontSize: 15,),
                                SizedBox(height: 2,),
                                AppText(text: "Total Balance",textColor:Colors.white70,fontWeight: FontWeight.bold,fontSize: 10,),
                              ],
                            )),
                            VerticalDivider(color: Colors.white70, width: 1),
                            Expanded(child: Column(
                              children: [
                                AppText(text: "$index,000",textColor: AppColor().green,fontWeight: FontWeight.bold,fontSize: 15,),
                                SizedBox(height: 2,),
                                AppText(text: " 4000",textColor:Colors.white70,fontWeight: FontWeight.bold,fontSize: 10,),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white70, )
                    ],
                  );
                },),
              ),


            ],
          ),
        ),
      ),
    );
  }



  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
