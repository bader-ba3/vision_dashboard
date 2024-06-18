import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class CustomDropDown extends StatelessWidget {
   CustomDropDown({super.key,required this.value,required this.listValue,required this.label,required this.onChange});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: Get.width/4.5,
      child: DropdownButtonFormField<String>(
        decoration:  InputDecoration(
          labelText: label,
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
        value: null,
        hint: Text(label),
        onChanged: onChange,
        items: listValue.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
      ),
    );
  }

 String value,label ;

final List<String> listValue ;

final Function(String? value) onChange;
}
