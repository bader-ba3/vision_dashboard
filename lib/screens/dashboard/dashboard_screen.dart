import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/MyFiles.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:vision_dashboard/screens/dashboard/components/date_table.dart';
import 'package:vision_dashboard/screens/dashboard/components/file_info_card.dart';
import 'package:flutter/material.dart';
import 'package:vision_dashboard/screens/dashboard/components/pie_Chart.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();


}

class _DashboardScreenState extends State<DashboardScreen> {
  int index=2;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: Wrap(
                          direction: Axis.horizontal,
alignment: WrapAlignment.spaceBetween,
                          runSpacing: 25,
                          spacing: 0,
                          children: [
                            InkWell(
                                onHover: (value) {
                                  print(value);
                                },
                                onTap: (){
                                  index=2;
                                  setState(() {

                                  });
                                },
                                child: SquareWidget("الاجمالي", "155,684.00",primaryColor,"assets/budget.png")),
                            InkWell(
                                onTap: (){
                                  index=0;
                                  setState(() {

                                  });
                                },
                                child: SquareWidget("المصروف", "55,684.00",blueColor,"assets/poor.png")),
                            InkWell(
                                onTap: (){
                                  index=1;
                                  setState(() {

                                  });
                                },
                                child: SquareWidget("الايرادات", "100,000.00",Colors.cyan,"assets/profit.png")),

                          ],
                        ),
                      ),
                      SizedBox(height: defaultPadding),
                      FileInfoCard(info:CloudStorageInfo(color: Colors.red,numOfFiles: 465,percentage: 54,title: "sd",totalStorage: "sad",svgSrc: ""),index: index, ),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))  Column(
                        children: [
                          PieChartWidget(),
                          SizedBox(height: 10,),
                          StorageDetails(),
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
                        // DateTables(),
                        PieChartWidget(),
                        SizedBox(height: 10,),
                        StorageDetails(),
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

  Widget SquareWidget(title, body,color,png) {
    return Padding(
      padding: const EdgeInsets.all(8),

      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style:Styles.headLineStyle2.copyWith(color: color),
                    )),
              ),
            ),
            Text(
              body,
              style:Styles.headLineStyle1.copyWith(color: color,fontSize: 40),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(png,height: 70,color: color,),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
