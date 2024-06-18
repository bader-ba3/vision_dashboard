import 'package:vision_dashboard/screens/reports/widget/bar_char.dart';
import 'package:vision_dashboard/screens/reports/widget/pie_chart.dart';
import 'package:vision_dashboard/screens/reports/widget/radar_chart.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Report",style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),

            Center(child: Text("Income Chart",style: TextStyle(fontSize: 30),)),
            Center(
              child: SizedBox(
                  height: 500,
                  width: MediaQuery.sizeOf(context).width/1.6,
                  child: LineChartSample4()),
            ),
            SizedBox(height: 20,),

            Center(child: Text("Customer Per Week day",style: TextStyle(fontSize: 30),)),
            Center(
              child: SizedBox(
                height: 500,
                  width: MediaQuery.sizeOf(context).width/1.6,
                  child: BaeChartLine()),
            ),
            SizedBox(height: 40,),

            Center(child: Text("Small vs Medium vs Van vs 4X4",style: TextStyle(fontSize: 30),)),
            SizedBox(height: 20,),
            Center(
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width/1.6,
                  child: RadarChartSample1()),
            ),
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
