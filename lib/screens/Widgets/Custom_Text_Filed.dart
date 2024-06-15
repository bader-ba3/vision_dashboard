import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,  this. keyboardType,this.enable
  });

  final TextEditingController controller;
  final String title;
  final TextInputType? keyboardType;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width/3.5,
      child:TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        enabled: enable,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(color: primaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          disabledBorder:UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor,width: 2),
            borderRadius: BorderRadius.circular(10),
          ),

        ),
      ),
    );
  }
}