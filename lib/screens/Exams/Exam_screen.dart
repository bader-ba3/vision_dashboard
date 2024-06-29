
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Exams/Add_Marks.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Exam_model.dart';

import '../Widgets/header.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final ScrollController _scrollController = ScrollController();
  List data =   ["المقرر","الأستاذ","التاريخ","الطلاب","علامة النجاح","نسبة النجاح","صورة","اضافة علامات"] ;

  bool addMarks=Get.find<ExamViewModel>().addMarks;
   ExamModel? examModel=ExamModel();
   // String examName="";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamViewModel>(
      builder: (examController) {

        return AnimatedCrossFade(firstChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: Scaffold(
            appBar:   Header(title: 'الامتحانات',),
            body: SingleChildScrollView(
              child: GetBuilder<HomeViewModel>(builder: (controller) {
                double size = max(MediaQuery.sizeOf(context).width - (controller.isDrawerOpen?240:120), 1000)-60;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SizedBox(
                      width: size+60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columnSpacing: 0,
                              dividerThickness: 0.3,

                              columns:
                          List.generate(data.length,(index)=> DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))),
                              rows: [
                                for (var exam in examController.examMap.values)
                                  DataRow(cells: [
                                    dataRowItem(size / data.length, exam.subject.toString()),
                                    dataRowItem(size / data.length, exam.professor.toString()),
                                    dataRowItem(size / data.length, exam.date!.toString().split(" ")[0]),
                                    dataRowItem(size / data.length, exam.marks!.keys.length.toString()),
                                    dataRowItem(size / data.length, exam.examPassMark.toString()),
                                    dataRowItem(size / data.length, exam.passRate!>0?"${exam.passRate}%".toString():"${exam.passRate}%"),
                                    dataRowItem(size / data.length, "عرض",color: Colors.blue,onTap: (){}),
                                    dataRowItem(size / data.length, "اضافة",color: Colors.teal,onTap: (){
                                      if(enableUpdate) {
                                          examModel = exam;
                                          examController.changeExamScreen();
                                        }
                                      }),

                                  ]),
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ), secondChild: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height),
            child: AddMarks(examModel:examModel!)), crossFadeState: examController.addMarks?CrossFadeState.showSecond:CrossFadeState.showFirst, duration: Durations.short4);
        // return examController.addMarks!=true? :;
      }
    );
  }

  dataRowItem(size, text, {onTap, color}) {
    return DataCell(
      Container(
        width: size ,
        child: InkWell(
            onTap: onTap,
            child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: color == null ? null : TextStyle(color: color),
                ))),
      ),
    );
  }
}