import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'info_card.dart';

class StudentsDetailsChart extends StatefulWidget {
  const StudentsDetailsChart({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentsDetailsChart> createState() => _StudentsDetailsChartState();
}

class _StudentsDetailsChartState extends State<StudentsDetailsChart> {
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
            "الطلاب",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(touchedIndex: touchedIndex,paiChartSelectionData:paiChartSelectionData(),title:"طالب",subtitle:"1925"),
          InfoCard(
            onTap: (){
              touchedIndex==0?touchedIndex=-1:touchedIndex=0;

              setState(() {

              });
            },
            title: "ذكر",
            amountOfEmployee: "1195",
            color: Colors.blue,
          ),
          InfoCard(
            onTap: (){
              touchedIndex==1?touchedIndex=-1:touchedIndex=1;

              setState(() {

              });
            },
            title: "انثى",
            amountOfEmployee: "700",
            color: Colors.pink,
          ),
          InfoCard(
            onTap: (){
              touchedIndex==2?touchedIndex=-1:touchedIndex=2;

              setState(() {

              });
            },
            title: "ذوي الهمم",
            amountOfEmployee: "30",
            color: Colors.blueGrey,
          ),


        ],
      ),
    );
  }
  List<PieChartSectionData> paiChartSelectionData() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 1195,
            title: '${((1195 / 1925)*100).round()}%',
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
            color: Colors.pink,
            value: 700,
            title: '${((700 / 1925)*100).round()}%',
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
            color: Colors.blueGrey,
            value: 30,
            title: '${((30 / 1925)*100).round()}%',
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
