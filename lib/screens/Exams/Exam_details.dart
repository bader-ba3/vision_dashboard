import 'dart:io';

import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import 'package:vision_dashboard/utils/Dialogs.dart';

import '../../models/Exam_model.dart';
import '../Widgets/Custom_Text_Filed.dart';

class ExamInputForm extends StatefulWidget {
  ExamInputForm({super.key, this.examModel, required this.isEdite});

  @override
  _ExamInputFormState createState() => _ExamInputFormState();

  late final ExamModel? examModel;
  final bool isEdite;
}

class _ExamInputFormState extends State<ExamInputForm> {
  List<String> _selectedSection = [];
  Map<String, String> _selectedStudent = {};

  String _selectedClass = "";

  initExam() {
    if (widget.examModel != null) {
      subjectController.text = widget.examModel!.subject ?? '';
      professorController.text = widget.examModel!.professor ?? '';
      dateController.text = widget.examModel!.date.toString();
      examPassMarkController.text = widget.examModel!.examPassMark.toString();
      examMaxMarkController.text = widget.examModel!.examMaxMark ?? '';
      examId = widget.examModel!.id!;
      _questionImageFile = widget.examModel!.questionImage;
      _answerImageFile = widget.examModel!.answerImage;
      widget.examModel!.marks?.forEach(
        (key, value) {
          _selectedStudent[key] = value;
        },
      );
    }
  }

  Map<String, List<StudentModel>> _allSection = {};
  StudentViewModel studentViewModel = Get.find<StudentViewModel>();

