import 'dart:io';

import 'package:vision_dashboard/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';

import '../../models/Exam_model.dart';

import '../Widgets/Custom_Text_Filed.dart';

class ExamInputForm extends StatefulWidget {
  @override
  _ExamInputFormState createState() => _ExamInputFormState();
}

class _ExamInputFormState extends State<ExamInputForm> {
  List<String> _selectedSection = [];
  Map<String, String> _selectedStudent = {}; // قائمة الطلاب المُحددين

  // قائمة بكل الطلاب المتاحين
  final Map<String, List<StudentModel>> _allSection = {};
StudentViewModel studentViewModel=Get.find<StudentViewModel>();
  getSectionStudent(){
    for (var a in sectionsList){
      _allSection[a]=studentViewModel.studentMap.values.where((element) => element.section==a,).toList();
      if(_allSection[a]!.isEmpty){
        _allSection.remove(a);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    examId=generateId("Exam");
    getSectionStudent();
  }
  List<String>? _questionImageFile = [], _answerImageFile = [];
  final subjectController = TextEditingController();
  final professorController = TextEditingController();
  final passRateController = TextEditingController();
  final dateController = TextEditingController();
  final studentsController = TextEditingController();
String examId="";
  @override
  void dispose() {
    subjectController.dispose();
    professorController.dispose();
    passRateController.dispose();
    dateController.dispose();
    studentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 25,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(
                      controller: subjectController, title: 'المقرر'),
                  CustomTextField(
                      controller: professorController, title: 'الاستاذ'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          controller: dateController,
                          title: 'التاريخ',
                          enable: false,
                          keyboardType: TextInputType.datetime),
                      IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2100))
                                .then((date) {
                              if (date != null) {
                                dateController.text =
                                    date.toString().split(" ")[0];
                              }
                            });
                          },
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: primaryColor,
                          ))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة ورقة الاسئلة"),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () async {
                                FilePickerResult? _ = await FilePicker.platform
                                    .pickFiles(
                                        type: FileType.image,
                                        allowMultiple: true);
                                if (_ != null) {
                                  _.xFiles.forEach(
                                    (element) async {
                                      _questionImageFile!
                                          .add(await element.path);
                                    },
                                  );
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 200,
                                  width: 200,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                            ...List.generate(
                              _questionImageFile!.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: 200,
                                      height: 200,
                                      child: Image.file(
                                        File(_questionImageFile![index]),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fitHeight,
                                      )),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة ورقة الاجابة"),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () async {
                                FilePickerResult? _ = await FilePicker.platform
                                    .pickFiles(
                                        type: FileType.image,
                                        allowMultiple: true);
                                if (_ != null) {
                                  _.xFiles.forEach(
                                    (element) async {
                                      _answerImageFile!.add(await element.path);
                                    },
                                  );
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 200,
                                  width: 200,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                            ...List.generate(
                              _answerImageFile!.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: 200,
                                      height: 200,
                                      child: Image.file(
                                        File(_answerImageFile![index]),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fitHeight,
                                      )),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomDropDown(
                    value: _selectedSection.length.toString() + "شعبة مختارة",
                    listValue: _allSection.keys.toList(),
                    label: 'اختر الشعب للأضافة',
                    onChange: (value) {
                      print(value);
                      _selectedSection.addIf(
                          !_selectedSection.contains(value), value!);
                      setState(() {});
                    },
                  ),

                ],
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: defaultPadding,
                    ),
                itemCount: _selectedSection.length,
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
                          _selectedSection[parentIndex],
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
                            rows:
                                _allSection[_selectedSection[parentIndex]]!.map(
                              (e) {
                                if(e.available==true)
                                _selectedStudent[e.studentID!] = "0";
                                return studentDataRow(e);
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: defaultPadding,
            ),
            GetBuilder<ExamViewModel>(
              builder: (examController) {
                return ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.all(primaryColor),
                  ),
                  onPressed: () {
                    final exam = ExamModel(
                      id: examId,
                      questionImage: _questionImageFile ?? [],
                      answerImage: _answerImageFile,
                      subject: subjectController.text,
                      professor: professorController.text,
                      date: DateTime.parse(dateController.text),
                      passRate: passRateController.text,
                      marks: _selectedStudent
                    );
                    studentViewModel.addExamToStudent(_selectedStudent.keys.toList(),examId);
                    examController.addExam(exam);

                  },
                  child: Text('حفظ'),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  DataRow studentDataRow(StudentModel student) {
    return DataRow(
      cells: [
        DataCell(Text(student.studentName.toString())),
        DataCell(Text(student.studentNumber.toString())),
        DataCell(Text(student.startDate.toString())),
        DataCell(Text(student.parentId!)),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            print(v);
            student.available = v ?? false;
            if (v == false) {
              _selectedStudent.remove(student.studentID);
              print(_selectedStudent.length);
            }
            setState(() {});
          },
          value: student.available,
        )),
      ],
    );
  }
}
