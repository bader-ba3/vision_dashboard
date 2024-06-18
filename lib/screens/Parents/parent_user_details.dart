import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Parents/Parents_View_Model.dart';

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
  ParentInputForm({this.parent});



  ParentModel? parent;
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
  final motherPhoneNumberController = TextEditingController();
  final bodyEventController = TextEditingController();
  final emergencyPhoneController = TextEditingController();
  final workController = TextEditingController();
  List<EventRecordModel> eventRecords = [];
  EventModel? selectedEvent;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.parent!=null){
      fullNameController.text=widget.parent!.fullName.toString();
      numberController.text=widget.parent!.phoneNumber.toString();
      addressController.text=widget.parent!.address.toString();
      nationalityController.text=widget.parent!.nationality.toString();
      genderController.text=widget.parent!.parentID.toString();
      ageController.text=widget.parent!.age.toString();
      startDateController.text=widget.parent!.startDate.toString();
      motherPhoneNumberController.text=widget.parent!.motherPhone.toString();

      emergencyPhoneController.text=widget.parent!.emergencyPhone.toString();
      workController.text=widget.parent!.work.toString();
      eventRecords=widget.parent!.eventRecords??[];
    }
  }

  @override
  void dispose() {

     fullNameController.dispose();
     numberController.dispose();
     addressController.dispose();
     nationalityController.dispose();
     genderController.dispose();
     ageController.dispose();
     startDateController.dispose();
     motherPhoneNumberController.dispose();
    bodyEventController.dispose();
     emergencyPhoneController.dispose();
     workController.dispose();
    eventRecords.clear();
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(controller: fullNameController, title: 'الاسم الكامل'),
                  CustomTextField(controller: numberController, title: 'رقم الهاتف',keyboardType: TextInputType.number),
                  CustomTextField(controller: addressController, title: 'العنوان'),
                  CustomTextField(controller: nationalityController, title: 'الجنسية'),
                  CustomTextField(controller: genderController, title: 'الجنس'),
                  CustomTextField(controller: ageController, title: 'العمر', keyboardType: TextInputType.number),
                  CustomTextField(controller:motherPhoneNumberController , title: 'رقم هاتف الام', keyboardType: TextInputType.number),
                  CustomTextField(controller:emergencyPhoneController , title: 'رقم الطوارئ', keyboardType: TextInputType.number),
                  CustomTextField(controller:workController , title: 'العمل', keyboardType: TextInputType.number),
                  Row(
                    children: [
                      CustomTextField(
                          controller: startDateController,
                          title: 'تاريخ البداية',
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
                                startDateController.text =
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
                        CustomTextField(controller: bodyEventController, title: 'الوصف', enable: true, keyboardType: TextInputType.text),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                          ),
                          onPressed: () {
                            setState(() {
                              eventRecords.add(EventRecordModel(body: bodyEventController.text, type: selectedEvent!.name, date: DateTime.now().toString().split(" ")[0].toString(), color: selectedEvent!.color.toString()));
                              bodyEventController.clear();
                            });
                          },
                          child: Text('إضافة سجل حدث'),
                        ),
                      ],
                    );
                  }),

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
            SizedBox(height: defaultPadding * 2),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(primaryColor)
              ),
              onPressed: () {

                ParentModel parent = ParentModel(
                age: ageController.text,
                nationality: nationalityController.text,
                parentID: faker.randomGenerator.integer(1000000).toString(),
                  id: generateId("PARENT"),
                  fullName: fullNameController.text,
                  address: addressController.text,
                  work: workController.text,
                  emergencyPhone: emergencyPhoneController.text,
                  motherPhone: motherPhoneNumberController.text,
                  phoneNumber: numberController.text,
                  eventRecords: eventRecords,
                  startDate: startDateController.text
                );

                Get.find<ParentsViewModel>().addParent(parent);
                // يمكنك تنفيذ الإجراءات التالية مثل إرسال البيانات إلى قاعدة البيانات
                print('Parent Model: $parent');
              },

              child: Text('حفظ',style:TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );

  }
}

