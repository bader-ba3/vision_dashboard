// import 'package:vision_dashboard/controller/delete_management_view_model.dart';
// import 'package:vision_dashboard/models/Employee_Model.dart';
// import 'package:vision_dashboard/models/Exam_model.dart';
// import 'package:vision_dashboard/responsive.dart';
// import 'package:vision_dashboard/screens/Exams/Exam_details.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vision_dashboard/screens/Widgets/header.dart';
// import '../../constants.dart';
// import 'package:vision_dashboard/controller/home_controller.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class ExamScreen extends StatelessWidget {
//   ExamScreen({super.key});
//
//   final List<ExamModel> exams = generateRandomExams(10);
//   final ScrollController _scrollController = ScrollController();
//
//   DataRow examDataRow(ExamModel exam) {
//     return DataRow(
//       cells: [
//         DataCell(Icon(Icons.image_outlined)),
//         DataCell(Text(exam.subject!)),
//         DataCell(Text(exam.professor!)),
//         DataCell(Text(exam.date.toIso8601String())),
//         DataCell(Row(
//           children: [
//             IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined,color: Colors.white,)),
//             Text(exam.students.length.toString()),
//           ],
//         )),
//         DataCell(Text('${exam.passRate!.substring(0,5)[0]}%')),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           primary: false,
//           padding: EdgeInsets.all(defaultPadding),
//           child: GetBuilder<HomeViewModel>(builder: (controller) {
//             return Column(
//               children: [
//                 Header(title: "الامتحانات"),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(defaultPadding),
//                   decoration: BoxDecoration(
//                     color: secondaryColor,
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "كل الامتحانات",
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                       Container(
//                         width: MediaQuery.sizeOf(context).width,
//                         child: Scrollbar(
//                           trackVisibility: true,
//                           controller: _scrollController,
//                           child: SingleChildScrollView(
//                             physics: ClampingScrollPhysics(),
//                             scrollDirection: Axis.horizontal,
//                             controller: _scrollController,
//                             child: Directionality(
//                               textDirection: TextDirection.rtl,
//                               child: DataTable(
//                                 clipBehavior: Clip.hardEdge,
//                                 columns: [
//                                   DataColumn(label: Text("صورة")),
//                                   DataColumn(label: Text("المقرر")),
//                                   DataColumn(label: Text("الأستاذ")),
//                                   DataColumn(label: Text("التاريخ")),
//                                   DataColumn(label: Text("الطلاب")),
//                                   DataColumn(label: Text("نسبة النجاح")),
//                                 ],
//                                 rows: exams
//                                     .map((exam) => examDataRow(exam))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Exam_model.dart';
import '../../models/Student_Model.dart';
import '../../responsive.dart';
import '../Widgets/filtering_data_grid.dart';
import '../Widgets/header.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final List<StudentModel> students = generateRandomStudents(10);
  final ScrollController _scrollController = ScrollController();
  List data =   ["المقرر","الأستاذ","التاريخ","الطلاب","نسبة النجاح","صورة"] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "كل الامتحانات",
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
                              for (var exam in generateRandomExams(6))
                                DataRow(cells: [
                                  dataRowItem(size / data.length, exam.subject!.toString()),
                                  dataRowItem(size / data.length, exam.professor.toString()),
                                  dataRowItem(size / data.length, exam.date!.toIso8601String().toString()),
                                  dataRowItem(size / data.length, exam.students!.length.toString()),
                                  dataRowItem(size / data.length, '${exam.passRate!.substring(0,5)[0]}%'),
                                  dataRowItem(size / data.length, "عرض",color: Colors.purpleAccent),

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