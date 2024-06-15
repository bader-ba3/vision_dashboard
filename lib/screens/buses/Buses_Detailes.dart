import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/Bus_Model.dart';
import '../../models/Employee_Model.dart';
import '../Employee/Employee_user_details.dart';
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

  // قائمة بكل الطلاب المتاحين
  final List<String> _allStudents = [
    'طالب 1',
    'طالب 2',
    'طالب 3',
    // أضف المزيد من الطلاب إذا لزم الأمر
  ];

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
    return
       SingleChildScrollView(
        // padding: EdgeInsets.all(16.0),
        child: Wrap(
          clipBehavior: Clip.hardEdge,
          direction: Axis.horizontal,
          runSpacing: 25,
          spacing: 25,
          children: [
            CustomTextField(controller: nameController, title: 'اسم الحافلة'),
            CustomTextField(controller: numberController, title: 'رقم الحافلة'),
            CustomTextField(controller: typeController, title: 'نوع الحافلة'),
            CustomTextField(controller: employeeController, title: 'الموظف'),
            CustomTextField(controller: expenseController, title: 'المصروفات', keyboardType: TextInputType.number),
            CustomTextField(controller: startDateController, title: 'تاريخ البداية', keyboardType: TextInputType.datetime),
            SizedBox(
              width: Get.width / 3.5,
              child: DropdownButtonFormField<String>(
                value: null,
                hint: Text('اختر الطلاب', style: Styles.headLineStyle3),
                onChanged: (selectedStudent) {
                  if (selectedStudent != null) {
                    setState(() {
                      _students.addIf(!_students.contains(selectedStudent), selectedStudent);
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
            SizedBox(height: 16.0),

            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
              ),
              onPressed: () {
                // يمكنك هنا استخدام البيانات المدخلة لإنشاء كائن BusModel
                BusModel bus = BusModel(
                  name: nameController.text,
                  number: numberController.text,
                  type: typeController.text,
                  employee: employeeController.text,
                  students: _students,
                  startDate: DateTime.parse(startDateController.text),
                  expense: double.tryParse(expenseController.text) ?? 0.0,
                  eventRecords: eventRecords,
                );
                // يمكنك تنفيذ الإجراءات التالية مثل إرسال البيانات إلى قاعدة البيانات
                print('Bus Model: $bus');
              },
              child: Text('إرسال', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      )
    ;
  }
}