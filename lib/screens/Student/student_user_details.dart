import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:vision_dashboard/models/Installment_model.dart';

import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/models/event_record_model.dart';
import 'package:vision_dashboard/screens/Buses/Controller/Bus_View_Model.dart';
import 'package:vision_dashboard/screens/Parents/Controller/Parents_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import 'package:vision_dashboard/screens/classes/Controller/Class_View_Model.dart';
import '../../constants.dart';
import '../../controller/event_view_model.dart';
import '../../models/event_model.dart';
import '../../utils/Dialogs.dart';
import '../../utils/const.dart';
import '../Widgets/Custom_Text_Filed.dart';

class StudentInputForm extends StatefulWidget {
  @override
  _StudentInputFormState createState() => _StudentInputFormState();

  StudentInputForm({this.studentModel});

  final StudentModel? studentModel;
}

class _StudentInputFormState extends State<StudentInputForm> {
  String _payWay = '';
  EventModel? selectedEvent;
  TextEditingController bodyEvent = TextEditingController();

  Map<String, InstallmentModel> instalmentMap = {};

  final List<String> _payWays = [
    'كاش',
    'اقساط',
    'كريدت',
  ];
  final studentNameController = TextEditingController();
  final studentNumberController = TextEditingController();

  final sectionController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final classController = TextEditingController()..text='';

  final startDateController = TextEditingController();

  final busController = TextEditingController();
  final guardianController = TextEditingController();
  final languageController = TextEditingController();
  final totalPaymentController = TextEditingController();
  List<TextEditingController> monthsController = [];
  List<TextEditingController> costsController = [];

  List<EventRecordModel> eventRecords = [];
  String parentName = '';

/*  @override
  void dispose() {
    clearController();
    eventRecords.clear();
    studentNameController.dispose();
    studentNumberController.dispose();

    sectionController.dispose();
    genderController.dispose();
    ageController.dispose();
    classController.dispose();

    startDateController.dispose();

    busController.dispose();
    guardianController.dispose();
    super.dispose();
  }*/

  List<String> _contracts = [], _contractsTemp = [];

  ClassViewModel classViewModel = Get.find<ClassViewModel>();

  String busValue = '';

  addInstalment() {
    installmentCount++;
    monthsController.add(TextEditingController());
    costsController.add(TextEditingController());
  }

  bool _validateFields() {
    if (!validateNotEmpty(studentNameController.text, "اسم الطالب".tr))
      return false;
    if (!validateNumericField(studentNumberController.text, "رقم الطالب".tr))
      return false;
    if (!validateNumericField(totalPaymentController.text, "مبلغ التسجيل".tr))
      return false;
    if (!validateNotEmpty(ageController.text, "التولد".tr)) return false;
    if (!validateNotEmpty(classController.text, "الصف".tr)) return false;
    if (!validateNotEmpty(_payWay, "طريقة الدفع".tr)) return false;
    if (!validateNotEmpty(sectionController.text, "الشعبة".tr)) return false;
    if (!validateNotEmpty(languageController.text, "اللغة".tr)) return false;
    if (!validateNotEmpty(busController.text, "الحافلة".tr)) return false;
    if (!validateNotEmpty(genderController.text, "الجنس".tr)) return false;
    if (widget.studentModel == null) if (!validateNotEmpty(
        guardianController.text, "الوالد".tr)) return false;
    if (_payWay == "") {
      showErrorDialog("خطأ".tr, "يرجى اختيار طريقة الدفع".tr);
      return false;
    }
    if (!validateNotEmpty(startDateController.text, "تاريخ البداية".tr))
      return false;
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    if (widget.studentModel != null) {
      _payWay = widget.studentModel!.paymentWay ?? '';
      instalmentMap = widget.studentModel!.installmentRecords ?? {};
      studentNameController.text = widget.studentModel!.studentName ?? '';
      studentNumberController.text = widget.studentModel!.studentNumber ?? '';
      sectionController.text = widget.studentModel!.section ?? '';
      genderController.text = widget.studentModel!.gender ?? '';
      ageController.text = widget.studentModel!.StudentBirthDay ?? '';
      print(widget.studentModel!.stdClass);
      classController.text = widget.studentModel!.stdClass ?? '';
      startDateController.text = widget.studentModel!.startDate ?? '';
      busController.text = widget.studentModel!.bus ?? '';

      guardianController.text = widget.studentModel!.parentId!;
      languageController.text = widget.studentModel!.stdLanguage ?? '';
      totalPaymentController.text =
          widget.studentModel!.totalPayment.toString();
      installmentCount =
          widget.studentModel?.installmentRecords?.values.length ?? 0;

      print(widget.studentModel?.installmentRecords?.values.length);
      monthsController = List.generate(
        widget.studentModel?.installmentRecords?.values.length ?? 0,
        (index) => TextEditingController()
          ..text = widget.studentModel!.installmentRecords!.values
              .elementAt(index)
              .installmentDate
              .toString(),
      );
      costsController = List.generate(
        widget.studentModel?.installmentRecords?.length ?? 0,
        (index) => TextEditingController()
          ..text = widget.studentModel!.installmentRecords!.values
              .elementAt(index)
              .installmentCost
              .toString(),
      );
      eventRecords = widget.studentModel!.eventRecords ?? [];
      _contracts = widget.studentModel!.contractsImage ?? [];
    }
  }

