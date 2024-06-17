import 'dart:io';

import 'package:vision_dashboard/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';

import '../../models/Exam_model.dart';
import '../Employee/Employee_user_details.dart';
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

  List<Map<String, List<String>>> _selectedSection = []; // قائمة الطلاب المُحددين

  // قائمة بكل الطلاب المتاحين
  final List<Map<String, List<String>>> _allSection = [
    {
      "Section1": [
        'طالب 1',
        'طالب 2',
        'طالب 3',
      ]
    },
    {
      "Section2": [
        'طالب 1',
        'طالب 2',
        'طالب 3',
      ]
    },
    {
      "Section3": [
        'طالب 1',
        'طالب 2',
        'طالب 3',
      ]
    }
  ];
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
        child: Container(
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
              // CustomTextField(controller: imageController, title: "صورة"),

              CustomTextField(controller: subjectController, title: 'المقرر'),
              CustomTextField(
                  controller: professorController, title: 'الاستاذ'),
              CustomTextField(
                  controller: dateController,
                  title: 'التاريخ',
                  keyboardType: TextInputType.datetime),
              /*    CustomTextField(
                  controller: studentsController, title: 'الطلاب'),*/
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("صورة الفاتورة"),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        InkWell(
                          onTap: () async {
                            FilePickerResult? _ = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
                            if (_ != null) {
                              _.xFiles.forEach((element) async {
                                ImagesTempData.add(await element.path);
                              },);
                              setState(() {});
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                              height: 200,
                              width: 200,
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                        ...List.generate(ImagesTempData.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                                width: 200,
                                height: 200,
                                child: Image.file(File(ImagesTempData[index]), height: 200, width: 200, fit: BoxFit.fitHeight,)),
                          );
                        },)
                      ],
                    ),
                  ),
                ],
              ),
/*
              ...List.generate(ImagesTempData.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                      width: 200,
                      height: 200,
                      child: Image.file(File(ImagesTempData[index]), height: 200, width: 200, fit: BoxFit.fitHeight,)),
                );
              },),
*/
              CustomDropDown(
                value: _selectedSection
                    .map(
                      (e) => e,
                    )
                    .toString(),
                listValue: _allSection.map((e) => e.keys.toString(),).toList(),
                label: 'اضف شعبة',
                onChange: (value) {
                  print(value);
                  // _selectedSection.addIf(
                      // !_selectedSection.contains(_allSection), value.toString());
                  setState(() {});
                },
              )
              /*   DropdownButtonFormField<String>(
                value: null,
                hint: Text('اختر الشعبة'),
                onChanged: (selectedStudent) {
                  if (selectedStudent != null) {
                    setState(() {
                      _students.addIf(!_students.contains(selectedStudent),selectedStudent);
                    });
                  }
                },
                items: _allStudents.map((student) {
                  return DropdownMenuItem(
                    value: student,
                    child: Text(student),
                  );
                }).toList(),
              ),*/
              ,
              SizedBox(height: 16.0),

          /*    // عرض الطلاب المحددين
              Text(
                'الطلاب المحددين:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: _selectedSection.map((student) {
                  return Chip(
                    backgroundColor: Colors.white,
                    label: Text(
                      student,
                      style: Styles.headLineStyle2,
                    ),
                    onDeleted: () {
                      setState(() {
                        _selectedSection.remove(student);
                      });
                    },
                  );
                }).toList(),
              ),*/
              SizedBox(height: 16.0),
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
                child: Text('إرسال'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  backgroundColor: WidgetStateProperty.all(primaryColor),
                ),
                onPressed: _openImagePicker,
                child: Text('تحميل الصورة'),
              ),
              if (_imageFile != null)
                Text(
                  'الصورة المحددة: ${_imageFile!.path}',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
