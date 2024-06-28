import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Installment_model.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/models/event_record_model.dart';
import 'package:vision_dashboard/screens/Parents/Controller/Parents_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import '../../constants.dart';
import '../../controller/event_view_model.dart';
import '../../models/event_model.dart';
import '../../utils/Dialogs.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Text_Filed.dart';

class StudentInputForm extends StatefulWidget {
  @override
  _StudentInputFormState createState() => _StudentInputFormState();
}

class _StudentInputFormState extends State<StudentInputForm> {
  String _payWay = '';
  EventModel? selectedEvent;
  TextEditingController bodyEvent = TextEditingController();

  Map<String, InstallmentModel> instalmentMap = {};

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
  final languageController = TextEditingController();
  final totalPaymentController = TextEditingController();

  List<TextEditingController> monthsController = [];
  List<TextEditingController> costsController = [];
  final monthController = TextEditingController();
  final costController = TextEditingController();
  List<EventRecordModel> eventRecords = [];

  String parentName = '';

  @override
  void dispose() {
    clearController();
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

  addInstalment() {
    installmentCount++;
    monthsController.add(TextEditingController());
    costsController.add(TextEditingController());
    print(installmentCount);
  }

  String? selectedValue;

  bool _validateFields() {
    if (!validateNotEmpty(studentNameController.text, "اسم الطالب"))
      return false;
    if (!validateNumericField(studentNumberController.text, "رقم الطالب"))
      return false;
    if (!validateNumericField(totalPaymentController.text, "مبلغ التسجيل"))
      return false;
    if (!validateNotEmpty(ageController.text, "التولد")) return false;
    if (!validateNotEmpty(classController.text, "الصف")) return false;
    if (!validateNotEmpty(_payWay, "طريقة الدفع")) return false;
    if (!validateNotEmpty(sectionController.text, "الشعبة")) return false;
    if (!validateNotEmpty(languageController.text, "اللغة")) return false;
    if (!validateNotEmpty(busController.text, "الحافلة")) return false;
    if (!validateNotEmpty(genderController.text, "الجنس")) return false;
    if (!validateNotEmpty(guardianController.text, "الوالد")) return false;
    if (_payWay == "") {
      showErrorDialog("خطأ", "يرجى اختيار طريقة الدفع");
      return false;
    }
    if (!validateNotEmpty(startDateController.text, "تاريخ البداية"))
      return false;
    return true;
  }

  int installmentCount = 0;

  clearController() {
    eventRecords.clear();
    studentNameController.clear();
    studentNumberController.clear();
    addressController.clear();
    sectionController.clear();
    genderController.text = '';
    _payWay = '';
    ageController.clear();
    classController.clear();
    teachersController.clear();
    examsController.clear();
    startDateController.clear();
    gradesController.clear();
    busController.clear();
    guardianController.clear();
    monthsController.clear();
    costsController.clear();
    totalPaymentController.clear();
    parentName = '';
    languageController.text = '';
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
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 50,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(
                      controller: studentNameController, title: "اسم الطالب"),
                  CustomTextField(
                      controller: studentNumberController,
                      title: 'رقم الطالب',
                      keyboardType: TextInputType.phone),
                  CustomDropDown(
                    value: sectionController.text,
                    listValue: sectionsList,
                    label: 'الشعبة',
                    onChange: (value) {
                      if (value != null) {
                        sectionController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: genderController.text,
                    listValue: sexList,
                    label: 'الجنس',
                    onChange: (value) {
                      if (value != null) {
                        genderController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: classController.text,
                    listValue: classNameList,
                    label: 'الصف',
                    onChange: (value) {
                      if (value != null) {
                        classController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: languageController.text,
                    listValue: languageList,
                    label: 'اللغة',
                    onChange: (value) {
                      if (value != null) {
                        languageController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: busController.text,
                    listValue: busesList,
                    label: 'الحافلة',
                    onChange: (value) {
                      if (value != null) {
                        busController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: parentName,
                    listValue: Get.find<ParentsViewModel>()
                        .parentMap
                        .values
                        .map(
                          (e) => e.fullName!,
                        )
                        .toList(),
                    label: 'ولي الأمر',
                    onChange: (value) {
                      if (value != null) {
                        parentName = value;
                        guardianController.text = Get.find<ParentsViewModel>()
                            .parentMap
                            .values
                            .where(
                              (element) => element.fullName == value,
                            )
                            .first
                            .id!;
                      }
                    },
                  ),
                  CustomTextField(
                      controller: totalPaymentController,
                      title: 'مبلغ التسجيل',
                      keyboardType: TextInputType.phone),
                  CustomDropDown(
                    value: _payWay,
                    listValue: _payWays,
                    label: "طرق الدفع",
                    onChange: (selectedWay) async {
                      if (selectedWay != null) {
                        if (selectedWay == 'اقساط') {
                          _payWay = selectedWay;

                          await addInstalment();

                          setState(() {});
                        } else {
                          _payWay = selectedWay;
                          installmentCount = 0;
                          monthsController.clear();
                          costsController.clear();
                          setState(() {});
                        }
                      }
                    },
                  ),
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
                  if (_payWay == 'اقساط')
                    SizedBox(
                      width: Get.width / 2,
                      child: Column(
                        children: [
                          SizedBox(height: defaultPadding * 2),
                          Text('سجل الدفعات:', style: Styles.headLineStyle1),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: installmentCount,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 2.0, color: primaryColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14.0, horizontal: 10),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          CustomDropDown(
                                            value: '',
                                            listValue: months.keys
                                                .map((e) => e.toString())
                                                .toList(),
                                            label: "الشهر",
                                            size: Get.width / 5.5,
                                            isFullBorder: true,
                                            onChange: (value) {
                                              if (value != null) {
                                                monthsController[index].text =
                                                    months[value]!;
                                              }
                                            },
                                          ),
                                          Spacer(),
                                          CustomTextField(
                                            controller: costsController[index],
                                            title: "الدفعة",
                                            size: Get.width / 5.5,
                                            keyboardType: TextInputType.number,
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
                          IconButton(
                              onPressed: () {
                                addInstalment();
                                setState(() {});
                              },
                              icon: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "اضافة",
                                    style: Styles.headLineStyle3,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          GetBuilder<StudentViewModel>(builder: (controller) {
                            return AppButton(
                              text: "حفظ",
                              onPressed: () {
                                if (_validateFields()) {
                                  for (int index = 0;
                                      index < monthsController.length;
                                      index++) {
                                    String insId = generateId("INSTALLMENT");
                                    instalmentMap[insId] = InstallmentModel(
                                      installmentCost:
                                          costsController[index].text,
                                      installmentDate:
                                          monthsController[index].text,
                                      installmentId: insId,
                                      isPay: false,
                                    );
                                  }
                                  final student = StudentModel(
                                    studentID: generateId("STD"),
                                    parentId: guardianController.text,
                                    stdLanguage: languageController.text,
                                    stdExam: [],
                                    section: sectionController.text,
                                    studentNumber: studentNumberController.text,
                                    StudentBirthDay: ageController.text,
                                    studentName: studentNameController.text,
                                    stdClass: classController.text,
                                    paymentWay: _payWay,
                                    totalPayment:
                                        int.parse(totalPaymentController.text),
                                    gender: genderController.text,
                                    bus: busController.text,
                                    startDate: startDateController.text,
                                    eventRecords: eventRecords,
                                    installmentRecords: instalmentMap,
                                  );
                                  controller.addStudent(student);
                                  clearController();
                                  setState(() {});
                                  // print('بيانات الموظف: $student');
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  if (_payWay != "اقساط")
                    GetBuilder<StudentViewModel>(builder: (controller) {
                      return AppButton(
                        text: "حفظ",
                        onPressed: () {
                          if (_validateFields()) {
                            String id = generateId("INSTALLMENT");
                            instalmentMap[id] = InstallmentModel(
                                isPay: true,
                                installmentId: id,
                                installmentDate: DateTime.now()
                                    .month
                                    .toString()
                                    .padLeft(2, "0"),
                                installmentCost: totalPaymentController.text,
                                payTime: DateTime.now().toString());
                            final student = StudentModel(
                              studentID: generateId("STD"),
                              parentId: guardianController.text,
                              stdLanguage: languageController.text,
                              stdExam: [],
                              section: sectionController.text,
                              studentNumber: studentNumberController.text,
                              StudentBirthDay: ageController.text,
                              studentName: studentNameController.text,
                              stdClass: classController.text,
                              gender: genderController.text,
                              bus: busController.text,
                              startDate: startDateController.text,
                              eventRecords: eventRecords,
                              installmentRecords: instalmentMap,
                              paymentWay: _payWay,
                              totalPayment:
                                  int.parse(totalPaymentController.text),
                            );
                            controller.addStudent(student);
                            clearController();
                            // print('بيانات الموظف: $student');
                          }
                        },
                      );
                    }),
                ],
              ),
            ),
            SizedBox(
              height: defaultPadding * 2,
            ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomDropDown(
                          value: '',
                          listValue: eventController.allEvents.values
                              .toList()
                              .where(
                                (element) =>
                                    element.role == Const.eventTypeStudent,
                              )
                              .map((e) => e.name)
                              .toList(),
                          label: "نوع الحدث",
                          onChange: (selectedWay) {
                            if (selectedWay != null) {
                              setState(() {});
                              selectedEvent?.name = selectedWay;
                            }
                          },
                        ),
                        SizedBox(width: 16.0),
                        CustomTextField(
                            controller: bodyEvent,
                            title: 'الوصف',
                            enable: true,
                            keyboardType: TextInputType.text),
                        SizedBox(width: 16.0),
                        AppButton(
                          text: 'إضافة سجل حدث',
                          onPressed: () {
                            setState(() {
                              eventRecords.add(EventRecordModel(
                                  body: bodyEvent.text,
                                  type: selectedEvent!.name,
                                  date: DateTime.now()
                                      .toString()
                                      .split(" ")[0]
                                      .toString(),
                                  color: selectedEvent!.color.toString()));
                              bodyEvent.clear();
                            });
                          },
                        )
                      ],
                    );
                  }),
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
                            decoration: BoxDecoration(
                                color: Color(int.parse(record.color))
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14.0, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    record.type,
                                    style: Styles.headLineStyle1
                                        .copyWith(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    record.body,
                                    style: Styles.headLineStyle1
                                        .copyWith(color: Colors.black),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
