import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'Employee_info_card.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الموظفين",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(touchedIndex: touchedIndex,),
          EmployeeInfoCard(
            onTap: (){
              touchedIndex==0?touchedIndex=-1:touchedIndex=0;

              setState(() {

              });
            },
            title: "اداري",
            amountOfEmployee: "١٠",
            color: Colors.redAccent,
          ),
          EmployeeInfoCard(
            onTap: (){
              touchedIndex==1?touchedIndex=-1:touchedIndex=1;

              setState(() {

              });
            },
            title: "استاذ",
            amountOfEmployee: "٣٠",
            color: primaryColor,
          ),
          EmployeeInfoCard(
            onTap: (){
              touchedIndex==2?touchedIndex=-1:touchedIndex=2;

              setState(() {

              });
            },
            title: "موظف مكتبي",
            amountOfEmployee: "١٥",
            color: blueColor,
          ),
          EmployeeInfoCard(
            onTap: (){
              touchedIndex==3?touchedIndex=-1:touchedIndex=3;

              setState(() {

              });
            },
            title: "سائق",
            amountOfEmployee: "٥",
            color: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
