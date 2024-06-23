import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/models/event_record_model.dart';
import 'package:vision_dashboard/screens/Parents/Controller/Parents_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import '../../constants.dart';
import '../../controller/event_view_model.dart';
import '../../models/event_model.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Text_Filed.dart';

class StudentInputForm extends StatefulWidget {
  @override
  _StudentInputFormState createState() => _StudentInputFormState();
}

class _StudentInputFormState extends State<StudentInputForm> {
  String _payWay = "";
  EventModel? selectedEvent;
  TextEditingController bodyEvent = TextEditingController();

  // قائمة بكل الطلاب المتاحين
  final List<String> _payWays = [
    'كاش',
    'اقساط',
    'كريدت',
    // أضف المزيد من الطلاب إذا لزم الأمر
  ];
  final studentNameController = TextEditingController();
  final studentNumberController = TextEditingController();
  final addressController = TextEditingController();
  final sectionController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final classController = TextEditingController();
  final teachersController = TextEditingController();
  final examsController = TextEditingController();
  final startDateController = TextEditingController();
  final gradesController = TextEditingController();
  final busController = TextEditingController();
  final guardianController = TextEditingController();

  List<EventRecordModel> eventRecords = [];

  @override
  void dispose() {
    eventRecords.clear();
    studentNameController.dispose();
    studentNumberController.dispose();
    addressController.dispose();
    sectionController.dispose();
    genderController.dispose();
    ageController.dispose();
    classController.dispose();
    teachersController.dispose();
    examsController.dispose();
    startDateController.dispose();
    gradesController.dispose();
    busController.dispose();
    guardianController.dispose();
    super.dispose();
  }

  String? selectedValue;

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
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 50,
                // spacing: 25,
                children: <Widget>[
                  CustomTextField(
                      controller: studentNameController, title: "اسم الطالب"),
                  CustomTextField(
                      controller: studentNumberController,
                      title: 'رقم الطالب',
                      keyboardType: TextInputType.phone),
                  CustomDropDown(value: 'الشعبة', listValue: sectionsList, label: 'الشعبة', onChange: (value) {
                    if(value!=null)
                    {
                      sectionController.text=value;
                    }
                  },),
                  CustomDropDown(value: 'الجنس', listValue: sexList, label: 'الجنس', onChange: (value) {
                    if(value!=null)
                      {
                        genderController.text=value;
                      }
                  },),


                  CustomDropDown(value: 'الصف', listValue: classNameList, label: 'الصف', onChange: (value) {
                    if(value!=null)
                      {
                        classController.text=value;
                      }
                  },),
                  CustomDropDown(value: 'الحافلة', listValue: busesList, label: 'الحافلة', onChange: (value) {
                    if(value!=null)
                    {
                      busController.text=value;
                    }
                  },),
                  CustomDropDown(value: "ولي الأمر", listValue: Get.find<ParentsViewModel>().parentMap.values.map((e) => e.fullName!,).toList(),label: 'ولي الأمر',onChange: (value) {
                    if (value != null) {
                    guardianController.text=  Get.find<ParentsViewModel>().parentMap.values.where((element) => element.fullName==value,).first.id!;}
                  },),
                  CustomDropDown(value: _payWay, listValue: _payWays,label: "طرق الدفع",onChange: (selectedWay) {

                    if (selectedWay != null) {
                      _payWay = selectedWay;
                    }
                  },),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                          controller: ageController,
                          title: 'التولد',
                          enable: false,
                          keyboardType: TextInputType.datetime),
                      IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2024))
                                .then((date) {
                              if (date != null) {
                                ageController.text =
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'المبلغ',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        _payWay == "اقساط"
                            ? "١٠٠٠ لمدة ٥ اشهر "
                            : "٧٠٠٠ حسم ٢٥٪",
                        style: Styles.headLineStyle2,
                      )

                    ],
                  ),
                  GetBuilder<EventViewModel>(builder: (eventController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  (element) => element.role == Const.eventTypeStudent,
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
                            foregroundColor: WidgetStateProperty.all(Colors.white),
                            backgroundColor: WidgetStateProperty.all(primaryColor),
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
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            SizedBox(height: defaultPadding * 2),
            Text('سجل الأحداث:', style: Styles.headLineStyle1),
            SizedBox(
              height: defaultPadding,
            ),
            Container(
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
            SizedBox(
              height: defaultPadding,
            ),
            GetBuilder<StudentViewModel>(
              builder: (controller) {
                return ElevatedButton(
                  style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white), backgroundColor: WidgetStateProperty.all(primaryColor)),
                  onPressed: () {
                    final student = StudentModel(
                      studentID: generateId("STD"),
                      parentId: guardianController.text,
                      grade: "",
                      section: sectionController.text,
                      studentNumber: studentNumberController.text,
                      StudentBirthDay: ageController.text,
                      studentName: studentNameController.text,
                      stdClass: classController.text,
                      gender: genderController.text,
                      bus: busController.text,
                      startDate: startDateController.text,
                      eventRecords: eventRecords,
                    );
                    controller.addStudent(student);
                    print('بيانات الموظف: $student');
                  },
                  child: Text('إرسال'),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
