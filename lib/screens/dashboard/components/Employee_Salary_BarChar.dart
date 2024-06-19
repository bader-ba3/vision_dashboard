
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vision_dashboard/constants.dart';

class EmployeeSalaryBarChart extends StatefulWidget {
  EmployeeSalaryBarChart({super.key});

  final Color dark = Colors.black.withBlue(100);
  final Color normal = primaryColor.withAlpha(1);
  final Color light = primaryColor;

  @override
  State<StatefulWidget> createState() => EmployeeSalaryBarChartState();
}

class EmployeeSalaryBarChartState extends State<EmployeeSalaryBarChart> {
  Widget bottomTitles(double value, TitleMeta meta) {
    final style = Styles.headLineStyle4;
    String text;

    if (value > 0 && value < employeeName.length-1) {
      text = employeeName[value.toInt()];
      // تقليل طول النص إذا كان طويلاً

    } else {
      text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    final style = Styles.headLineStyle4;
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: ClampingScrollPhysics(),
      child: SizedBox(
        // aspectRatio: 1.66,
        height: 400,
        width: 90*24,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final barsSpace = 24.0 * constraints.maxWidth / 400;
            final barsWidth = 8.0 * constraints.maxWidth / 1000;
            return BarChart(
              BarChartData(
                alignment: BarChartAlignment.center,
                barTouchData: BarTouchData(
                  enabled: true,
                ),
                titlesData: FlTitlesData(

                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,

                      reservedSize: 40,
                      getTitlesWidget: bottomTitles,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 10 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.5),
                    strokeWidth: 1,
                  ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                groupsSpace: barsSpace,
                barGroups: getData(barsWidth, barsSpace),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    int salary=0;
    List<BarChartGroupData> getBarChartData() {

      List<BarChartGroupData> data = [];

      for (int i = 1; i <= 24; i++) {
        salary=Random().nextInt(2500);
        data.add(
          BarChartGroupData(
            x: i,
            barsSpace: barsSpace,
            barRods: [
              BarChartRodData(
                toY:i==24?3500: 2500,
                rodStackItems: [
                  if(i!=24)
                  BarChartRodStackItem(0, i==24?3500:salary.toDouble(), widget.dark),
                  if(i!=24)
                  BarChartRodStackItem(i==24?3500:salary.toDouble(), i==24?3500:2500, widget.light),
                ],
                borderRadius: BorderRadius.circular(4),
                width: barsWidth,
              ),
            ],
          ),
        );
      }

      return data;
    }
   return getBarChartData();
  }

}