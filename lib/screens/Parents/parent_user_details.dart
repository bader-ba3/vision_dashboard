import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../models/Employee_Model.dart';
import '../../models/Exam_model.dart';
import '../../models/Parent_Model.dart';
import '../Employee/Employee_user_details.dart';
import '../Widgets/Custom_Text_Filed.dart';

class ParentInputForm extends StatefulWidget {
  @override
  _ParentInputFormState createState() => _ParentInputFormState();
}

class _ParentInputFormState extends State<ParentInputForm> {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final nationalityController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final startDateController = TextEditingController();
  List<String> children = [];
  List<String> selectedChildren = [];
  List<ExamModel> exams = [];
  List<EventRecordModel> eventRecords = [];
  List<String> _children = []; // قائمة الأطفال المُحددين

  // قائمة بكل الأطفال المتاحين
  final List<String> _allChildren = [
    'طفل 1',
    'طفل 2',
    'طفل 3',
    // أضف المزيد من الأطفال إذا لزم الأمر
  ];

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
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(controller: fullNameController, title: 'الاسم الكامل'),
              CustomTextField(controller: numberController, title: 'رقم الهاتف'),
              CustomTextField(controller: addressController, title: 'العنوان'),
              CustomTextField(controller: nationalityController, title: 'الجنسية'),
              CustomTextField(controller: genderController, title: 'الجنس'),
              CustomTextField(controller: ageController, title: 'العمر', keyboardType: TextInputType.number),
              CustomTextField(controller: startDateController, title: 'تاريخ البداية', keyboardType: TextInputType.datetime),
              SizedBox(
                width: Get.width/3.5,
                child: DropdownButtonFormField<String>(
                  value: null,
                  hint: Text('اختر الأطفال',style: Styles.headLineStyle3,),
                  onChanged: (selectedChild) {
                    if (selectedChild != null) {
                      setState(() {
                        _children.addIf(!_children.contains(selectedChild), selectedChild);
                      });
                    }
                  },
                  items: _allChildren.map((child) {
                    return DropdownMenuItem(
                      value: child,
                      child: Text(child),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.0),

              // عرض الأطفال المحددين
              Text(
                'الأطفال المحددين:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: _children.map((child) {
                  return Chip(
                    backgroundColor: Colors.white,
                    label: Text(child, style: Styles.headLineStyle2),
                    onDeleted: () {
                      setState(() {
                        _children.remove(child);
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),

              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(primaryColor)
                ),
                onPressed: () {
                  // يمكنك هنا استخدام البيانات المدخلة لإنشاء كائن ParentModel
                  ParentModel parent = ParentModel(
                    fullName: fullNameController.text,
                    number: numberController.text,
                    address: addressController.text,
                    work: nationalityController.text,
                    // gender: genderController.text,
                    // age: int.tryParse(ageController.text) ?? 0,
                    // children: selectedChildren,
                    // parentID: DateTime.parse(startDateController.text),
                    // exams: exams,
                    eventRecords: eventRecords,
                  );
                  // يمكنك تنفيذ الإجراءات التالية مثل إرسال البيانات إلى قاعدة البيانات
                  print('Parent Model: $parent');
                },
                child: Text('إرسال',style:TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

