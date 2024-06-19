import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:vision_dashboard/screens/Exams/Exam_details.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExamScreen extends StatelessWidget {
  ExamScreen({super.key});

  final List<ExamModel> exams = generateRandomExams(10);
  final ScrollController _scrollController = ScrollController();

  DataRow examDataRow(ExamModel exam) {
    return DataRow(
      cells: [
        // DataCell(Image.network(exam.image!, width: 50, height: 50)),
        DataCell(Icon(Icons.image_outlined)),
        // DataCell(Text(exam.image!)),
        DataCell(Text(exam.subject!)),
        DataCell(Text(exam.professor!)),
        DataCell(Text(exam.date.toIso8601String())),
        // DataCell(Text(exam.students.join(', '))),
        DataCell(Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined,color: Colors.white,)),
            Text(exam.students.length.toString()),
          ],
        )),
        DataCell(Text('${exam.passRate!.substring(0,5)[0]}%')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<HomeViewModel>(builder: (controller) {
            return Column(
              children: [
                Row(
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: controller.controlMenu,
                      ),
                    if (!Responsive.isMobile(context))
                      Text(
                        "الامتحانات",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    if (!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: "بحث",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            
                          },
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SvgPicture.asset("assets/icons/Search.svg"),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
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
                        "كل الامتحانات",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Scrollbar(
                          trackVisibility: true,
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: SizedBox(
                              width: Get.width,
                              child: DataTable(
                                clipBehavior: Clip.hardEdge,
                                columns: [
                                  DataColumn(label: Text("صورة")),
                                  DataColumn(label: Text("المقرر")),
                                  DataColumn(label: Text("الأستاذ")),
                                  DataColumn(label: Text("التاريخ")),
                                  DataColumn(label: Text("الطلاب")),
                                  DataColumn(label: Text("نسبة النجاح")),
                                ],
                                rows: exams
                                    .map((exam) => examDataRow(exam))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }



  DataRow workingDriverDataRow(EmployeeModel employeeModel) {
    return DataRow(
      cells: [
        DataCell(Text(employeeModel.fullName.toString())),
        DataCell(Text(employeeModel.mobileNumber.toString())),
        DataCell(Text(employeeModel.address.toString())),
        DataCell(Text(employeeModel.nationality.toString())),
        DataCell(Text(employeeModel.gender.toString())),
        DataCell(Text(employeeModel.age.toString())),
        DataCell(Text(employeeModel.jobTitle.toString())),
        DataCell(Text(employeeModel.salary.toString())),
        DataCell(Text(employeeModel.contract.toString())),
        DataCell(Text(employeeModel.bus.toString())),
        DataCell(Text(employeeModel.startDate.toString())),
        DataCell(Text(employeeModel.eventRecords.toString())),
        DataCell(Row(
          children: [
            IconButton(
              style: ButtonStyle(
                  // foregroundColor: MaterialStatePropertyAll(primaryColor),
                  ),
              onPressed: () {
                // Get.to(()=>UserDetailsScreen(record:record));
              },
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color: primaryColor,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                  // foregroundColor: MaterialStatePropertyAll(primaryColor),
                  ),
              onPressed: () {
                // Get.to(()=>UserDetailsScreen(record:record));
              },
              icon: Icon(
                Icons.mode_edit_outlined,
                color: primaryColor,
              ),
            ),
            IconButton(
              style: ButtonStyle(
                  // foregroundColor: MaterialStatePropertyAll(primaryColor),
                  ),
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline_outlined,
                color: primaryColor,
              ),
            ),
          ],
        )),
      ],
    );
  }

  List<EmployeeModel> listWorkingDriver =
      generateRandomEmployees(20);

  List<PieChartSectionData> paiChartSelectionData = [
    PieChartSectionData(
      color: Colors.teal.withOpacity(0.5),
      value: 50,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.cyan,
      value: 1262,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.green.withOpacity(0.5),
      value: 188,
      showTitle: false,
      radius: 20,
    ),
  ];

  List<PieChartSectionData> sexChartSelectionData = [
    PieChartSectionData(
      color: primaryColor,
      value: 330,
      showTitle: false,
      radius: 20,
    ),
    PieChartSectionData(
      color: Colors.pink.withOpacity(0.5),
      value: 270,
      showTitle: false,
      radius: 20,
    ),
  ];
}
