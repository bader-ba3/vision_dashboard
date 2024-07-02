import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';

import '../../constants.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  ScrollController scrollController = ScrollController();
  ScrollController secScrollController = ScrollController();
  int? SelectedClass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 200,
            child: Column(
              children: [
                Container(
                    height: 75,
                    child: Center(
                        child: Text(
                      "الصفوف".tr,
                      style: Styles.headLineStyle2.copyWith(color: blueColor),
                    ))),
                Container(
                  height: 6,
                  color: secondaryColor,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: classNameList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            SelectedClass = index;
                            setState(() {});
                          },
                          child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: SelectedClass == index
                                      ? primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                classNameList[index],
                                style: SelectedClass == index
                                    ? Styles.headLineStyle2
                                        .copyWith(color: Colors.white)
                                    : Styles.headLineStyle2
                                        .copyWith(color: blueColor),
                              ))),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 5,
            color: secondaryColor,
          ),
          if (SelectedClass == null)
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Text(
                  "يرجى إختيار احد الصفوف لمشاهدة تفاصيله".tr,
                  style: Styles.headLineStyle2.copyWith(color: blueColor),
                  textAlign: TextAlign.center,
                )),
              ),
            )
          else
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "عربي".tr,
                          style:
                              Styles.headLineStyle2.copyWith(color: blueColor),
                        )),
                      ),
                    ),
                    Container(
                      height: 75,
                      width: 3,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "لغات".tr,
                          style:
                              Styles.headLineStyle2.copyWith(color: blueColor),
                        )),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 5,
                  color: secondaryColor,
                ),
                Get.find<StudentViewModel>()
                            .studentMap
                            .values
                            .where(
                              (element) =>
                                  element.stdClass ==
                                      classNameList[SelectedClass!] &&
                                  (element.stdLanguage == 'لغات' ||
                                      element.stdLanguage == 'عربي'),
                            )
                            .toList()
                            .length ==
                        0
                    ? Expanded(
                        child: Center(
                            child: Text(
                        "لايوجد طلاب".tr,
                        style: Styles.headLineStyle2.copyWith(color: blueColor),
                      )))
                    : GetBuilder<StudentViewModel>(
                        builder: (studentController) {
                        return Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              studentController.studentMap.values
                                          .where(
                                            (element) =>
                                                element.stdClass ==
                                                    classNameList[
                                                        SelectedClass!] &&
                                                element.stdLanguage == 'عربي',
                                          )
                                          .toList()
                                          .length ==
                                      0
                                  ? Expanded(
                                      child: Center(
                                          child: Text("لايوجد طلاب".tr,
                                              style: Styles.headLineStyle2
                                                  .copyWith(color: blueColor))))
                                  : Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: studentController
                                            .studentMap.values
                                            .where(
                                              (element) =>
                                                  element.stdClass ==
                                                      classNameList[
                                                          SelectedClass!] &&
                                                  element.stdLanguage == 'عربي',
                                            )
                                            .toList()
                                            .length,
                                        itemBuilder: (context, index) {
                                          List<StudentModel> listStudent =
                                              studentController
                                                  .studentMap.values
                                                  .where(
                                                    (element) =>
                                                        element.stdClass ==
                                                            classNameList[
                                                                SelectedClass!] &&
                                                        element.stdLanguage ==
                                                            'عربي',
                                                  )
                                                  .toList();
                                          return Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                        listStudent[index]
                                                            .studentName!,
                                                        style: Styles
                                                            .headLineStyle3
                                                            .copyWith(
                                                                color:
                                                                    blueColor))),
                                              ),
                                              Container(
                                                height: 3,
                                                color: secondaryColor,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                              Container(
                                height: double.maxFinite,
                                width: 3,
                                color: Colors.grey.shade300,
                              ),
                              studentController.studentMap.values
                                          .where(
                                            (element) =>
                                                element.stdClass ==
                                                    classNameList[
                                                        SelectedClass!] &&
                                                element.stdLanguage == 'لغات',
                                          )
                                          .toList()
                                          .length ==
                                      0
                                  ? Expanded(
                                      child: Center(
                                          child: Text("لايوجد طلاب".tr,
                                              style: Styles.headLineStyle2
                                                  .copyWith(color: blueColor))))
                                  : Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: studentController
                                            .studentMap.values
                                            .where(
                                              (element) =>
                                                  element.stdClass ==
                                                      classNameList[
                                                          SelectedClass!] &&
                                                  element.stdLanguage == 'لغات',
                                            )
                                            .toList()
                                            .length,
                                        itemBuilder: (context, index) {
                                          List<StudentModel> listStudent =
                                              studentController
                                                  .studentMap.values
                                                  .where(
                                                    (element) =>
                                                        element.stdClass ==
                                                            classNameList[
                                                                SelectedClass!] &&
                                                        element.stdLanguage ==
                                                            'لغات',
                                                  )
                                                  .toList();
                                          return Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text(
                                                        listStudent[index]
                                                            .studentName!,
                                                        style: Styles
                                                            .headLineStyle3
                                                            .copyWith(
                                                                color:
                                                                    blueColor))),
                                              ),
                                              Container(
                                                height: 3,
                                                color: secondaryColor,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                        );
                      }),
              ],
            )),
        ],
      ),
    );
  }
}
