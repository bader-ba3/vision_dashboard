import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Student/Student_view_Screen.dart';
import 'package:vision_dashboard/screens/Student/student_user_details.dart';
import '../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Student_Model.dart';
import '../../responsive.dart';
import '../dashboard/components/date_table.dart';

class StudentUsersScreen extends StatefulWidget {
  StudentUsersScreen({super.key});

  @override
  State<StudentUsersScreen> createState() => _StudentUsersScreenState();
}

class _StudentUsersScreenState extends State<StudentUsersScreen> {
  bool isAdd=false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: StudentViewScreen(),
        ),
        secondChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: StudentInputForm(),
        ),
        crossFadeState: isAdd ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:primaryColor,
        onPressed: () {
          setState(() {
            isAdd = !isAdd;
          });
        },
        child: Icon(!isAdd? Icons.add:Icons.grid_view),
      ),
    );
  }
}
  Widget squrWidget(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
            Text(
              body,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget squrWidget2(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: secondaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
            Text(
              body,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }


