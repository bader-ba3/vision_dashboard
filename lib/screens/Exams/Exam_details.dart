import 'dart:io';

import 'package:vision_dashboard/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';

import '../../models/Exam_model.dart';

import '../Widgets/Custom_Text_Filed.dart';

class ExamInputForm extends StatefulWidget {
  @override
  _ExamInputFormState createState() => _ExamInputFormState();
}

class _ExamInputFormState extends State<ExamInputForm> {
  void _openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png'
      ], // تحديد امتدادات الصور المسموح بها
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    } else {
      Fluttertoast.showToast(
        msg: "لم يتم اختيار أي ملف!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  List<String> _selectedSection = []; // قائمة الطلاب المُحددين

  // قائمة بكل الطلاب المتاحين
  final Map<String, List<StudentModel>> _allSection = {
    "الشعبة الاولى": [
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
    ],
    "الشعبة الثانية": [
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
    ],
    "الشعبة الثالثة": [
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
      generateRandomStudents(1).first,
    ]
  };

  File? _imageFile;
  final subjectController = TextEditingController();
  final professorController = TextEditingController();
  final passRateController = TextEditingController();
  final dateController = TextEditingController();
  final studentsController = TextEditingController();
  List<String> ImagesTempData = [];

  @override
  void dispose() {
    // imageController.dispose();
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
                direction: Axis.horizontal,
                runSpacing: 25,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(
                      controller: subjectController, title: 'المقرر'),
                  CustomTextField(
                      controller: professorController, title: 'الاستاذ'),
                  CustomTextField(
                      controller: dateController,
                      title: 'التاريخ',
                      keyboardType: TextInputType.datetime),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة الفاتورة"),
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
                                      ImagesTempData.add(await element.path);
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
                              ImagesTempData.length,
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
                                        File(ImagesTempData[index]),
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
                  SizedBox(height: 16.0),
                  SizedBox(height: 16.0),

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
                            rows: _allSection[_selectedSection[parentIndex]]!
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
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(primaryColor),
              ),
              onPressed: () {
                final exam = ExamModel(
                  image: _imageFile?.path ?? "",
                  subject: subjectController.text,
                  professor: professorController.text,
                  date: DateTime.parse(dateController.text),
                  students: studentsController.text
                      .split(',')
                      .map((student) => student.trim())
                      .toList(),
                  passRate: passRateController.text,
                );
                print('بيانات الامتحان: $exam');
              },
              child: Text('حفظ'),
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
        DataCell(Text(student.startDate!.toIso8601String())),
        DataCell(Text(student.parentModel!.fullName!)),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            print(v);
            student.available = v??false;
setState(() {
});
          },
          value: student.available,
        )),
      ],
    );
  }

}

