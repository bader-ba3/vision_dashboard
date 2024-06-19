import 'dart:math';

import 'package:vision_dashboard/chart/Liner_Chart.dart';
import 'package:vision_dashboard/models/MyFiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vision_dashboard/screens/dashboard/components/Total_Chart.dart';

import '../../../constants.dart';

class BarChartWidget extends StatefulWidget {
   BarChartWidget({
    Key? key,

     required this.index,

   }) : super(key: key);



  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
   int index=2;
}

class _BarChartWidgetState extends State<BarChartWidget> {


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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        SizedBox(height: defaultPadding,),

          SizedBox(
              height: 400,
width: double.infinity,
              child: BarChartSample4(index: widget.index,)),

          Row(
            children: [
              const Spacer(),


              GestureDetector(
                onTap:(){
                  widget.index=2;
                  setState(() {

                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black.withOpacity(0.2)),
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "الاجمالي",
                      // style: Styles.headLineStyle3,
                    )
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap:(){
                  widget.index=1;
                  setState(() {

                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black.withOpacity(0.2)),
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "الايرادات",
                      // style: Styles.headLineStyle3,
                    )
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap:(){
                  widget.index=0;
                  setState(() {

                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.black.withOpacity(0.2)),
                          color:Colors.black.withBlue(100),
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "المصروف",
                      // style: Styles.headLineStyle3,
                    )
                  ],
                ),
              ),

              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
