import 'dart:io';

import 'package:vision_dashboard/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
  List<String> _students = []; // قائمة الطلاب المُحددين

  // قائمة بكل الطلاب المتاحين
  final List<String> _allStudents = [
    'طالب 1',
    'طالب 2',
    'طالب 3',
    // أضف المزيد من الطلاب إذا لزم الأمر
  ];
  File? _imageFile;
  final subjectController = TextEditingController();
  final professorController = TextEditingController();
  final passRateController = TextEditingController();
  final dateController = TextEditingController();
  final studentsController = TextEditingController();

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
    return SingleChildScrollView(
      // padding: EdgeInsets.all(16.0),
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
                // CustomTextField(controller: imageController, title: "صورة"),

                CustomTextField(controller: subjectController, title: 'المقرر'),
                CustomTextField(
                    controller: professorController, title: 'الاستاذ'),
                CustomTextField(
                    controller: passRateController,
                    title: 'نسبة النجاح',
                    keyboardType: TextInputType.number),
                CustomTextField(
                    controller: dateController,
                    title: 'التاريخ',
                    keyboardType: TextInputType.datetime),
            /*    CustomTextField(
                    controller: studentsController, title: 'الطلاب'),*/
                DropdownButtonFormField<String>(
                  value: null,
                  hint: Text('اختر الطلاب'),
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

                      label: Text(student,style: Styles.headLineStyle2,),
                      onDeleted: () {
                        setState(() {
                          _students.remove(student);
                        });
                      },
                    );
                  }).toList(),
                ),
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
        ],
      ),
    );
  }
}
