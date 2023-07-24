import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gredex/Utility/app_utility.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';
import 'package:gredex/commonWidget/noData.dart';
import 'package:gredex/getXController/fundRequestController/fundRequestController.dart';
import 'package:gredex/getXController/homePageController/homePageController.dart';
import 'package:gredex/model/fundRequestHistoryModel/fundRequestHistoryModel.dart';

import '../../../Utility/app_toolbar.dart';
import '../../../commonWidget/appColors.dart';
import '../../../commonWidget/appText.dart';
import '../../../commonWidget/app_input_container.dart';
import '../../../commonWidget/customButton.dart';
import '../../../model/profileModel/profileModel.dart';

class ExternalRequest extends StatefulWidget {
  const ExternalRequest({Key? key}) : super(key: key);

  @override
  State<ExternalRequest> createState() => _ExternalRequestState();
}

class _ExternalRequestState extends State<ExternalRequest> {
  bool visibleHistory = false;
  HomePageController homePageController = Get.put(HomePageController());
@override
  void dispose() {

  fundRequestFormKey.currentState!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FundRequestController>(
      init: FundRequestController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Fund Request",
            appColor: Colors.transparent,
          ),
          backgroundColor: AppColor().primaryColor,
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() => topWidget(homePageController.allUserProfileData.value)),
                    formWidget(controller),
                    height10,
                    CustomButton(
                      onClickButton: () {
                        if (fundRequestFormKey.currentState!.validate()) {
                          controller.addFund();
                        }
                      },
                      buttonText: "Submit",
                    ),
                    height10,
                    AppText(
                      onTap: () {
                        setState(() {
                          visibleHistory = !visibleHistory;
                        });
                      },
                      text: visibleHistory ? "Hide History" : " View History",
                      textColor: AppColor().oldThemeColors,
                      underline: true,
                      fontSize: 15,
                    ),
                    height10,
                    Visibility(
                        visible: visibleHistory,
                        child: controller.fundRequestHistory!=null? ListView.builder(
                          itemCount: controller.fundRequestHistory.length??0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return teamWidget(controller.fundRequestHistory[index]);
                          },
                        ):NoData()),
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
  List wallet = [
    {"name": "External Wallet", "id": "1"},
    {"name": "External GDX", "id": "2"},
  ];
  Widget teamWidget(FunHistoryList fundRequestHistory) {
    String statusString="";
    Color? statusStringColor;
    if(fundRequestHistory.status==0){
      statusString="Pending";
      statusStringColor=AppColor().orange;
    }else if(fundRequestHistory.status==1){
      statusString="Approved";
      statusStringColor=AppColor().green;
    }else{
      statusString="Rejected";
      statusStringColor=AppColor().red;
    }
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor().secondPrimaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        colors: [
                          AppColor().purple,
                          AppColor().themeColors,
                          AppColor().themeColors,
                        ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "Amount",
                      fontSize: 15,
                    ),
                    AppText(
                      text: fundRequestHistory.gdxamount.toString(),
                      fontSize: 15,
                    ),
                  ],
                )),
            height10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      height10,
                      AppText(
                        text: "Status",
                        fontSize: 15,
                      ),
                      height10,

                      AppText(
                        text: "Wallet Type",
                        fontSize: 15,
                      ), height10,

                      AppText(
                        text: "Transaction Hash",
                        fontSize: 15,
                      ),
                      height10,
                      AppText(
                        text: "Date Time",
                        fontSize: 15,
                      ),
                      height10,
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      height10,
                      AppText(
                        text: statusString,
                        fontSize: 15,
                        textColor:
                        statusStringColor ,
                      ),
                      height10,

                      AppText(
                        text: fundRequestHistory.wallettype=="gdx"?"GDX":"EXT",
                        fontSize: 15,
                      ), height10,

                      SizedBox(width:160,
                        child: AppText(
                          text: fundRequestHistory.hash,
                          fontSize: 15,
                        ),
                      ),
                      height10,
                      AppText(
                        text: AppUtility.parseDate(fundRequestHistory.createdAt),
                        fontSize: 15,
                        textColor: AppColor().greyText,
                      ),
                      height10,
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }

  var fundRequestFormKey = GlobalKey<FormState>();

  formWidget(FundRequestController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

      // height: 40,
      decoration: BoxDecoration(
        color: AppColor().secondPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: fundRequestFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppText(
              text: "Account Type",
              fontSize: 15,
            ),
            height10,
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              padding: EdgeInsets.only(left: 8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: AppColor().secondPrimaryColor, width: 0.5),
                color: AppColor().primaryColor,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(
                  color: AppColor().secondPrimaryColor
                )),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white ),
                  hint: const Text("Select Wallet",
                      style: TextStyle(color: Color(0xffC8C7CE), fontSize: 15)),
                  items: wallet.map((item) {
                    return DropdownMenuItem(
                      value: item["name"],
                      child: Text(
                        item["name"].toString(),style:  TextStyle(color: Colors.white ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    var aaa = wallet.where((element) {
                      print("asd  $element");
                      if (element["name"] == value) {
                        controller.selectedWalletId.value =
                            element["id"].toString();
                      }
                      return true;
                    });

                    debugPrint(aaa.toString());
                    setState(() {
                      controller.selectedWallet.value = value! as String?;
                    });
                  },
                  value: controller.selectedWallet.value,
                ),
              ),
            ),
            height10,
            AppText(
              text: "Amount(\$)",
              fontSize: 15,
            ),
            height10,
            AppInputContainer(inputType: TextInputType.number,
              onTextChange: (val) {
                controller.amountInt.value = int.parse(val);
              },
              controller: controller.amount.value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Amount cannot be empty";
                }
                return null;
              },
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 15),
              placeholder: " ",
              maxLines: 1,

              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            AppText(
              text: "Transaction Hash",
              fontSize: 15,
            ),
            height10,
            AppInputContainer(
              controller: controller.hash.value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Hash cannot be empty";
                }
                return null;
              },
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 15),
              placeholder: " ",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
          ],
        ),
      ),
    );
  }

  topWidget(ProfileModel? value) {
    return Container(
        // addmoneyNfi (0:3484)
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

        // height: 40,
        decoration: BoxDecoration(
          color: Color(0xff2b2b44),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                width10,
                AppText(
                  text: "External Wallet",
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                AppText(
                  text: "\$ ${value?.data.externalWallet.toStringAsFixed(2)}",
                  fontSize: 15,
                  textColor: AppColor().green,
                ),
              ],
            ),
            height10,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                width10,
                const AppText(
                  text: "External GDX ",
                  fontSize: 18,
                ),
                const Expanded(child: SizedBox()),
                AppText(
                  text: "${value?.data.externalGdxWallet.toStringAsFixed(2)}",
                  fontSize: 15,
                  textColor: AppColor().green,
                ),
              ],
            ),
          ],
        ));
  }

  Widget get height10 => const SizedBox(
        height: 10,
      );

  Widget get width10 => const SizedBox(
        width: 10,
      );
}
