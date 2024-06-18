import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:vision_dashboard/screens/Student/student_user_details.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Student_Model.dart';
import '../../responsive.dart';

class StudentViewScreen extends StatefulWidget {
  const StudentViewScreen({super.key});

  @override
  State<StudentViewScreen> createState() => _StudentViewScreenState();
}

class _StudentViewScreenState extends State<StudentViewScreen> {
  final List<StudentModel> students = generateRandomStudents(10);
  final ScrollController _scrollController = ScrollController();
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
                        "الطلاب",
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
                              onTap: () {},
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
                SizedBox(height: defaultPadding),
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
                        "كل المستخدمين",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            clipBehavior: Clip.hardEdge,
                            physics: ClampingScrollPhysics(),
                            controller: _scrollController,
                            child: DataTable(
                              clipBehavior: Clip.hardEdge,
                              columns: [
                                DataColumn(label: Text("اسم الطالب")),
                                DataColumn(label: Text("رقم الطالب")),
                                DataColumn(label: Text("العنوان")),
                                DataColumn(label: Text("الجنس")),
                                DataColumn(label: Text("العمر")),
                                DataColumn(label: Text("الصف")),
                                DataColumn(label: Text("المعلمين")),
                                DataColumn(label: Text("تاريخ البداية")),
                                DataColumn(label: Text("سجل الاحداث")),
                                DataColumn(label: Text("الحافلة")),
                                DataColumn(label: Text("ولي الأمر")),
                              ],
                              rows: students.map((student) => studentDataRow(student)).toList(),
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

  DataRow studentDataRow(StudentModel student) {
    return DataRow(
      cells: [
        DataCell(Text(student.studentName.toString())),
        DataCell(Text(student.studentNumber.toString())),
        DataCell(Text(student.studentID.toString())),
        DataCell(Text(student.StudentBirthDay.toString())),
        DataCell(Text(student.gender.toString())),
        DataCell(Text(student.StudentBirthDay.toString())),
        DataCell(Text(student.grade.toString())),
        DataCell(Text(student.startDate!.toIso8601String())),
        DataCell(Text(student.eventRecords!
            .map((event) => event.body)
            .join(', '))),
        DataCell(Text(student.bus!)),
        DataCell(Text(student.parentModel!.parentID!)),
      ],
    );
  }
}
