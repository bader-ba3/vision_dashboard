import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class CustomDropDown extends StatelessWidget {
   CustomDropDown({super.key,required this.value,required this.listValue,required this.label,required this.onChange,this.isFullBorder,this.size});
   final double? size;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width:size?? Get.width/4.5,
      child: DropdownButtonFormField<String>(

        decoration:  InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: primaryColor),
          enabledBorder:isFullBorder!=null? OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor,width: 2),
            borderRadius: BorderRadius.circular(10),
          ):UnderlineInputBorder(
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
        value:value==''? null:value,
        iconEnabledColor: Colors.blue,

        hint: Text(label,style: Styles.headLineStyle4.copyWith(color: blueColor.withOpacity(0.7)),),
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

final String value,label ;
final bool? isFullBorder;
final List<String> listValue ;

final Function(String? value) onChange;
}
