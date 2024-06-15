import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/event_view_model.dart';
import '../../constants.dart';
import '../../models/Employee_Model.dart';
import '../../models/Student_Model.dart';
import '../../utils/const.dart';
import '../Employee/Employee_user_details.dart';
import '../Widgets/Custom_Text_Filed.dart';

class StudentInputForm extends StatefulWidget {
  @override
  _StudentInputFormState createState() => _StudentInputFormState();
}

class _StudentInputFormState extends State<StudentInputForm> {
  String _payWay = ""; // قائمة الطلاب المُحددين
  String? _selectedEvent; // قائمة الطلاب المُحددين
  TextEditingController _bodyEvent = TextEditingController(); // قائمة الطلاب المُحددين

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
  final nationalityController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final gradeController = TextEditingController();
  final teachersController = TextEditingController();
  final examsController = TextEditingController();
  final startDateController = TextEditingController();
  final gradesController = TextEditingController();
  // final eventRecordsController = TextEditingController();
  final busController = TextEditingController();
  final guardianController = TextEditingController();

  List<Map<String, dynamic>> eventRecords = [];

  @override
  void dispose() {
    studentNameController.dispose();
    studentNumberController.dispose();
    addressController.dispose();
    nationalityController.dispose();
    genderController.dispose();
    ageController.dispose();
    gradeController.dispose();
    teachersController.dispose();
    examsController.dispose();
    startDateController.dispose();
    gradesController.dispose();
    // eventRecordsController.dispose();
    busController.dispose();
    guardianController.dispose();
    super.dispose();
  }

  String? selectedValue;
  List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = Get.find<EventViewModel>();
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
                borderRadius: BorderRadius.circular(15),
              ),
              child: Wrap(
                clipBehavior: Clip.hardEdge,
                direction: Axis.horizontal,
                runSpacing: 50,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(
                      controller: studentNameController, title: "اسم الطالب"),
                  CustomTextField(
                      controller: studentNumberController,
                      title: 'رقم الطالب',
                      keyboardType: TextInputType.phone),
                  CustomTextField(
                      controller: addressController, title: 'العنوان'),
                  CustomTextField(
                      controller: nationalityController, title: 'الجنسية'),
                  CustomTextField(controller: genderController, title: 'الجنس'),
                  CustomTextField(
                      controller: ageController,
                      title: 'العمر',
                      keyboardType: TextInputType.number),
                  CustomTextField(controller: gradeController, title: 'الصف'),
                  CustomTextField(
                      controller: teachersController, title: 'المعلمين'),
                  /*   CustomTextField(
                      controller: examsController, title: 'الامتحانات'),*/

                  /*  CustomTextField(
                      controller: gradesController, title: 'الدرجات'),*/
                  // CustomTextField(
                  //     controller: eventRecordsController, title: 'سجل الأحداث'),
                  CustomTextField(controller: busController, title: 'الحافلة'),
                  CustomTextField(
                      controller: guardianController, title: 'ولي الأمر'),

                  SizedBox(
                    width: Get.width / 3.5,
                    child: SizedBox(
                      width: Get.width / 3.5,
                      child: DropdownButtonFormField<String>(
                        value: null,
                        hint: Text('طريقة الدفع'),
                        onChanged: (selectedWay) {
                          if (selectedWay != null) {
                            setState(() {
                              _payWay = selectedWay;
                            });
                          }
                        },
                        items: _payWays.map((student) {
                          return DropdownMenuItem(
                            value: student,
                            child: Text(student),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'المبلغ',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 8,),
                      Text(_payWay == "اقساط" ? "١٠٠٠ لمدة ٥ اشهر " : "٧٠٠٠ حسم ٢٥٪", style: Styles.headLineStyle2,)
                      /*   _payWay==""?SizedBox():  Chip(
                        backgroundColor: Colors.white,
                        label: Text(
                          _payWay,
                          style: Styles.headLineStyle2,
                        ),
                        onDeleted: () {
                          setState(() {
                            _payWay = "";
                          });
                        },
                      ),*/
                    ],
                  ),
                  GetBuilder<EventViewModel>(builder: (eventController) {
                    return Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3.5,
                          child: SizedBox(
                            width: Get.width / 3.5,
                            child: DropdownButtonFormField<String>(
                              value: _selectedEvent,
                              hint: Text('نوع الحدث'),
                              onChanged: (selectedWay) {
                                if (selectedWay != null) {
                                  setState(() {
                                    _selectedEvent = selectedWay;
                                  });
                                }
                              },
                              items: eventController.allEvents.values.toList().where((element) => element.role == Const.eventTypeStudent,).map((student) {
                                return DropdownMenuItem(
                                  value: student.name,
                                  child: Text(student.name),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
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
                                'event': _selectedEvent! + _bodyEvent.text,
                                'date': DateTime.now().toString(),
                              });
                              _selectedEvent = null;
                              _bodyEvent.clear();
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
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all(primaryColor),
                        ),
                        onPressed: () {
                          final student = StudentModel(
                            studentName: studentNameController.text,
                            studentNumber: studentNumberController.text,
                            gender: genderController.text,
                            StudentBirthDay: ageController.text,
                            grade: gradeController.text,
                            startDate: DateTime.parse(startDateController.text),
                            eventRecords: [
                              EventRecordModel(
                                  event: "event", date: DateTime.now())
                            ],
                            bus: busController.text,
                          );
                          print('بيانات الطالب: $student');
                        },
                        child: Text('إرسال'),
                      ),
                    ],
                  ),
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
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: eventRecords.length,
                itemBuilder: (context, index) {
                  final record = eventRecords[index];
                  return ListTile(
                    title: Text(
                      record['event'],
                      style: Styles.headLineStyle1,
                    ),
                    subtitle: Text(
                      record['date'],
                      style: Styles.headLineStyle3,
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
