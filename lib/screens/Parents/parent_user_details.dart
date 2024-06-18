import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../controller/event_view_model.dart';
import '../../models/Employee_Model.dart';
import '../../models/Exam_model.dart';
import '../../models/Parent_Model.dart';
import '../../models/event_model.dart';
import '../../models/event_record_model.dart';
import '../../utils/const.dart';
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
  EventModel? selectedEvent;
  TextEditingController bodyEvent = TextEditingController();
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
                    width: Get.width/4.5,
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
                  GetBuilder<EventViewModel>(builder: (eventController) {
                    return Row(
                      children: [
                        SizedBox(
                          width: Get.width / 4.5,
                          child: DropdownButtonFormField<EventModel>(
                            decoration: InputDecoration(
                              labelText: "نوع الحدث",
                              labelStyle: TextStyle(color: primaryColor),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            value: selectedEvent,
                            hint: Text("نوع الحدث"),
                            onChanged: (selectedWay) {
                              if (selectedWay != null) {
                                setState(() {});
                                selectedEvent = selectedWay;
                              }
                            },
                            items: eventController.allEvents.values
                                .toList()
                                .where(
                                  (element) => element.role == Const.eventTypeParent,
                            )
                                .map((e) => DropdownMenuItem(
                              child: Text(e.name),
                              value: e,
                            ))
                                .toList(),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        CustomTextField(controller: bodyEvent, title: 'الوصف', enable: true, keyboardType: TextInputType.text),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                          ),
                          onPressed: () {
                            setState(() {
                              eventRecords.add(EventRecordModel(body: bodyEvent.text, type: selectedEvent!.name, date: DateTime.now().toString().split(" ")[0].toString(), color: selectedEvent!.color.toString()));
                              bodyEvent.clear();
                            });
                          },
                          child: Text('إضافة سجل حدث'),
                        ),
                      ],
                    );
                  }),
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
            SizedBox(height: defaultPadding * 2),
            Text('سجل الأحداث:', style: Styles.headLineStyle1),
            SizedBox(
              height: defaultPadding,
            ),
            Container(
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //     color: secondaryColor,
              //     borderRadius: BorderRadius.circular(15)
              // ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: eventRecords.length,
                itemBuilder: (context, index) {
                  final record = eventRecords[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(color:Color(int.parse(record.color)).withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              record.type,
                              style: Styles.headLineStyle1.copyWith(color: Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              record.body,
                              style: Styles.headLineStyle1.copyWith(color: Colors.black),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              record.date,
                              style: Styles.headLineStyle3,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
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

