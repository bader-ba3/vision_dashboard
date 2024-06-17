import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Exams/Exam_details.dart';
import 'package:vision_dashboard/screens/Exams/Exam_screen.dart';

import '../../constants.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView>{
  bool isAdd=false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: ExamScreen(),
        ),
        secondChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: ExamInputForm(),
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