  getSectionStudent() {
    for (var a in sectionsList) {
      _allSection[a] = studentViewModel.studentMap.values
          .where(
            (element) =>
                element.section == a && element.stdClass == _selectedClass,
          )
          .toList();

      if (_allSection[a]!.isEmpty) {
        _allSection.remove(a);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    examId = generateId("EXAM");
    initExam();
  }

  List<String>? _questionImageFile = [],
      _answerImageFile = [],
      _answerImageFileTemp = [],
      _questionImageFileTemp = [];
  final subjectController = TextEditingController();
  final professorController = TextEditingController();
  final dateController = TextEditingController();
  final examPassMarkController = TextEditingController();
  final examMaxMarkController = TextEditingController();
  String examId = "";

  @override
  void dispose() {
    subjectController.dispose();
    professorController.dispose();
    dateController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    if (subjectController.text.isEmpty ||
        professorController.text.isEmpty ||
        dateController.text.isEmpty ||
        examPassMarkController.text.isEmpty ||
        examMaxMarkController.text.isEmpty ||
        !isNumeric(examPassMarkController.text) ||
        !isNumeric(examMaxMarkController.text)) {
      showErrorDialog("خطأ",
          "يرجى ملء جميع الحقول وتأكد من أن الحقول الرقمية تحتوي على أرقام فقط.");
      return false;
    }
    return true;
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
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 25,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(
                    controller: subjectController,
                    title: 'المقرر'.tr,
                    enable: widget.isEdite,
                  ),
                  CustomTextField(
                    controller: professorController,
                    title: 'الاستاذ'.tr,
                    enable: widget.isEdite,
                  ),
                  CustomTextField(
                    controller: examPassMarkController,
                    title: 'علامة النجاح'.tr,
                    enable: widget.isEdite,
                  ),
                  CustomTextField(
                    controller: examMaxMarkController,
                    title: 'العلامة الكاملة'.tr,
                    enable: widget.isEdite,
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.isEdite)
                        showDatePicker(
                          context: context,
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2100),
                        ).then((date) {
                          if (date != null) {
                            dateController.text = date.toString().split(" ")[0];
                          }
                        });
                    },
                    child: CustomTextField(
                      controller: dateController,
                      title: 'تاريخ البداية'.tr,
                      enable: false,
                      keyboardType: TextInputType.datetime,
                      icon: Icon(
                        Icons.date_range_outlined,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  CustomDropDown(
                    value: _selectedClass,
                    enable: widget.isEdite,
                    listValue: classNameList,
                    label: 'اختر الصف'.tr,
                    onChange: (value) {
                      if (value != null) _selectedClass = value;
                      getSectionStudent();
                      setState(() {});
                    },
                  ),
                  CustomDropDown(
                    value: '',
                    listValue: _allSection.keys.toList(),
                    enable: widget.isEdite,
                    label: 'اختر الشعب للأضافة'.tr,
                    onChange: (value) {
                      _selectedSection.addIf(
                          !_selectedSection.contains(value), value!);
                      setState(() {});
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة ورقة الاسئلة".tr),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            if (widget.isEdite)
                              InkWell(
                                onTap: () async {
                                  FilePickerResult? _ =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                          allowMultiple: true);
                                  if (_ != null) {
                                    _.xFiles.forEach(
                                      (element) async {
                                        _questionImageFileTemp!
                                            .add(await element.path);
                                      },
                                    );
                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: 200,
                                    width: 200,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ...List.generate(
                              _questionImageFileTemp!.length,
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
                                        File(_questionImageFileTemp![index]),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fitHeight,
                                      )),
                                );
                              },
                            ),
                            ...List.generate(
                              _questionImageFile!.length,
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
                                        _questionImageFile![index],
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("صورة ورقة الاجابة".tr),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            if (widget.isEdite)
                              InkWell(
                                onTap: () async {
                                  FilePickerResult? _ =
                                      await FilePicker.platform.pickFiles(
                                          type: FileType.image,
                                          allowMultiple: true);
                                  if (_ != null) {
                                    _.xFiles.forEach(
                                      (element) async {
                                        _answerImageFileTemp!
                                            .add(await element.path);
                                      },
                                    );
                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: 200,
                                    width: 200,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ...List.generate(
                              _answerImageFileTemp!.length,
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
                                        File(_answerImageFileTemp![index]),
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.fitHeight,
                                      )),
                                );
                              },
                            ),
                            ...List.generate(
                              _answerImageFile!.length,
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
                                        _answerImageFile![index],
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
                  if (widget.isEdite)
                    GetBuilder<ExamViewModel>(builder: (examController) {
                      return AppButton(
                        text: 'حفظ'.tr,
                        onPressed: () async {
                          await uploadImages(
                                  _answerImageFileTemp!, "Exam_answer")
                              .then(
                            (value) => _answerImageFile!.addAll(value),
                          );
                          await uploadImages(
                                  _questionImageFileTemp!, "Exam_question")
                              .then(
                            (value) => _questionImageFile!.addAll(value),
                          );
                          if (_validateFields()) {
                            QuickAlert.show(
                                width: Get.width / 2,
                                context: context,
                                type: QuickAlertType.loading,
                                title: 'جاري التحميل'.tr,
                                text: 'يتم العمل على الطلب'.tr,
                                barrierDismissible: false);
                            final exam = ExamModel(
                              id: examId,
                              isDone: false,
                              questionImage: _questionImageFile ?? [],
                              answerImage: _answerImageFile,
                              subject: subjectController.text,
                              professor: professorController.text,
                              examPassMark: examPassMarkController.text,
                              examMaxMark: examMaxMarkController.text,
                              date: DateTime.parse(dateController.text),
                              marks: _selectedStudent,
                            );
                            print(_selectedStudent.length);
                            studentViewModel.addExamToStudent(
                                _selectedStudent.keys.toList(), examId);
                            await examController.addExam(exam);
                            if (widget.examModel != null) Get.back();
                            clearController();
                            Get.back();
                          }
                        },
                      );
                    }),
                ],
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            if (widget.isEdite)
              ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                        height: defaultPadding,
                      ),
                  itemCount: _selectedSection.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, parentIndex) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedSection[parentIndex],
                            style: Styles.headLineStyle1,
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SizedBox(
                            width: Get.width,
                            child: DataTable(
                              clipBehavior: Clip.hardEdge,
                              columns: [
                                DataColumn(label: Text("اسم الطالب")),
                                DataColumn(label: Text("رقم الطالب")),
                                DataColumn(label: Text("تاريخ البداية")),
                                DataColumn(label: Text("ولي الأمر")),
                                DataColumn(label: Text("موجود")),
                              ],
                              rows: _allSection[_selectedSection[parentIndex]]!
                                  .map(
                                (e) {
                                  if (_selectedStudent.keys
                                      .where(
                                        (element) => element == e.studentID,
                                      )
                                      .isNotEmpty) e.available = true;

                                  return studentDataRow(e);
                                },
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            SizedBox(
              height: defaultPadding,
            ),
            if (_selectedStudent.isNotEmpty)
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
                    Text(
                      "الطلاب المختارين",
                      style: Styles.headLineStyle1,
                    ),
                    SizedBox(
                      height: defaultPadding,
                    ),
                    SizedBox(
                      width: Get.width,
                      child: DataTable(clipBehavior: Clip.hardEdge, columns: [
                        DataColumn(label: Text("اسم الطالب")),
                        DataColumn(label: Text("رقم الطالب")),
                        DataColumn(label: Text("تاريخ البداية")),
                        DataColumn(label: Text("ولي الأمر")),
                        DataColumn(label: Text("")),
                      ], rows: [
                        ...List.generate(
                          _selectedStudent.length,
                          (index) => studentSelectedDataRow(
                              studentViewModel.studentMap[
                                  _selectedStudent.keys.elementAt(index)]!,
                              widget.isEdite),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            SizedBox(height: defaultPadding,),
            if (!widget.isEdite)
              Center(
                child: AppButton(
                    text: "تم".tr,
                    onPressed: () {
                      Get.back();
                    }),
              )
          ],
        ),
      ),
    );
  }

  DataRow studentDataRow(StudentModel student) {
    return DataRow(
      cells: [
        DataCell(Text(student.studentName.toString())),
        DataCell(Text(student.studentNumber.toString())),
        DataCell(Text(student.startDate.toString())),
        DataCell(Text(student.parentId!)),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            if (v == false) {
              student.available = v;
              _selectedStudent.remove(student.studentID);
            } else {
              student.available = v;
              _selectedStudent[student.studentID!] = '0.0';
            }

            setState(() {});
          },
          value: student.available,
        )),
      ],
    );
  }

  DataRow studentSelectedDataRow(StudentModel student, bool isEdit) {
    return DataRow(
      cells: [
        DataCell(Text(student.studentName.toString())),
        DataCell(Text(student.studentNumber.toString())),
        DataCell(Text(student.startDate.toString())),
        DataCell(Text(student.parentId!)),
        DataCell(IconButton(
          onPressed: () {
            if (isEdit) {
              student.available = false;

              _selectedStudent.remove(student.studentID);
              setState(() {});
            }
          },
          icon: isEdit
              ? Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                )
              : Container(),
        )),
      ],
    );
  }

  clearController() {
    _questionImageFile = [];
    _answerImageFile = [];
    _answerImageFileTemp = [];
    _questionImageFileTemp = [];
    subjectController.clear();
    professorController.clear();
    dateController.clear();
    examPassMarkController.clear();
    examMaxMarkController.clear();
    examId = generateId("EXAM");
    _selectedSection = [];
    _selectedStudent = {};
    _allSection = {};
    _selectedClass = '';
    setState(() {});
  }
}
