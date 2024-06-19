
import 'package:flutter/material.dart';
import 'package:vision_dashboard/screens/dashboard/components/Employee_Salary_BarChar.dart';
import 'package:vision_dashboard/screens/dashboard/components/Total_Chart.dart';

import '../../../constants.dart';

class EmployeeSalaryChartBox extends StatefulWidget {
  EmployeeSalaryChartBox({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<EmployeeSalaryChartBox> createState() => _EmployeeSalaryChartBoxState();
  int index = 2;
}

class _EmployeeSalaryChartBoxState extends State<EmployeeSalaryChartBox> {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
              height: 400,
              width: double.infinity,
              child: EmployeeSalaryBarChart(

              )),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  widget.index = 2;
                  setState(() {});
                },
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black.withOpacity(0.2)),
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "المستحق",
                      // style: Styles.headLineStyle3,
                    )
                  ],
                ),
              ),
              const Spacer(),

              GestureDetector(
                onTap: () {
                  widget.index = 0;
                  setState(() {});
                },
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black.withOpacity(0.2)),
                          color: Colors.black.withBlue(100),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "المدفوع",
                      // style: Styles.headLineStyle3,
                    )
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

