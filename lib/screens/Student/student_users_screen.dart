import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Student_Model.dart';
import '../Widgets/header.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final List<StudentModel> students = generateRandomStudents(10);
  final ScrollController _scrollController = ScrollController();
  List data =   ["اسم الطالب","رقم الطالب","العنوان","الجنس","العمر","الصف","المعلمين","تاريخ البداية","الحافلة","ولي الأمر"] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   Header(title: 'الطلاب',),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "كل الطلاب",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: size+60,
                    child: Scrollbar(
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(columnSpacing: 0, columns:
                        List.generate(data.length,(index)=> DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))),
                            rows: [
                              for (var j in students)
                                DataRow(cells: [
                                  dataRowItem(size / data.length, j.studentName.toString()),
                                  dataRowItem(size / data.length, j.studentNumber.toString()),
                                  dataRowItem(size / data.length, j.studentID.toString()),
                                  dataRowItem(size / data.length, j.gender.toString()),
                                  dataRowItem(size / data.length, j.StudentBirthDay.toString()),
                                  dataRowItem(size / data.length, j.grade.toString()),
                                  dataRowItem(size / data.length, j.grade.toString()),
                                  dataRowItem(size / data.length, j.startDate.toString().split(" ")[0]),
                                  dataRowItem(size / data.length, j.bus.toString()),
                                  dataRowItem(size / data.length, j.parentId.toString()),
                                ]),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
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
}