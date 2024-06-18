import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/event_model.dart';

import '../../controller/event_view_model.dart';
import '../../models/event_record_model.dart';
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
  final bodyEvent = TextEditingController();
  EventModel? selectedEvent;
  List<EventRecordModel> eventRecords = [];

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
    bodyEvent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('نموذج إدخال الموظفين'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(15)),
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
                  CustomTextField(controller: dateController, title: 'التاريخ', keyboardType: TextInputType.datetime),
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
                                  (element) => element.role == Const.eventTypeEmployee,
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
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white), backgroundColor: WidgetStateProperty.all(primaryColor)),
                        onPressed: () {
                          final employee = EmployeeModel(
                            fullName: fullNameController.text,
                            mobileNumber: mobileNumberController.text,
                            address: addressController.text,
                            nationality: nationalityController.text,
                            gender: genderController.text,
                            age: ageController.text,
                            jobTitle: jobTitleController.text,
                            salary: salaryController.text,
                            contract: contractController.text,
                            bus: busController.text,
                            startDate: DateTime.parse(startDateController.text),
                            eventRecords: eventRecords,
                          );
                          print('بيانات الموظف: $employee');
                        },
                        child: Text('إرسال'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
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
