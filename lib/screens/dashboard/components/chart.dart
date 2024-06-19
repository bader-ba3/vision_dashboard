import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatefulWidget {
   Chart({
    Key? key,
     required this.touchedIndex
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
  int touchedIndex = -1;
}

class _ChartState extends State<Chart> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      widget.touchedIndex = -1;
                      return;
                    }

                   widget. touchedIndex = pieTouchResponse
                        .touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sectionsSpace: 1,
              centerSpaceRadius: 80,
              startDegreeOffset: 0,
              sections: paiChartSelectionData(),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "60",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(
                    color: Color(0xff00308F),
                    fontWeight: FontWeight.w600,
                    height: 0.5,
                  ),
                ),
                SizedBox(height: 10,),
                Text("موظف")
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> paiChartSelectionData() {
    return List.generate(4, (i) {
      final isTouched = i == widget.touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
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