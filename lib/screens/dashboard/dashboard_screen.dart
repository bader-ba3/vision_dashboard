import 'package:get/get.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:vision_dashboard/screens/dashboard/components/Employee_Salary_Chart.dart';
import 'package:vision_dashboard/screens/dashboard/components/Student_Detiles_Chart.dart';
import 'package:vision_dashboard/screens/dashboard/components/Total_info_Widget.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../Widgets/header.dart';

import 'components/Employee_Time_Box.dart';
import 'components/Employee_Details_Chart.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  Header(title: 'الصفحة الرئيسية',),
      body: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: MediaQuery.sizeOf(context).width < 800 ?WrapAlignment.center:WrapAlignment.spaceBetween,
                runSpacing: 25,
                spacing: 0,
                children: [
                  InkWell(
                      onHover: (value) {
                      },
                      onTap: () {
                        index = 2;
                        setState(() {});
                      },
                      child: SquareWidget("الاجمالي", "45,426.0",
                          primaryColor, "assets/budget.png")),
                  InkWell(
                      onTap: () {
                        index = 1;
                        setState(() {});
                      },
                      child: SquareWidget("الايرادات", "101,110.0",
                          Colors.cyan, "assets/profit.png")),
                  InkWell(
                      onTap: () {
                        index = 0;
                        setState(() {});
                      },
                      child: SquareWidget("المصروف", "55,684.0",
                          blueColor, "assets/poor.png")),
                  SquareWidget("الرواتب المستحقة", "57,920.0",
                      Colors.black, "assets/money-bag.png"),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TotalBarChartWidget(
                        index: index,
                      ),
                      SizedBox(height: defaultPadding),
                      EmployeeTimeBox(),
                      SizedBox(height: defaultPadding),
                      EmployeeSalaryChartBox(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        Column(
                          children: [
                            EmployeeDetailsChart(),
                            SizedBox(height: defaultPadding,),
                            StudentsDetailsChart(),
                          ],
                        ),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        EmployeeDetailsChart(),
                        SizedBox(height: defaultPadding,),
                        StudentsDetailsChart(),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget SquareWidget(title, body, color, png) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 275,
        width: 275,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Styles.headLineStyle2.copyWith(color:color==false?Colors.black: color),
                )),
              ),
            ),
            Text(
              body,
              style: Styles.headLineStyle1.copyWith(color: color==false?Colors.black: color, fontSize: 40),
            ),
            SizedBox(
              height: 20,
            ),
            color==false?
            Image.asset(
              png,
              height: 100,
              // color: color==false?Colors.transparent: color,
            ):Image.asset(
              png,
              height: 70,
              color: color,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
