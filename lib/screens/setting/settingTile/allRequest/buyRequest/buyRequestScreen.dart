import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gredex/commonWidget/app_page_loader.dart';

import '../../../../../Utility/app_toolbar.dart';
import '../../../../../Utility/app_utility.dart';
import '../../../../../commonWidget/appColors.dart';
import '../../../../../commonWidget/appText.dart';
import '../../../../../commonWidget/app_input_container.dart';
import '../../../../../commonWidget/customButton.dart';
import '../../../../../getXController/buyRequestController/buyRequestController.dart';

class BuyRequestScreen extends StatelessWidget {
    BuyRequestScreen({required this.userRate,required this.rateType,required this.amount,super.key});
final String userRate,amount;
final String rateType;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyRequestController>(
      init: BuyRequestController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().primaryColor,
          appBar: AppToolbar(
            onPressBackButton: () {
              Navigator.pop(context);
            },
            enableBackArrow: true,
            title: "Buy Request",
            appColor: Colors.transparent,
          ),
          body: AppPageLoader(
            isLoading: controller.loaderStatus.value,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Column(
                children: [
                  formWidget(controller, context),
                  height10,
                  CustomButton(
                    buttonText: "Buy Request",
                    onClickButton: () {
                      if (controller.selectedWalletId.value != "0") {
                        if (buyRequest.currentState!.validate()) {
                          controller.p2pSelBuy();
                        } else {
                          AppUtility.showErrorSnackBar("Enter Amount First");
                        }
                      } else {
                        AppUtility.showErrorSnackBar(
                            "Select Account Type First");
                      }
                    },
                  ),
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

  var buyRequest = GlobalKey<FormState>();
  formWidget(BuyRequestController controller, BuildContext context) {
    controller.amount.value.text  =amount;
    controller.convertedAmountUsdInr.value.text="${double.parse(amount)*double.parse(userRate)}";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),

      // height: 40,
      decoration: BoxDecoration(
        color: AppColor().secondPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: buyRequest,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AppText(
              text: "Amount",
              fontSize: 18,
            ),
            height10,
            AppInputContainer(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Amount cannot be empty";
                }
                return null;
              },
              controller: controller.amount.value,
              onTextChange: (val) {
                if (val.isNotEmpty) {
                  controller.dollarAmount.value = int.parse(val);
                  controller.convertedAmountUsdInr.value.text="${double.parse(val)*double.parse(userRate)}";
                  // controller.convertedAmount.value.text =
                  // controller.selectedWalletId == "1"
                  //     ? (double.parse(val) *
                  //     double.parse(controller.homePageController
                  //         .gdxLiveRateModel.value!.data.rate
                  //         .toStringAsFixed(2)))
                  //     .toStringAsFixed(2)
                  //     : double.parse(val).toStringAsFixed(2);
                  // controller.gdxAmount.value =
                  // controller.selectedWalletId == "1"
                  //     ? double.parse(
                  //     controller.convertedAmount.value.text.toString())
                  //     : double.parse(controller.convertedAmount.value.text);
                } else {
              controller.convertedAmountUsdInr.value.text = "";
                }
              },

              inputType: TextInputType.number,
              textBackgroundColor: Colors.white.withOpacity(0.3),

              padding: const EdgeInsets.symmetric(horizontal: 10),
              placeholder: " ",
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
              //controller: controller.suggestionController,
            ),
            height10,
            AppText(
              text: "Amount( $rateType )",
              fontSize: 18,
            ),height10,
        AppInputContainer(
            enableEdit: false,

            controller: controller.convertedAmountUsdInr.value,
            onTextChange: (val) {},

            inputType: TextInputType.number,
            textBackgroundColor: Colors.white.withOpacity(0.3),

            padding: const EdgeInsets.symmetric(horizontal: 10),
            placeholder: " ",
            maxLines: 1,
            textCapitalization: TextCapitalization.words,
            //controller: controller.suggestionController,
          ),

            // const AppText(
            //   text: "Converted Amount",
            //   fontSize: 18,
            // ),
            // height10,
            // Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            //   AppText(
            //     text: "GDX Live Rate",
            //     fontSize: 15,
            //     textColor: AppColor().orange,
            //   ),
            //   Obx(
            //         () => AppText(
            //       textColor: AppColor().green,
            //       text:
            //       "${controller.amountInt.value} GDX = \$ ${controller.homePageController.gdxLiveRateModel.value != null ? (controller.amountInt.value) * double.parse(controller.homePageController.gdxLiveRateModel.value!.data.rate.toStringAsFixed(2)) : "0.0" ?? 0.0} ",
            //       fontSize: 15,
            //     ),
            //   ),
            // ]),
            // height10,
            // AppInputContainer(
            //   enableEdit: false,
            //
            //   controller: controller.convertedAmount.value,
            //   onTextChange: (val) {},
            //
            //   inputType: TextInputType.number,
            //   textBackgroundColor: Colors.white.withOpacity(0.3),
            //
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   placeholder: " ",
            //   maxLines: 1,
            //   textCapitalization: TextCapitalization.words,
            //   //controller: controller.suggestionController,
            // ),
            // height10,
          ],
        ),
      ),
    );
  }
}
