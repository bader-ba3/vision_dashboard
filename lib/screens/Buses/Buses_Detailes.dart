import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/Bus_Model.dart';
import '../../models/Employee_Model.dart';
import '../../models/Student_Model.dart';
import '../../models/event_record_model.dart';
import '../Widgets/Custom_Text_Filed.dart';

class BusInputForm extends StatefulWidget {
  @override
  _BusInputFormState createState() => _BusInputFormState();
}

class _BusInputFormState extends State<BusInputForm> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final typeController = TextEditingController();
  final employeeController = TextEditingController();
  final startDateController = TextEditingController();
  final expenseController = TextEditingController();
  List<String> students = [];
  List<String> selectedStudents = [];
  List<EventRecordModel> eventRecords = [];
  List<String> _students = [];

  final Map<String, List<StudentModel>> _allSection = {
    "الشعبة الاولى": [
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
    ],
    "الشعبة الثانية": [
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
    ],
    "الشعبة الثالثة": [
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
    ]
  };
  final Map<String, List<EmployeeModel>> _allEmployee = {
    "الاساتذة": [
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
generateRandomEmployees(1).first,
    ],
    "الاداريين": [
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
    ],
    "الموظفين": [
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
      generateRandomEmployees(1).first,
    ],
  };

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    typeController.dispose();
    employeeController.dispose();
    startDateController.dispose();
    expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(25.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Wrap(
                  clipBehavior: Clip.hardEdge,
                  direction: Axis.horizontal,
                  runSpacing: 50,
                  spacing: 25,
                  children: [
                    CustomTextField(
                        controller: nameController, title: 'اسم الحافلة'),
                    CustomTextField(
                        controller: numberController, title: 'رقم الحافلة'),
                    CustomTextField(
                        controller: typeController, title: 'نوع الحافلة'),
                    CustomTextField(
                        controller: employeeController, title: 'الموظف'),
                    CustomTextField(
                        controller: expenseController,
                        title: 'المصروفات',
                        keyboardType: TextInputType.number),
                    CustomTextField(
                        controller: startDateController,
                        title: 'تاريخ البداية',
                        keyboardType: TextInputType.datetime),

                    /*    SizedBox(
                    width: Get.width / 3.5,
                    child: DropdownButtonFormField<String>(
                      value: null,
                      hint: Text('اختر الطلاب', style: Styles.headLineStyle3),
                      onChanged: (selectedStudent) {
                        if (selectedStudent != null) {
                          setState(() {
                            _students.addIf(
                                !_students.contains(selectedStudent),
                                selectedStudent);
                          });
                        }
                      },
                      items: _allStudents.map((student) {
                        return DropdownMenuItem(
                          value: student,
                          child: Text(student),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.0),

                  // عرض الطلاب المحددين
                  Text(
                    'الطلاب المحددين:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: _students.map((student) {
                      return Chip(
                        backgroundColor: Colors.white,
                        label: Text(student, style: Styles.headLineStyle2),
                        onDeleted: () {
                          setState(() {
                            _students.remove(student);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),*/

                  ],
                ),
              ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: defaultPadding*2,
                      ),
                      itemCount: _allSection.keys.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, parentIndex) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _allSection.keys.toList()[parentIndex],
                                style: Styles.headLineStyle1,
                              ),
                              SizedBox(
                                height: defaultPadding,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: DataTable(
                                  clipBehavior: Clip.hardEdge,
                                  columns: [
                                    DataColumn(label: Text("اسم الطالب")),
                                    DataColumn(label: Text("رقم الطالب")),
                                    DataColumn(label: Text("تاريخ البداية")),
                                    DataColumn(label: Text("ولي الأمر")),
                                    DataColumn(label: Text("موجود")),
                                  ],
                                  rows: _allSection[_allSection.keys
                                      .toList()[parentIndex]]!
                                      .map(
                                        (e) => studentDataRow(e),
                                  )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: defaultPadding*2,
                      ),
                      itemCount: _allEmployee.keys.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, parentIndex) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _allEmployee.keys.toList()[parentIndex],
                                style: Styles.headLineStyle1,
                              ),
                              SizedBox(
                                height: defaultPadding,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: DataTable(
                                  clipBehavior: Clip.hardEdge,
                                  columns: [
                                    DataColumn(label: Text("اسم الموظف")),
                                    DataColumn(label: Text("العنوان")),
                                    DataColumn(label: Text("تاريخ البداية")),
                                    DataColumn(label: Text("الجنس")),
                                    DataColumn(label: Text("موجود")),
                                  ],
                                  rows: _allEmployee.values.toList()[parentIndex]
                                      .map(
                                        (e) => employeeDataRow(e),
                                  )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      WidgetStateProperty.all(primaryColor),
                    ),
                    onPressed: () {
                      BusModel bus = BusModel(
                        name: nameController.text,
                        number: numberController.text,
                        type: typeController.text,
                        employee: employeeController.text,
                        students: _students,
                        startDate: DateTime.parse(startDateController.text),
                        expense:
                        double.tryParse(expenseController.text) ?? 0.0,
                        eventRecords: eventRecords,
                      );
                      // يمكنك تنفيذ الإجراءات التالية مثل إرسال البيانات إلى قاعدة البيانات
                      print('Bus Model: $bus');
                    },
                    child: Text('حفظ', style: TextStyle(color: Colors.white)),
                  ),
            ])));
  }

  DataRow studentDataRow(StudentModel student) {
    return DataRow(
      cells: [
        DataCell(Text(student.studentName.toString())),
        DataCell(Text(student.studentNumber.toString())),
        DataCell(Text(student.startDate!)),
        DataCell(Text(student.parentId!)),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            print(v);
            student.available = v ?? false;
            setState(() {});
          },
          value: student.available,
        )),
      ],
    );
  }
  DataRow employeeDataRow(EmployeeModel employee) {
    return DataRow(
      cells: [
        DataCell(Text(employee.fullName.toString())),
        DataCell(Text(employee.address.toString())),
        DataCell(Text(employee.startDate!.toString())),
        DataCell(Text(employee.gender.toString())),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            print(v);
            employee.available = v ?? false;
            setState(() {});
          },
          value: employee.available,
        )),
      ],
    );
  }
}
