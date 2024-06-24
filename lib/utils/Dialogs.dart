import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';

import '../screens/Widgets/AppButton.dart';

void showErrorDialog(String title, String message) {
  Get.defaultDialog(
    title: title,
    titleStyle: Styles.headLineStyle2,
    backgroundColor: secondaryColor,
    middleText: message,
confirmTextColor: Colors.white,
confirm: AppButton(text: "موافق", onPressed: () {
  Get.back();
},),
 /*   textConfirm: "موافق",
    onConfirm: () {
      Get.back();
    },*/
    barrierDismissible: false,
  );
}