  int installmentCount = 0;

  clearController() {
    eventRecords.clear();
    studentNameController.clear();
    studentNumberController.clear();
    sectionController.clear();
    genderController.text = '';
    _payWay = '';
    ageController.clear();
    classController.clear();
    startDateController.clear();
    busController.clear();
    guardianController.clear();
    monthsController.clear();
    costsController.clear();
    totalPaymentController.clear();
    parentName = '';
    languageController.text = '';
    busValue = '';
    _contracts.clear();
    _contractsTemp.clear();
    setState(() {});
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
                      controller: studentNameController,
                      title: "اسم الطالب".tr),
                  CustomTextField(
                      controller: studentNumberController,
                      title: 'رقم الطالب'.tr,
                      keyboardType: TextInputType.phone),
                  CustomDropDown(
                    value: classController.text,
                    listValue: classViewModel.classMap.values
                        .map(
                          (e) => e.className!,
                        )
                        .toList(),
                    label: 'الصف'.tr,
                    onChange: (value) {
                      if (value != null) {
                        classController.text = value;
                        setState(() {

                        });
                      }
                    },
                  ),
                  CustomDropDown(
                    value: sectionController.text,
                    listValue: classViewModel.classMap.values
                            .where(
                              (element) =>
                                  element.className == classController.text,
                            )
                            .firstOrNull
                            ?.classSection ??
                        [],
                    label: 'الشعبة'.tr,
                    onChange: (value) {
                      if (value != null) {
                        sectionController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: genderController.text,
                    listValue: sexList,
                    label: 'الجنس'.tr,
                    onChange: (value) {
                      if (value != null) {
                        genderController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: languageController.text,
                    listValue: languageList,
                    label: 'اللغة'.tr,
                    onChange: (value) {
                      if (value != null) {
                        languageController.text = value;
                      }
                    },
                  ),
                  CustomDropDown(
                    value: busValue,
                    listValue: Get.find<BusViewModel>()
                            .busesMap
                            .values
                            .map(
                              (e) => e.name!,
                            )
                            .toList() +
                        ['بدون حافلة'],
                    label: 'الحافلة'.tr,
                    onChange: (value) {
                      if (value != null) {
                        busValue = value;
                        final busViewController = Get.find<BusViewModel>();
                        if (busViewController.busesMap.isNotEmpty) {
                          busController.text = busViewController.busesMap.values
                              .where(
                                (element) => element.name == value,
                              )
                              .firstOrNull
                              ?.busId??value;
                        } else
                          busController.text = value;
                      }
                    },
                  ),
                  if (widget.studentModel == null)
                    CustomDropDown(
                      value: parentName,
                      listValue: Get.find<ParentsViewModel>()
                          .parentMap
                          .values
                          .map(
                            (e) => e.fullName!,
                          )
                          .toList(),
                      label: 'ولي الأمر'.tr,
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
                      title: 'مبلغ التسجيل'.tr,
                      keyboardType: TextInputType.phone),
                  CustomDropDown(
                    value: _payWay.tr,
                    listValue: _payWays
                        .map(
                          (e) => e.toString().tr,
                        )
                        .toList(),
                    label: "طريقة الدفع".tr,
                    onChange: (selectedWay) async {
                      if (selectedWay != null) {
                        if (selectedWay == 'اقساط'.tr) {
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
                  InkWell(
                    onTap: () {
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
                    child: CustomTextField(
                      controller: startDateController,
                      title: 'تاريخ البداية'.tr,
                      enable: false,
                      keyboardType: TextInputType.datetime,
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2100),
                      ).then((date) {
                        if (date != null) {
                          ageController.text = date.toString().split(" ")[0];
                        }
                      });
                    },
                    child: CustomTextField(
                      controller: ageController,
                      title: 'التولد'.tr,
                      enable: false,
                      keyboardType: TextInputType.datetime,
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  if (_payWay == 'اقساط'.tr)
                    SizedBox(
                      width: Get.width / 2,
                      child: Column(
                        children: [
                          SizedBox(height: defaultPadding * 2),
                          Text('سجل الدفعات:'.tr, style: Styles.headLineStyle1),
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
                                bool cantEdite = widget.studentModel != null
                                    ? widget.studentModel!.installmentRecords!
                                            .values
                                            .toList()[index]
                                            .isPay ??
                                        false
                                    : false;
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
                                          cantEdite
                                              ? CustomTextField(
                                                  enable: !cantEdite,
                                                  isFullBorder: !cantEdite,
                                                  controller:
                                                      TextEditingController()
                                                        ..text = months.entries
                                                                .where(
                                                                  (element) =>
                                                                      element
                                                                          .value ==
                                                                      monthsController[
                                                                              index]
                                                                          .text,
                                                                )
                                                                .firstOrNull
                                                                ?.key ??
                                                            '',
                                                  title: "الشهر".tr,
                                                  size: Get.width / 5.5,
                                                  keyboardType:
                                                      TextInputType.number,
                                                )
                                              : CustomDropDown(
                                                  value: months.entries
                                                          .where(
                                                            (element) =>
                                                                element.value ==
                                                                monthsController[
                                                                        index]
                                                                    .text,
                                                          )
                                                          .firstOrNull
                                                          ?.key ??
                                                      '',
                                                  listValue: months.keys
                                                      .map((e) => e.toString())
                                                      .toList(),
                                                  label: "الشهر".tr,
                                                  size: Get.width / 5.5,
                                                  isFullBorder: true,
                                                  onChange: (value) {
                                                    if (value != null) {
                                                      monthsController[index]
                                                              .text =
                                                          months[value]!;
                                                    }
                                                  },
                                                ),
                                          Spacer(),
                                          CustomTextField(
                                            enable: !cantEdite,
                                            controller: costsController[index],
                                            title: "الدفعة".tr,
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
                                    "اضافة".tr,
                                    style: Styles.headLineStyle3,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          GetBuilder<StudentViewModel>(builder: (controller) {
                            return AppButton(
                              text: "حفظ".tr,
                              onPressed: () async {
                                if (_validateFields()) {
                                  QuickAlert.show(
                                      width: Get.width / 2,
                                      context: context,
                                      type: QuickAlertType.loading,
                                      title: 'جاري التحميل'.tr,
                                      text: 'يتم العمل على الطلب'.tr,
                                      barrierDismissible: false);
                                  for (int index = 0;
                                      index < monthsController.length;
                                      index++) {
                                    String insId = widget.studentModel != null
                                        ? widget.studentModel!
                                            .installmentRecords!.values
                                            .toList()[index]
                                            .installmentId!
                                        : generateId("INSTALLMENT");
                                    instalmentMap[insId] = InstallmentModel(
                                      installmentCost:
                                          costsController[index].text,
                                      installmentDate:
                                          monthsController[index].text,
                                      installmentId: insId,
                                      isPay: widget.studentModel != null
                                          ? widget.studentModel!
                                              .installmentRecords!.values
                                              .toList()[index]
                                              .isPay!
                                          : false,
                                    );
                                  }

                                  await uploadImages(
                                          _contractsTemp, "contracts")
                                      .then(
                                    (value) => _contracts.addAll(value),
                                  );
                                  final student = StudentModel(
                                    studentID: widget.studentModel == null
                                        ? generateId("STD")
                                        : widget.studentModel!.studentID!,
                                    parentId: guardianController.text,
                                    stdLanguage: languageController.text,
                                    section: sectionController.text,
                                    studentNumber: studentNumberController.text,
                                    StudentBirthDay: ageController.text,
                                    studentName: studentNameController.text,
                                    stdClass: classController.text,
                                    contractsImage: _contracts,
                                    paymentWay: _payWay,
                                    totalPayment:
                                        int.parse(totalPaymentController.text),
                                    gender: genderController.text,
                                    bus: busController.text,
                                    startDate: startDateController.text,
                                    eventRecords: eventRecords,
                                    installmentRecords: instalmentMap,
                                  );
                                  widget.studentModel != null
                                      ? await controller.updateStudent(student)
                                      : await controller.addStudent(student);

                                  clearController();
                                  setState(() {});
                                  if (widget.studentModel != null) Get.back();
                                  Get.back();
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة العقد".tr),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () async {
                                FilePickerResult? _ = await FilePicker.platform
                                    .pickFiles(
                                        type: FileType.image,
                                        allowMultiple: true);
                                if (_ != null) {
                                  _.xFiles.forEach(
                                    (element) async {
                                      _contractsTemp.add(await element.path);
                                    },
                                  );
                                  setState(() {});
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 200,
                                  width: 200,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ),
                            ...List.generate(
                              _contractsTemp.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: 200,
                                      height: 200,
                                      child: Image.file(
                                        File(_contractsTemp[index]),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fitHeight,
                                      )),
                                );
                              },
                            ),
                            ...List.generate(
                              _contracts.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      width: 200,
                                      height: 200,
                                      child: Image.network(
                                        _contracts[index],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fitHeight,
                                      )),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_payWay != "اقساط".tr)
                    GetBuilder<StudentViewModel>(builder: (controller) {
                      return AppButton(
                        text: "حفظ".tr,
                        onPressed: () async {
                          if (_validateFields()) {
                            QuickAlert.show(
                                width: Get.width / 2,
                                context: context,
                                type: QuickAlertType.loading,
                                title: 'جاري التحميل'.tr,
                                text: 'يتم العمل على الطلب'.tr,
                                barrierDismissible: false);
                            String id = widget.studentModel == null
                                ? generateId("INSTALLMENT")
                                : widget.studentModel!.installmentRecords!.keys
                                    .toList()[0];
                            instalmentMap[id] = InstallmentModel(
                                isPay: true,
                                installmentId: id,
                                installmentDate: DateTime.now()
                                    .month
                                    .toString()
                                    .padLeft(2, "0"),
                                installmentCost: totalPaymentController.text,
                                payTime: DateTime.now().toString());

                            await uploadImages(_contractsTemp, "contracts")
                                .then(
                              (value) => _contracts.addAll(value),
                            );
                            final student = StudentModel(
                              studentID: widget.studentModel == null
                                  ? generateId("STD")
                                  : widget.studentModel!.studentID!,
                              parentId: guardianController.text,
                              stdLanguage: languageController.text,
                              contractsImage: _contracts,
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
                            widget.studentModel != null
                                ? await controller.updateStudent(student)
                                : await controller.addStudent(student);
                            clearController();
                            if (widget.studentModel != null) Get.back();
                            Get.back();
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
                    return Wrap(
                      runAlignment: WrapAlignment.spaceAround,
                      runSpacing: 25,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          label: "نوع الحدث".tr,
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
                            title: 'الوصف'.tr,
                            enable: true,
                            keyboardType: TextInputType.text),
                        SizedBox(width: 16.0),
                        AppButton(
                          text: 'إضافة سجل حدث'.tr,
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
                  Text('سجل الأحداث'.tr, style: Styles.headLineStyle1),
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
