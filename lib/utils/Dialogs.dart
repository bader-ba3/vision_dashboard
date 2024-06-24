
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
bool isNumeric(String str) {
  final number = num.tryParse(str);
  return number != null;
}


bool validateNotEmpty(String value, String fieldName) {
  if (value.isEmpty) {
    showErrorDialog("خطأ", "$fieldName لا يمكن أن يكون فارغًا");
    return false;
  }
  return true;
}

bool validateNumericField(String value, String fieldName) {
  if (value.isEmpty || !isNumeric(value)) {
    showErrorDialog("خطأ", "$fieldName يجب أن يحتوي على أرقام فقط");
    return false;
  }
  return true;
}