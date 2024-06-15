import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Student_Model.dart';

import '../Employee/Employee_user_details.dart';

class StudentInputForm extends StatefulWidget {
  @override
  _StudentInputFormState createState() => _StudentInputFormState();
}

class _StudentInputFormState extends State<StudentInputForm> {
  List<String> _exams = []; // قائمة الطلاب المُحددين

  // قائمة بكل الطلاب المتاحين
  final List<String> _allExams = [
    'الامتحات 1',
    'الامتحات 2',
    'الامتحات 3',
    // أضف المزيد من الطلاب إذا لزم الأمر
  ];
  final studentNameController = TextEditingController();
  final studentNumberController = TextEditingController();
  final addressController = TextEditingController();
  final nationalityController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final gradeController = TextEditingController();
  final teachersController = TextEditingController();
  final examsController = TextEditingController();
  final startDateController = TextEditingController();
  final gradesController = TextEditingController();
  final eventRecordsController = TextEditingController();
  final busController = TextEditingController();
  final guardianController = TextEditingController();

  List<Map<String, dynamic>> eventRecords = [];

  @override
  void dispose() {
    studentNameController.dispose();
    studentNumberController.dispose();
    addressController.dispose();
    nationalityController.dispose();
    genderController.dispose();
    ageController.dispose();
    gradeController.dispose();
    teachersController.dispose();
    examsController.dispose();
    startDateController.dispose();
    gradesController.dispose();
    eventRecordsController.dispose();
    busController.dispose();
    guardianController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('نموذج إدخال الطلاب'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
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
                children: <Widget>[
                  CustomTextField(
                      controller: studentNameController, title: "اسم الطالب"),
                  CustomTextField(
                      controller: studentNumberController,
                      title: 'رقم الطالب',
                      keyboardType: TextInputType.phone),
                  CustomTextField(
                      controller: addressController, title: 'العنوان'),
                  CustomTextField(
                      controller: nationalityController, title: 'الجنسية'),
                  CustomTextField(controller: genderController, title: 'الجنس'),
                  CustomTextField(
                      controller: ageController,
                      title: 'العمر',
                      keyboardType: TextInputType.number),
                  CustomTextField(controller: gradeController, title: 'الصف'),
                  CustomTextField(
                      controller: teachersController, title: 'المعلمين'),
               /*   CustomTextField(
                      controller: examsController, title: 'الامتحانات'),*/
                  CustomTextField(
                      controller: startDateController,
                      title: 'تاريخ البداية',
                      keyboardType: TextInputType.datetime),
                /*  CustomTextField(
                      controller: gradesController, title: 'الدرجات'),*/
                  CustomTextField(
                      controller: eventRecordsController, title: 'سجل الأحداث'),
                  CustomTextField(controller: busController, title: 'الحافلة'),
                  CustomTextField(
                      controller: guardianController, title: 'ولي الأمر'),
           /*       DropdownButtonFormField<String>(
                    value: null,
                    hint: Text('اختر الاختبارات'),
                    onChanged: (selectedStudent) {
                      if (selectedStudent != null) {
                        setState(() {
                          _exams.addIf(!_exams.contains(selectedStudent),selectedStudent);
                        });
                      }
                    },
                    items: _allExams.map((student) {
                      return DropdownMenuItem(
                        value: student,
                        child: Text(student),
                      );
                    }).toList(),
                  ),*/
/*
                  SizedBox(height: 16.0),

                  // عرض الطلاب المحددين
                  Text(
                    'الاختبارات المحددين:',
                    style: TextStyle(fontSize: 16),
                  ),*/
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    children: _exams.map((student) {
                      return Chip(
                        backgroundColor: Colors.white,

                        label: Text(student,style: Styles.headLineStyle2,),
                        onDeleted: () {
                          setState(() {
                            _exams.remove(student);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                        ),
                        onPressed: () {
                          setState(() {
                            eventRecords.add({
                              'event': eventRecordsController.text,
                              'date': DateTime.now().toString(),
                            });
                            eventRecordsController.clear();
                          });
                        },
                        child: Text('إضافة سجل حدث'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                        ),
                        onPressed: () {
                          final student = StudentModel(
                            studentName: studentNameController.text,
                            studentNumber: studentNumberController.text,
                            address: addressController.text,
                            nationality: nationalityController.text,
                            gender: genderController.text,
                            age: ageController.text,
                            grade: gradeController.text,
                            teachers: [teachersController.text],
                            exams: [ExamModel(date: DateTime.now(),image: "",passRate: "",professor: "",students: [""],subject: "")],
                            startDate: DateTime.parse(startDateController.text),
                            grades: {
                              'subject1': double.parse(gradesController.text)
                            },
                            eventRecords: [EventRecordModel(event: "event", date: DateTime.now())],
                            bus: busController.text,
                            guardian: guardianController.text,
                          );
                          print('بيانات الطالب: $student');
                        },
                        child: Text('إرسال'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            SizedBox(height: defaultPadding * 2),
            Text('سجل الأحداث:', style: Styles.headLineStyle1),
            SizedBox(
              height: defaultPadding,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: eventRecords.length,
                itemBuilder: (context, index) {
                  final record = eventRecords[index];
                  return ListTile(
                    title: Text(
                      record['event'],
                      style: Styles.headLineStyle1,
                    ),
                    subtitle: Text(
                      record['date'],
                      style: Styles.headLineStyle3,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
