
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vision_dashboard/constants.dart';

class RadarChartSample1 extends StatefulWidget {
  RadarChartSample1({super.key});

  final gridColor = Color(0xff00308F); // أزرق متوسط
  final titleColor =  Color(0xff00308F); // أزرق فاتح
  final fashionColor = Color(0xFF66BB6A); // أخضر فاتح
  final artColor = Color(0xFFFFA726); // برتقاني فاتح
  final boxingColor = Color(0xFFEF5350); // أحمر فاتح
  final entertainmentColor = Color(0xFFAB47BC); // بنفسجي فاتح
  final offRoadColor = Color(0xFFBD6E63); // بني فاتح


  @override
  State<RadarChartSample1> createState() => _RadarChartSample1State();
}

class _RadarChartSample1State extends State<RadarChartSample1> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
borderRadius: BorderRadius.circular(25)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Title configuration',
              style: TextStyle(
                color:Color(0xff00308F),
              ),
            ),

            GestureDetector(
              onTap: () {
                setState(() {
                  selectedDataSetIndex = -1;
                });
              },
              child: Text(
                'Categories'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff00308F),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rawDataSets()
                  .asMap()
                  .map((index, value) {
                final isSelected = index == selectedDataSetIndex;
                return MapEntry(
                  index,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDataSetIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      height: 26,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(46),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInToLinear,
                            padding: EdgeInsets.all(isSelected ? 8 : 6),
                            decoration: BoxDecoration(
                              color: value.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInToLinear,
                            style: TextStyle(
                              color:
                              isSelected ? value.color : widget.gridColor,
                            ),
                            child: Text(value.title),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
                  .values
                  .toList(),
            ),
            AspectRatio(
              aspectRatio: 1.3,
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {
                      if (!event.isInterestedForInteractions) {
                        setState(() {
                          selectedDataSetIndex = -1;
                        });
                        return;
                      }
                      setState(() {
                        selectedDataSetIndex =
                            response?.touchedSpot?.touchedDataSetIndex ?? -1;
                      });
                    },
                  ),
                  dataSets: showingDataSets(),
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData: const BorderSide(color: Colors.transparent),
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle:
                  TextStyle(color: widget.titleColor, fontSize: 14),
                  getTitle: (index, angle) {
                    final usedAngle =
                    relativeAngleMode ? angle + angleValue : angleValue;
                    switch (index) {
                      case 0:
                        return RadarChartTitle(
                          text: 'Maintenance',
                          angle: usedAngle,
                        );
                      case 2:
                        return RadarChartTitle(
                          text: 'Reverse',
                          angle: usedAngle,
                        );
                      case 1:
                        return RadarChartTitle(text: 'Stop', angle: usedAngle);
                      default:
                        return const RadarChartTitle(text: '');
                    }
                  },
                  tickCount: 1,
                  ticksTextStyle:
                  const TextStyle(color: Colors.transparent, fontSize: 10),
                  tickBorderData: const BorderSide(color: Colors.transparent),
                  gridBorderData: BorderSide(color: widget.gridColor, width: 2),
                ),
                swapAnimationDuration: const Duration(milliseconds: 400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
          ? false
          : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.5)
            : rawDataSet.color.withOpacity(0.05),
        borderColor:
        isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
        rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: 'Small',
        color: widget.fashionColor,
        values: [
          300,
          50,
          250,
        ],
      ),
      RawDataSet(
        title: 'Medium',
        color: widget.artColor,
        values: [
          250,
          100,
          200,
        ],
      ),
      RawDataSet(
        title: 'Van',
        color: widget.entertainmentColor,
        values: [
          200,
          150,
          50,
        ],
      ),
      RawDataSet(
        title: '4X4',
        color: widget.offRoadColor,
        values: [
          150,
          200,
          150,
        ],
      ),

    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}