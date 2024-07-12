import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/models/Parent_Model.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';
import 'package:vision_dashboard/screens/Parents/Controller/Parents_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Student/student_user_details.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Student_Model.dart';
import '../Widgets/Custom_Drop_down.dart';
import '../Widgets/Custom_Pluto_Grid.dart';
import '../Widgets/Custom_Text_Filed.dart';
import '../Widgets/Data_Row.dart';
import '../Widgets/header.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  ExamViewModel exam = Get.find<ExamViewModel>();

  ParentsViewModel parent = Get.find<ParentsViewModel>();
 /*  final ScrollController _scrollController = ScrollController();
  List data = [
    "اسم الطالب",
    "رقم الطالب",
    "الجنس",
    "التولد",
    "الصف",
    "الشعبة",
    "تاريخ البداية",
    "الحافلة",
    "ولي الأمر",
    "علامات الطالب",
    "المعدل",
    "الخيارات",
    "",
  ];
  List filterData=[
    "اسم الطالب",
    "رقم الطالب",
    "الجنس",
    "التولد",
    "الصف",
    "الشعبة",
    "تاريخ البداية",
    "الحافلة",
    "ولي الأمر",
  ];
  TextEditingController searchController = TextEditingController();
  String searchValue = '';
  int searchIndex = 0;*/

  String currentId = '';

  bool getIfDelete() {
    return checkIfPendingDelete(affectedId: currentId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentViewModel>(builder: (controller) {
      return Scaffold(
        appBar: Header(
            context: context,
            title: 'الطلاب'.tr,
            middleText:
                "تعرض هذه الواجهة معلومات عن الطلاب مع امكانية تعديل الطالب او حذفه او اضافة طالب جديد \n ملاحظة١ : عند حذف الطالب يتم حذفه من الاباء ومن الامتحانات التي قام بها ومن الباص المشترك فيه ان كان مشترك \n ملاحظة ٢ : لايمكن تعديل الاب الخاص بالطالب"
                    .tr),
        body: SingleChildScrollView(
          child: GetBuilder<HomeViewModel>(builder: (hController) {
            double size = max(
                    MediaQuery.sizeOf(context).width -
                        (hController.isDrawerOpen ? 240 : 120),
                    1000) -
                60;
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  height: Get.height,
                  width: size + 60,
                  child: CustomPlutoGrid(
                    controller: controller,
                    idName: "الرقم التسلسلي",
                    onSelected: (event) {
                      currentId = event.row?.cells["الرقم التسلسلي"]?.value;
                      setState(() {});
                    },
                  ),
                ),
              ),
            );
          }),
        ),
        floatingActionButton: enableUpdate && currentId != ''
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<DeleteManagementViewModel>(builder: (_) {
                    return FloatingActionButton(
                      backgroundColor: getIfDelete()
                          ? Colors.greenAccent.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5),
                      onPressed: () {
                        if (enableUpdate) {
                          if (getIfDelete())
                            _.returnDeleteOperation(
                                affectedId: controller
                                    .studentMap[currentId]!.studentID
                                    .toString());
                          else {
                            addDeleteOperation(
                                collectionName: parentsCollection,
                                affectedId: controller
                                    .studentMap[currentId]!.studentID!);
                          }
                        }
                      },
                      child: Icon(
                        getIfDelete()
                            ? Icons.restore_from_trash_outlined
                            : Icons.delete,
                        color: Colors.white,
                      ),
                    );
                  }),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  FloatingActionButton(
                    backgroundColor: primaryColor.withOpacity(0.5),
                    onPressed: () {
                      showStudentInputDialog(
                          context, controller.studentMap[currentId]!);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  FloatingActionButton(
                    backgroundColor: primaryColor.withOpacity(0.5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => buildParentAlertDialog(
                            parent.parentMap[  controller.studentMap[currentId]!.parentId!]!  ),
                      );

                    },
                    child: Icon(
                      Icons.group,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  // if(controller.studentMap[currentId]!.stdExam?.isNotEmpty??false)
                  FloatingActionButton(
                    backgroundColor:(controller.studentMap[currentId]!.stdExam?.isNotEmpty??false) ?primaryColor:Colors.grey.withOpacity(0.5),

                    onPressed: () {
                      if(controller.studentMap[currentId]!.stdExam?.isNotEmpty??false)
                      showDialog(
                        context: context,
                        builder: (context) => buildMarksAlertDialog(
                            controller.studentMap[currentId]!),
                      );
                    },
                    child: Icon(
                      Icons.collections_bookmark_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Container(),
      );
    });
  }

  AlertDialog buildMarksAlertDialog(StudentModel student) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      actions: [
        Column(
          children: [
            Container(
              width: Get.width / 3,
              height:
                  min(60.0 * (student.stdExam?.length ?? 1), Get.height / 3),
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Spacer(),
                        Text("المادة: "),
                        Text(
                          exam.examMap[student.stdExam![index]]!.subject!,
                          style: Styles.headLineStyle2,
                        ),
                        Spacer(),
                        Text("العلامة: "),
                        Text(
                          "${(double.parse(exam.examMap[student.stdExam![index]]!.marks![student.studentID]!) * double.parse(exam.examMap[student.stdExam![index]]!.examMaxMark!)) / 100}",
                          style: Styles.headLineStyle2,
                        ),
                        Spacer(),
                      ],
                    ),
                  );
                },
                itemCount: student.stdExam?.length ?? 0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppButton(
              text: "تم",
              onPressed: () {
                Get.back();
              },
            )
          ],
        )
      ],
    );
  }

  AlertDialog buildParentAlertDialog(
      ParentModel parentModel) {
    return AlertDialog(
      backgroundColor: secondaryColor,
      actions: [
        Column(
          children: [
            Container(
              width: Get.width / 3,
              height: Get.height / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: Get.width/10,
                          child: Text("الاسم الكامل: ")),
                      SizedBox(
                        width: Get.width/9,
                        child: Text(
                          parentModel.fullName.toString(),
                          style: Styles.headLineStyle2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: Get.width/10,
                          child: Text("العنوان: ")),
                      SizedBox(
                        width: Get.width/9,
                        child: Text(
                          parentModel.address.toString(),
                          style: Styles.headLineStyle2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("الجنسية: "),
                      Text(
                        parentModel.nationality.toString(),
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("العمر: "),
                      Text(
                        parentModel.age.toString(),
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("العمل: "),
                      Text(
                        parentModel.work.toString(),
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("رقم الام: "),
                      Text(
                        parentModel.motherPhone.toString(),
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("رقم الطوارئ: "),
                      Text(
                        parentModel.emergencyPhone.toString(),
                        style: Styles.headLineStyle2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppButton(
              text: "تم",
              onPressed: () {
                Get.back();
              },
            )
          ],
        )
      ],
    );
  }

  void showStudentInputDialog(BuildContext context, dynamic student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width / 1.5,
            child: StudentInputForm(
              studentModel: student,
            ),
          ),
        );
      },
    );
  }
}
/*    child: Column(

                children: [
                  Wrap(
                    spacing: 25,
                    children: [
                      CustomTextField(
                        size: Get.width / 6,
                        controller: searchController,
                        title: "ابحث",
                        onChange: (value) {
                          setState(() {});
                        },
                      ),
                      CustomDropDown(
                        size: Get.width / 6,
                        value: searchValue,
                        listValue: filterData
                            .map(
                              (e) => e.toString(),
                        )
                            .toList(),
                        label: "اختر فلتر البحث",
                        onChange: (value) {
                          searchValue = value ?? '';
                          searchIndex=filterData.indexOf(searchValue);
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  Divider(color: primaryColor.withOpacity(0.2),),
                  SizedBox(height: 5,),
                  GetBuilder<StudentViewModel>(builder: (controller) {
                    return SizedBox(
                      width: size + 60,
                      child: GetBuilder<DeleteManagementViewModel>(builder: (_) {
                        return Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columnSpacing: 0,
                                dividerThickness: 0,
                                columns: List.generate(
                                    data.length,
                                    (index) => DataColumn(
                                        label: Container(
                                            width: size / data.length,
                                            child:
                                                Center(child: Text(data[index].toString().tr))))),
                                rows: [
                                  for (var student in controller.studentMap.values.where((element) {
                                    if (searchController.text == '')
                                      return true;
                                    else {
                                        switch (searchIndex) {
                                          case 0:
                                            return element.studentName!
                                                .contains(
                                                    searchController.text);
                                          case 1:
                                            return element.studentNumber!
                                                .contains(
                                                    searchController.text);
                                          case 2:
                                            return element.gender!.contains(
                                                searchController.text);
                                          case 3:
                                            return element.startDate!.contains(
                                                searchController.text);
                                          case 4:
                                            return element.stdClass!.contains(
                                                searchController.text);
                                          case 5:
                                            return element.section!.contains(
                                                searchController.text);
                                          case 6:
                                            return element.startDate!.contains(
                                                searchController.text);
                                          case 7:
                                            return element.bus!.contains(
                                                searchController.text);
                                          case 8:
                                            return element.parentId!.contains(
                                                parent
                                                        .parentMap.values.where((element) => element.fullName!.contains(searchController
                                                    .text),)
                                                        .toList().map((e) => e.id,).firstOrNull ??
                                                    '894');

                                          default:
                                            return false;

                                        }
                                      }
                                  },).toList())
                                    DataRow(

                                        color: WidgetStatePropertyAll(
                                            checkIfPendingDelete(
                                                    affectedId: student.studentID!)
                                                ? Colors.redAccent.withOpacity(0.2)
                                                : Colors.transparent),
                                        cells: [
                                          dataRowItem(size / data.length,
                                              student.studentName.toString()),
                                          dataRowItem(size / data.length,
                                              student.studentNumber.toString()),
                                          dataRowItem(size / data.length,
                                              student.gender.toString()),
                                          dataRowItem(size / data.length,
                                              student.StudentBirthDay.toString()),
                                          dataRowItem(
                                              size / data.length,
                                              student.stdClass.toString() +
                                                  " " +
                                                  student.stdLanguage.toString()),
                                          dataRowItem(size / data.length,
                                              student.section.toString()),
                                          dataRowItem(
                                              size / data.length,
                                              student.startDate
                                                  .toString()
                                                  .split(" ")[0]),
                                          dataRowItem(size / data.length,
                                              student.bus.toString()),
                                          dataRowItem(
                                              size / data.length,
                                              parent
                                                  .parentMap[
                                                      student.parentId.toString()]!
                                                  .fullName
                                                  .toString(), onTap: () {
                                            ParentModel parentModel =
                                                parent.parentMap[
                                                    student.parentId.toString()]!;
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  buildParentAlertDialog(
                                                      parentModel, student),
                                            );
                                          }),
                                          dataRowItem(size / data.length, "عرض".tr,
                                              color: Colors.teal, onTap: () {

                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  buildMarksAlertDialog(student),
                                            );
                                          }),
                                          dataRowItem(size / data.length,
                                              student.grade.toString()),
                                          dataRowItem(size / data.length, "تعديل".tr,
                                              color: Colors.teal, onTap: () {
                                                if (enableUpdate == true)
                                                  showStudentInputDialog(
                                                      context, student);
                                              }),
                                          dataRowItem(size / data.length,checkIfPendingDelete(affectedId: student.studentID!)?"استرجاع".tr: "حذف".tr,
                                              color:checkIfPendingDelete(affectedId: student.studentID!)?Colors.white: Colors.red, onTap: () {
                                            if (enableUpdate)
                                              if (checkIfPendingDelete(affectedId: student.studentID!))
                                                _.returnDeleteOperation(
                                                    affectedId: student.studentID!);
                                              else
                                                addDeleteOperation(affectedId:
                                                    student.studentID!,collectionName: studentCollection,relatedId: student.parentId!,relatedList:student.stdExam);

                                          }),
                                        ]),
                                ]),
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),*/
