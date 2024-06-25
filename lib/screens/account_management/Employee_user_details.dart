import 'package:vision_dashboard/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/event_model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';

import '../../controller/account_management_view_model.dart';
import '../../controller/event_view_model.dart';
import '../../controller/home_controller.dart';
import '../../models/account_management_model.dart';
import '../../models/event_record_model.dart';
import '../../utils/Dialogs.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Text_Filed.dart';
import '../Widgets/header.dart';

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
  final bodyEvent = TextEditingController();
  final dayWorkController = TextEditingController();
  Map accountType = {
    "user": "مستخدم",
    "admin": "مدير",
  };
  String? role;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPassController = TextEditingController();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
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
    bodyEvent.dispose();
    super.dispose();
  }
  clearController(){

     fullNameController.clear();
     mobileNumberController.clear();
     addressController .clear();
     nationalityController .clear();
     genderController .clear();
     ageController .clear();
     jobTitleController .clear();
     salaryController .clear();
     contractController .clear();
     busController.clear();
     startDateController .clear();
     eventController .clear();
     bodyEvent .clear();
     dayWorkController .clear();
     bodyEvent.clear();
     userNameController.clear();
     userPassController.clear();
     eventRecords.clear();
     role=null;

  }
  bool _validateFields() {
    if (fullNameController.text.isEmpty ||
        mobileNumberController.text.isEmpty ||
        addressController.text.isEmpty ||
        nationalityController.text.isEmpty ||
        genderController.text.isEmpty ||
        ageController.text.isEmpty ||
        jobTitleController.text.isEmpty ||
        salaryController.text.isEmpty ||
        contractController.text.isEmpty ||
        busController.text.isEmpty ||
        startDateController.text.isEmpty ||
        userNameController.text.isEmpty ||
        userPassController.text.isEmpty ||
        !isNumeric(ageController.text) ||
        !isNumeric(salaryController.text) ||
        !isNumeric(dayWorkController.text)) {
      showErrorDialog(
          "خطأ",
          "يرجى ملء جميع الحقول وتأكد من أن الحقول الرقمية تحتوي على أرقام فقط.");
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'اضافة الموظفين',
      ),
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
                  borderRadius: BorderRadius.circular(15)),
              child: Wrap(
                clipBehavior: Clip.hardEdge,
                direction: Axis.horizontal,
                runSpacing: 50,
                alignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  CustomTextField(
                      controller: fullNameController, title: "الاسم الكامل"),
                  CustomTextField(
                      controller: mobileNumberController,
                      title: 'رقم الموبايل',
                      keyboardType: TextInputType.phone),
                  CustomTextField(
                      controller: addressController, title: 'العنوان'),
                  CustomTextField(
                      controller: nationalityController, title: 'الجنسية'),
                  CustomDropDown(
                    value: 'الجنس',
                    listValue: sexList,
                    label: 'الجنس',
                    onChange: (value) {
                      if (value != null) {
                        genderController.text = value;
                      }
                    },
                  ),
                  CustomTextField(
                      controller: ageController,
                      title: 'العمر',
                      keyboardType: TextInputType.number),
                  CustomTextField(
                      controller: dayWorkController,
                      title: 'عدد ايام العمل',
                      keyboardType: TextInputType.number),
                  CustomDropDown(
                      value: 'الوظيفة',
                      listValue: jobList,
                      label: 'الوظيفة',
                      onChange: (value) {
                        if (value != null) {
                          jobTitleController.text = value;
                        }
                      }),
                  CustomTextField(
                      controller: salaryController,
                      title: 'الراتب',
                      keyboardType: TextInputType.number),
                  CustomDropDown(
                    value: 'العقد',
                    listValue: contractsList,
                    label: 'العقد',
                    onChange: (value) {
                      if (value != null) {
                        contractController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: 'الحافلة',
                    listValue: busesList,
                    label: 'الحافلة',
                    onChange: (value) {
                      if (value != null) {
                        busController.text = value;
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
                              startDateController.text =
                                  date.toString().split(" ")[0];
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
                  CustomTextField(
                      controller: userNameController,
                      title: 'اسم المستخدم',
                      keyboardType: TextInputType.datetime),
                  CustomTextField(
                      controller: userPassController,
                      title: 'كلمة المرور',
                      keyboardType: TextInputType.datetime),
                  CustomDropDown(
                    value: "value",
                    listValue: accountType.entries
                        .map((e) => e.value.toString())
                        .toList(),
                    label: "الدور",
                    onChange: (_) {
                      role = _;
                      setState(() {});
                    },
                  ),
                  GetBuilder<EventViewModel>(builder: (eventController) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomDropDown(
                          value: "نوع الحدث",
                          listValue: eventController.allEvents.values
                              .toList()
                              .where(
                                (element) =>
                            element.role == Const.eventTypeEmployee,
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
                          color:
                              Color(int.parse(record.color)).withOpacity(0.2),
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
            SizedBox(height: 16.0),
            GetBuilder<AccountManagementViewModel>(builder: (controller) {
              return AppButton(
                text: "حفظ",
                onPressed: () async{
                  if(_validateFields()) {
                    role ??= accountType.keys.first;
                    AccountManagementModel model = AccountManagementModel(
                      id: generateId("EMPLOYEE"),
                      userName: userNameController.text,
                      fullName: fullNameController.text,
                      password: userPassController.text,
                      type: role!,
                      serialNFC: null,
                      isActive: true,
                      salary: int.parse(salaryController.text),
                      dayOfWork: int.parse(dayWorkController.text),
                      mobileNumber: mobileNumberController.text,
                      address: addressController.text,
                      nationality: nationalityController.text,
                      gender: genderController.text,
                      age: ageController.text,
                      jobTitle: jobTitleController.text,
                      contract: contractController.text,
                      bus: busController.text,
                      startDate: startDateController.text,
                      eventRecords: eventRecords,
                    );
                   await controller.addAccount(model);
                    clearController();
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
