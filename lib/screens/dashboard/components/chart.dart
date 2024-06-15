import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "1412",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Color(0xff00308F),
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                SizedBox(height: 10,),
                Text("of 1500")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [
  PieChartSectionData(
    color: Colors.pink.withOpacity(0.5),
    value: 45,
    showTitle: false,
    radius: 20,
  ),
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 20,
  ),
  PieChartSectionData(
    color: Colors.green,
    value: 15,
    showTitle: false,
    radius: 20,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 10,
    showTitle: false,
    radius: 20,
  ),
];
