import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatefulWidget {
   Chart({
    Key? key,
     required this.touchedIndex, required,required this.paiChartSelectionData, required this.title,required this.subtitle
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
  int touchedIndex = -1;
final String title,subtitle;
List<PieChartSectionData> paiChartSelectionData;
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
              sections: widget.paiChartSelectionData,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  widget.subtitle,
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
                Text(widget.title)
              ],
            ),
          ),
        ],
      ),
    );
  }

}