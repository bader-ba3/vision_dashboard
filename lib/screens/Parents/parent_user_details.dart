import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Parents/Controller/Parents_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down_with_value.dart';

import '../../constants.dart';
import '../../controller/event_view_model.dart';

import '../../models/Parent_Model.dart';
import '../../models/event_model.dart';
import '../../models/event_record_model.dart';
import '../../utils/Dialogs.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Text_Filed.dart';

class ParentInputForm extends StatefulWidget {
  ParentInputForm({this.parent});

  final ParentModel? parent;

  @override
  _ParentInputFormState createState() => _ParentInputFormState();
}

class _ParentInputFormState extends State<ParentInputForm> {
  final fullNameController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final nationalityController = TextEditingController();
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
    super.initState();
    if (widget.parent != null) {
      fullNameController.text = widget.parent!.fullName.toString();
      numberController.text = widget.parent!.phoneNumber.toString();
      addressController.text = widget.parent!.address.toString();
      nationalityController.text = widget.parent!.nationality.toString();
      ageController.text = widget.parent!.age.toString();
      startDateController.text = widget.parent!.startDate.toString();
      motherPhoneNumberController.text = widget.parent!.motherPhone.toString();
      emergencyPhoneController.text = widget.parent!.emergencyPhone.toString();
      workController.text = widget.parent!.work.toString();
      eventRecords = widget.parent!.eventRecords ?? [];
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    numberController.dispose();
    addressController.dispose();
    nationalityController.dispose();
    ageController.dispose();
    startDateController.dispose();
    motherPhoneNumberController.dispose();
    bodyEventController.dispose();
    emergencyPhoneController.dispose();
    workController.dispose();
    eventRecords.clear();
    super.dispose();
  }





  // Function to validate form fields
  bool _validateFields() {
    if (!validateNotEmpty(fullNameController.text, "الاسم الكامل")) return false;
    if (!validateNumericField(numberController.text, "رقم الهاتف")) return false;
    if (!validateNotEmpty(addressController.text, "العنوان")) return false;
    if (!validateNotEmpty(nationalityController.text, "الجنسية")) return false;
    if (!validateNumericField(ageController.text, "العمر")) return false;
    if (!validateNumericField(motherPhoneNumberController.text, "رقم هاتف الأم")) return false;
    if (!validateNumericField(emergencyPhoneController.text, "رقم الطوارئ")) return false;
    if (!validateNotEmpty(workController.text, "العمل")) return false;
    if (!validateNotEmpty(startDateController.text, "تاريخ البداية")) return false;
    return true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 25,
                spacing: 25,
                children: [
                  CustomTextField(controller: fullNameController, title: 'الاسم الكامل'),
                  CustomTextField(controller: numberController, title: 'رقم الهاتف', keyboardType: TextInputType.number),
                  CustomTextField(controller: addressController, title: 'العنوان'),
                  CustomTextField(controller: nationalityController, title: 'الجنسية'),
                  CustomTextField(controller: ageController, title: 'العمر', keyboardType: TextInputType.number),
                  CustomTextField(controller: motherPhoneNumberController, title: 'رقم هاتف الام', keyboardType: TextInputType.number),
                  CustomTextField(controller: emergencyPhoneController, title: 'رقم الطوارئ', keyboardType: TextInputType.number),
                  CustomTextField(controller: workController, title: 'العمل'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        controller: startDateController,
                        title: 'تاريخ البداية',
                        enable: false,
                        keyboardType: TextInputType.datetime,
                      ),
                      IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime(2010),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            if (date != null) {
                              startDateController.text = date.toString().split(" ")[0];
                            }
                          });
                        },
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),

                  AppButton(
                    text: 'حفظ',
                    onPressed: () {
                      if (_validateFields()) {
                          ParentModel parent = ParentModel(
                            age: ageController.text,
                            nationality: nationalityController.text,
                            parentID: faker.randomGenerator
                                .integer(1000000)
                                .toString(),
                            id: widget.parent==null?generateId("PARENT"):widget.parent!.id.toString(),
                            fullName: fullNameController.text,
                            address: addressController.text,
                            work: workController.text,
                            emergencyPhone: emergencyPhoneController.text,
                            motherPhone: motherPhoneNumberController.text,
                            phoneNumber: numberController.text,
                            eventRecords: eventRecords,
                            startDate: startDateController.text,
                          );
                          Get.find<ParentsViewModel>().addParent(parent);
                          print('Parent Model: $parent');
                    if(widget.parent!=null)
                      Get.back();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding * 2),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GetBuilder<EventViewModel>(builder: (eventController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropDownWithValue(
                          value: '',
                          mapValue: eventController.allEvents.values
                              .toList()
                              .where(
                                (element) =>
                            element.role == Const.eventTypeParent,
                          )
                              .map((e) => e)
                              .toList(),
                          label: "نوع الحدث",
                          onChange: (selectedWay) {
                            print(selectedWay);
                            if (selectedWay != null) {
                              setState(() {});
                              selectedEvent=  eventController.allEvents[selectedWay] ;

                            }
                          },
                        ),
                        SizedBox(width: 16.0),
                        CustomTextField(
                          controller: bodyEventController,
                          title: 'الوصف',
                          enable: true,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(width: 16.0),
                        AppButton(
                          text: 'إضافة سجل حدث',
                          onPressed: () {
                            setState(() {
                              eventRecords.add(EventRecordModel(
                                body: bodyEventController.text,
                                type: selectedEvent!.name,
                                date: DateTime.now().toString().split(" ")[0],
                                color: selectedEvent!.color.toString(),
                              ));
                              bodyEventController.clear();
                            });
                          },
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: defaultPadding * 2),
                  Text('سجل الأحداث:', style: Styles.headLineStyle1),
                  SizedBox(height: defaultPadding),
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
                            decoration: BoxDecoration(
                              color: Color(int.parse(record.color)).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    record.type,
                                    style: Styles.headLineStyle1.copyWith(color: Colors.black),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    record.body,
                                    style: Styles.headLineStyle1.copyWith(color: Colors.black),
                                  ),
                                  SizedBox(width: 50),
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
            )


          ],
        ),
      ),
    );
  }
}
