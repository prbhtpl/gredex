import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../commonWidget/appColors.dart';

class AppUtility {
  static double getHeight(num percentage) {
    return Get.height * (percentage / 100);
  }

  static double getWidth(num percentage) {
    return Get.width * (percentage / 100);
  }

  static sp(var i) {
    return Get.width / 100 * (i / 3);
  }

  static Widget loader({bool isDarkMode = false}) => Center(
    child: CircularProgressIndicator(
        color: AppColor().primaryColor),
  );

  // static String serverError = 'Server Error, Try again later';

  static Future<void> showErrorSnackBar(String message) {
    if (message.isNotEmpty) {
      Get.rawSnackbar(message: message, duration: const Duration(seconds: 2),backgroundColor: AppColor().red);
      return Future.delayed(const Duration(seconds: 2));
    }
    return Future.value();
  }
  static Future<void> showSuccessSnackBar(String message) {
    if (message.isNotEmpty) {
      Get.snackbar(
        "Gridx Ecosystem",
        message,
        icon: Image.asset("assets/gridx.png",height: 30,width: 30,),
        snackPosition: SnackPosition.TOP,
        backgroundColor:  Colors.white,
      );
      //Get.rawSnackbar(message: message, duration: const Duration(seconds: 2),backgroundColor: AppColor().green);
      return Future.delayed(const Duration(seconds: 2));
    }
    return Future.value();
  }

  static parseDate(String input) {
    //input format -> 2021-10-22 07:40:18
    try {
      DateFormat fromFormat = DateFormat("yyyy-MM-ddThh:mm:ss");
    //  var parsedDate = fromFormat.parse(input);
      var parsedDate = fromFormat.parse(input);

      // String formattedDate = DateFormat.jm().format(parsedDate);
      String toFormat = DateFormat("MM/dd/yyyy, h:mm a").format(parsedDate.add(Duration(hours: 5,minutes: 30)));

      return  "$toFormat ";
    } catch (e) {
      return input;
    }
  }

  static String getMonthBegin() {
    try {
      var parsedDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
      DateFormat toFormat = DateFormat("dd-MM-yyyy");
      return toFormat.format(parsedDate);
    } catch (e) {
      return "";
    }
  }

  static String getMonthLast() {
    try {
      var parsedDate =
          DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
      DateFormat toFormat = DateFormat("dd-MM-yyyy");
      return toFormat.format(parsedDate);
    } catch (e) {
      return "";
    }
  }

  static String parseDateTimeText(DateTime input) {
    //input format -> 2021-10-22 07:40:18
    try {
      DateFormat toFormat = DateFormat("yyyy-MM-dd");
      return toFormat.format(input);
    } catch (e) {
      return "";
    }
  }

  static String convertServerDate({required String data}) {
    try {
      DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
      var dateTime = formatter.parse(data).toLocal();
      // var dateTime1 = DateFormat('yyyy-MM-ddThh:mm:ss').parse(data,true);
      // // DateFormat formatter = DateFormat('yyyy-MM-ddThh:mm:ss');
      // var dateTime = dateTime1.toLocal();
      DateFormat toFormatter = DateFormat('dd-MM-yyyy hh:mm a');
      return toFormatter.format(dateTime);
    } catch (e) {
      return "";
    }
  }

  static String convertServerDateOrders({required String data}) {
    try {
      var dateTime1 = DateFormat('yyyy-MM-ddThh:mm:ss').parse(data,true);
      // DateFormat formatter = DateFormat('yyyy-MM-ddThh:mm:ss');
      var dateTime = dateTime1.toLocal();
      DateFormat toFormatter = DateFormat('dd-MM-yyyy hh:mm a');
      return toFormatter.format(dateTime);
    } catch (e) {
      return "";
    }
  }

  static openCallApp(String phoneNumber) async {
    try {
      if (phoneNumber.isNotEmpty) {
        await launch("tel:${phoneNumber.trim()}",);
      } else {
        AppUtility.showSuccessSnackBar("Phone Number is Empty");
      }
    } catch (e) {
      AppUtility.showErrorSnackBar("Currently not supported");
    }
  }

  static openBrowser(String link) async {
    try {
      if (link.isNotEmpty) {

        await launch(link);
      } else {
        AppUtility.showSuccessSnackBar("Invalid url is Empty");
      }
    } catch (e) {
      AppUtility.showErrorSnackBar("Currently not supported");
    }
  }
  static validateMyInput(String value) {
    Pattern pattern = r'/^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Number';
    }
    else {
      return null;
    }
  }

  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
