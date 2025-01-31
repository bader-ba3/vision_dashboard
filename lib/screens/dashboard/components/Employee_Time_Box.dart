


import 'package:flutter/material.dart';

import 'package:vision_dashboard/screens/dashboard/components/Employee_Time_Chart.dart';

import '../../../constants.dart';

class EmployeeTimeBox extends StatelessWidget {
  const EmployeeTimeBox({
    Key? key,
  }) : super(key: key);

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

          EmployeeTimeChart()
        ],
      ),
    );
  }
}

