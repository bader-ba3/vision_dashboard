
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'InfoBarchart.dart';
import 'info_card.dart';

class EmployeeDetailsChart extends StatefulWidget {
  const EmployeeDetailsChart({
    Key? key,
  }) : super(key: key);

  @override
  State<EmployeeDetailsChart> createState() => _EmployeeDetailsChartState();
}

class _EmployeeDetailsChartState extends State<EmployeeDetailsChart> {
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
          InfoBarChart(touchedIndex: touchedIndex,paiChartSelectionData:paiChartSelectionData(),title: "موظف",subtitle: "60",),
          InfoCard(
            onTap: (){
              touchedIndex==0?touchedIndex=-1:touchedIndex=0;
              setState(() {});
            },
            title: "اداري",
            amountOfEmployee: "١٠",
            color: Colors.redAccent,
          ),
          InfoCard(
            onTap: (){
              touchedIndex==1?touchedIndex=-1:touchedIndex=1;
              setState(() {});
            },
            title: "استاذ",
            amountOfEmployee: "30",
            color: primaryColor,
          ),
          InfoCard(
            onTap: (){
              touchedIndex==2?touchedIndex=-1:touchedIndex=2;
              setState(() {});
            },
            title: "موظف مكتبي",
            amountOfEmployee: "15",
            color: blueColor,
          ),
          InfoCard(
            onTap: (){
              touchedIndex==3?touchedIndex=-1:touchedIndex=3;
              setState(() {});
            },
            title: "سائق",
            amountOfEmployee: "5",
            color: Colors.cyan,
          ),
        ],
      ),
    );
  }
  List<PieChartSectionData> paiChartSelectionData() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      double radius =  isTouched ? 60.0 :30;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: 10,
            title: '${((10 / 60)*100).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: primaryColor,
            value: 30,
            title: '${((30 / 60)*100).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: blueColor,
            value: 15,
            title: '${((15 / 60)*100).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.cyan,
            value: 5,
            title: '${((5 / 60)*100).round()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
