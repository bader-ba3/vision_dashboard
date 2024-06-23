import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Text_Filed.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../Widgets/header.dart';
import 'controller/Exam_View_Model.dart';

class AddMarks extends StatefulWidget {
  const AddMarks({super.key,required this.examModel});

  @override
  State<AddMarks> createState() => _AddMarksState();

 final ExamModel examModel;
}

class _AddMarksState extends State<AddMarks> {
  final ScrollController _scrollController = ScrollController();
  List data =   ["اسم الطالب","العلامة"] ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   Header(title: 'اضافة علامات للطلاب',),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(MediaQuery.sizeOf(context).width - (controller.isDrawerOpen?240:120), 1000)-60;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "كل الطلاب الذين يحق لهم دخول امتحان ال${widget.examModel.subject}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: size+60,
                        child: Scrollbar(
                          controller: _scrollController,
                          child: GetBuilder<ExamViewModel>(
                              builder: (examController) {
                                return SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(columnSpacing: 0, columns:
                                  List.generate(data.length,(index)=> DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))),
                                      rows: [
                                        for (var exam in widget.examModel.marks?.keys??[])
                                          DataRow(cells: [
                                            dataRowItem(size / data.length, Get.find<StudentViewModel>().studentMap[exam]!.studentName.toString()),
                                            dataRowItemText(size / data.length, widget.examModel.marks![exam.toString()],onChange: (value){
                                              widget.examModel.marks![exam.toString()]=value;
                                            } ),
                                          ]),
                                      ]),
                                );
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: defaultPadding,),
                GetBuilder<ExamViewModel>(
                  builder: (controller) {
                    return ElevatedButton(
                      style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white), backgroundColor: WidgetStateProperty.all(primaryColor)),
                      onPressed: () {
                        widget.examModel.marks!.forEach((key, value) {
                          print("key $key---------------vl $value");
                        },);
                        controller.addMarkExam(widget.examModel.marks!, widget.examModel.id!);
                        controller.changeExamScreen();
                      },
                      child: Text('حفظ'),
                    );
                  }
                ),
              ],
            ),
          );
        }),
      ),
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
  dataRowItemText(size, text, { color,onChange}) {
TextEditingController controller =TextEditingController();
controller.text=text;
    return DataCell(
      Container(
        width: size ,
        padding: EdgeInsets.symmetric(horizontal: size/4,vertical: 5),
        child:CustomTextField(title: "",controller: controller,hint:text ,onChange:onChange,),
      ),
    );
  }
}
