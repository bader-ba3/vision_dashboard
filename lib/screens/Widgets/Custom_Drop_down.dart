import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class CustomDropDown extends StatefulWidget {
   CustomDropDown({super.key,required this.value,required this.listValue,required this.label});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
 String value,label ;

final List<String> listValue ;
}



class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: Get.width/4.5,
      child: DropdownButtonFormField<String>(
        decoration:  InputDecoration(
          labelText: widget.label,
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
        hint: Text('طريقة الدفع'),
        onChanged: (selectedWay) {
          if (selectedWay != null) {
            setState(() {
             widget. value = selectedWay;
            });
          }
        },
        items: widget.listValue.map((student) {
          return DropdownMenuItem(
            value: student,
            child: Text(student),
          );
        }).toList(),
      ),
    );
  }
}
