import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/event_view_model.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Drop_down.dart';
import '../Widgets/Custom_Text_Filed.dart';

class EmployeeInputForm extends StatefulWidget {
  @override
  _EmployeeInputFormState createState() => _EmployeeInputFormState();
}

class _EmployeeInputFormState extends State<EmployeeInputForm> {
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  final nationalityController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final jobTitleController = TextEditingController();
  final salaryController = TextEditingController();
  final contractController = TextEditingController();
  final busController = TextEditingController();
  final startDateController = TextEditingController();
  final eventController = TextEditingController();
  final dateController = TextEditingController();

  List<Map<String, dynamic>> eventRecords = [];

  @override
  void dispose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    nationalityController.dispose();
    genderController.dispose();
    ageController.dispose();
    jobTitleController.dispose();
    salaryController.dispose();
    contractController.dispose();
    busController.dispose();
    startDateController.dispose();
    eventController.dispose();
    dateController.dispose();
    super.dispose();
  }
  String? _selectedEvent;
  TextEditingController _bodyEvent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

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
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Wrap(
                clipBehavior: Clip.hardEdge,
                direction: Axis.horizontal,

                runSpacing: 50,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(controller: fullNameController, title: "الاسم الكامل"),
                  CustomTextField(controller: mobileNumberController, title: 'رقم الموبايل', keyboardType: TextInputType.phone),
                  CustomTextField(controller: addressController, title: 'العنوان'),
                  CustomTextField(controller: nationalityController, title: 'الجنسية'),
                  CustomTextField(controller: genderController, title: 'الجنس'),
                  CustomTextField(controller: ageController, title: 'العمر', keyboardType: TextInputType.number),
                  CustomTextField(controller: jobTitleController, title: 'الوظيفة'),
                  CustomTextField(controller: salaryController, title: 'الراتب', keyboardType: TextInputType.number),
                  CustomTextField(controller: contractController, title: 'العقد'),
                  CustomTextField(controller: busController, title: 'الحافلة'),
                  CustomTextField(controller: startDateController, title: 'تاريخ البداية', keyboardType: TextInputType.datetime),
                  CustomTextField(controller: eventController, title: 'الحدث'),
                  CustomTextField(controller: dateController, title: 'التاريخ', keyboardType: TextInputType.datetime),
                  GetBuilder<EventViewModel>(builder: (eventController) {
                    return Row(
                      children: [
                        CustomDropDown(value: _selectedEvent.toString(), listValue: eventController.allEvents.values.toList().where((element) => element.role == Const.eventTypeStudent,).map((e) => e.name,).toList(), label: "نوع الحدث",onChange: (selectedWay) {
                          if (selectedWay != null) {
                            setState(() {
                            });
                            _selectedEvent = selectedWay;
                          }
                        },),
                        SizedBox(width: 16.0),
                        CustomTextField(
                            controller: _bodyEvent,
                            title: 'الوصف',
                            enable: true,
                            keyboardType: TextInputType.text),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                          ),
                          onPressed: () {
                            setState(() {

                              eventRecords.add({
                                'event': _selectedEvent.toString() +" "+ _bodyEvent.text,
                                'date': DateTime.now().toString().split(" ")[0].toString(),
                              });
                              _bodyEvent.clear();
                            });
                          },
                          child: Text('إضافة سجل حدث'),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 8.0),

                ],
              ),
            ),
            SizedBox(height: defaultPadding*2,),
            Text('سجل الأحداث:', style: Styles.headLineStyle1),
            SizedBox(height: defaultPadding,),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: eventRecords.length,
                itemBuilder: (context, index) {
                  final record = eventRecords[index];
                  return ListTile(
                    title: Text(record['event'],style: Styles.headLineStyle1,),
                    subtitle: Text(record['date'],style: Styles.headLineStyle3,),
                  );
                },
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all(Colors.white),
                backgroundColor: WidgetStateProperty.all(primaryColor),
              ),
              onPressed: () {
                /*       final exam = ExamModel(
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
                print('بيانات الامتحان: $exam');*/
              },
              child: Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}


