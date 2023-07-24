import 'package:flutter/material.dart';
import 'package:gredex/commonWidget/noData.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';

class LevelReward extends StatefulWidget {
  const LevelReward({Key? key}) : super(key: key);

  @override
  State<LevelReward> createState() => _LevelRewardState();
}

class _LevelRewardState extends State<LevelReward> with SingleTickerProviderStateMixin{
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor().primaryColor,
      appBar: AppToolbar(
        onPressBackButton: () {
          Navigator.pop(context);
        },
        appColor: Colors.transparent,
        enableBackArrow: true,
        title: "Level History",
      ),
      body:  Padding(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            filterWidget(),height10,
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        itemWidget(),
                      ],
                    ),
                  )  ,  /*   SingleChildScrollView(
                    child: NoData(),
                  ),
*/
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  ListView itemWidget() {
    return ListView.builder(
      itemCount: 13,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: AppColor().secondPrimaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            text: "Trading Reward",
                            textColor: Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),  height10,
                          AppText(
                            text: index.isEven?"Credited":"Laps",
                            textColor: index.isEven?Colors.green:AppColor().red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),width10,
                          height10,
                          const AppText(
                            text: "12:40 PM, 20 Mar, 2024",
                            textColor: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),

                        ],
                      )),
                  Expanded(
                      child: AppText(
                        text: "+ $index,000",
                        textColor: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ],
              ),
            ));
      },
    );
  }

  Widget get height10 =>const SizedBox(height: 10,);

  Widget get width10 =>const SizedBox(width: 10,);

  filterWidget(){
    return Column(children: [
      SizedBox(height: 30,
        child: TabBar(controller: _controller,indicatorWeight: 0,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Creates border
              color: AppColor().oldThemeColors),
          tabs: [
            Tab(icon:  AppText(
              text:"Level History",
              fontSize: 15,
            ),),



          ],
        ),
      ),
    ],);
  }
}
