
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vision_dashboard/constants.dart';

class BarChartSample4 extends StatefulWidget {
  BarChartSample4({super.key,required this.index});

  final Color dark = Colors.black.withBlue(100);
  final Color normal = primaryColor.withAlpha(1);
  final Color light = primaryColor;
final int index;
  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  Widget bottomTitles(double value, TitleMeta meta) {
   final  style = Styles.headLineStyle4;
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'نيس';
        break;
      case 1:
        text = 'أيا';
        break;
      case 2:
        text = 'حز';
        break;
      case 3:
        text = 'تمو';
        break;
      case 4:
        text = 'آب';
        break;
      case 5:
        text = 'أيل';
        break;
      case 6:
        text = 'تش١';
        break;
      case 7:
        text = 'تش٢';
        break;
      case 8:
        text = 'كن١';
        break;
      case 9:
        text = 'كن٢';
        break;
      case 10:
        text = 'شبا';
        break;
      case 11:
        text = 'آذا';
        break;
      default:
        text = '';
        break;
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
    return AspectRatio(
      aspectRatio: 1.66,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barsSpace = 24.0 * constraints.maxWidth / 400;
          final barsWidth = 8.0 * constraints.maxWidth / 400;
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
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?5568400000:widget.index==1?10000000000:15564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 5568400000:widget.index==1?10000000000:15564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?4568400000:widget.index==1?12000000000:16564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 4568400000:widget.index==1?12000000000:16564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?1568400000:widget.index==1?14000000000:19564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 1568400000:widget.index==1?14000000000:19564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?1568400000:widget.index==1?10000000000:18564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 1568400000:widget.index==1?10000000000:18564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?5568400000:widget.index==1?5568400000:13564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 5568400000:widget.index==1?5568400000:13564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?2568400000:widget.index==1?7000000000:13000000000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 5568400000:widget.index==1?10000000000:13000000000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?1522740000:widget.index==1?2000000000:5564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 1522740000:widget.index==1?2000000000:5564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 7,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?7568400000:widget.index==1?14000000000:19564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 7568400000:widget.index==1?14000000000:19564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 8,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?568400000:widget.index==1?19000000000:19564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 568400000:widget.index==1?19000000000:19564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 9,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?5010000000:widget.index==1?11000000000:18564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 5010000000:widget.index==1?11000000000:18564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 10,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?568400000:widget.index==1?4000000000:9564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 568400000:widget.index==1?4000000000:9564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),
      BarChartGroupData(
        x: 11,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: widget.index==0?168400000:widget.index==1?9564800000:11564800000,
            rodStackItems: [

              BarChartRodStackItem(0,widget.index==0? 168400000:widget.index==1?9564800000:11564800000,widget.index==0? widget.dark:widget.index==1?widget.normal:widget.light),

            ],
            borderRadius: BorderRadius.circular(4),
            width: barsWidth,
          ),

        ],
      ),


    ];
  }
}