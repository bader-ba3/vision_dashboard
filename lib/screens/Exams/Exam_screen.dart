
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/screens/Exams/Add_Marks.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Exam_model.dart';

import '../Widgets/header.dart';
import 'Exam_details.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final ScrollController _scrollController = ScrollController();
  List data =   ["المقرر","الأستاذ","التاريخ","الطلاب","علامة النجاح","نسبة النجاح","اضافة علامات",""] ;

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
            appBar:   Header(
                context: context,

                title: 'الامتحانات'.tr,middleText: 'تعرض هذه الواجهة بيانات الامتحانات السابقة مع امكانية اضافة امتحان جديد'.tr),
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
                          List.generate(data.length,(index)=> DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index].toString().tr))))),
                              rows: [
                                for (var exam in examController.examMap.values)
                                  DataRow(cells: [
                                    dataRowItem(size / data.length, exam.subject.toString()),
                                    dataRowItem(size / data.length, exam.professor.toString()),
                                    dataRowItem(size / data.length, exam.date!.toString().split(" ")[0]),
                                    dataRowItem(size / data.length, exam.marks!.keys.length.toString()),
                                    dataRowItem(size / data.length, exam.examPassMark.toString()),
                                    dataRowItem(size / data.length,exam.isDone!?"${exam.passRate}%".toString():"لم يصحح بعد".tr),
                                    dataRowItem(size / data.length, "اضافة".tr,color: Colors.teal,onTap: (){
                                      if(enableUpdate) {
                                          examModel = exam;
                                          examController.changeExamScreen();
                                        }
                                      }),
                                    dataRowItem(size / data.length, "تعديل".tr,color: Colors.blue,onTap: (){

                                      if(enableUpdate)
                                        if(exam.isDone!) {
                                          QuickAlert.show(
                                            width: Get.width/2,
                                              context: context,
                                              type: QuickAlertType.error,
                                              text:
                                                  "لا يمكن تعديل الامتحان بعد التصحيح".tr,title: "خطأ",confirmBtnText: "تم");
                                        }else
                                        showExamInputDialog(context, exam);
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
  void showExamInputDialog(BuildContext context, ExamModel examModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width/1.5,
            child: ExamInputForm(examModel:examModel ,),
          ),
        );
      },
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