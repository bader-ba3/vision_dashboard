import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import '../../constants.dart';
import '../../controller/event_view_model.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Text_Filed.dart';

class StudentInputForm extends StatefulWidget {
  @override
  _StudentInputFormState createState() => _StudentInputFormState();
}

class _StudentInputFormState extends State<StudentInputForm> {
  String _payWay = ""; // قائمة الطلاب المُحددين
  String? _selectedEvent;
  TextEditingController _bodyEvent = TextEditingController();

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
    eventRecords.clear();
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
                  CustomTextField(controller: busController, title: 'الحافلة'),
                  CustomTextField(
                      controller: guardianController, title: 'ولي الأمر'),
                  CustomDropDown(value: _payWay, listValue: _payWays,label: "طرق الدفع",onChange: (selectedWay) {

                    if (selectedWay != null) {
                      setState(() {

                      });
                      _payWay = selectedWay;
                    }
                  },),
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
