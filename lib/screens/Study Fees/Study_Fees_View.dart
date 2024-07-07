import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/models/Installment_model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';

import '../../constants.dart';
import '../../controller/home_controller.dart';
import '../../models/Parent_Model.dart';
import '../Parents/Controller/Parents_View_Model.dart';
import '../Widgets/Custom_Text_Filed.dart';
import '../Widgets/Square_Widget.dart';
import '../Widgets/expanded_data_row.dart';
import '../Widgets/header.dart';

class StudyFeesView extends StatefulWidget {
  const StudyFeesView({super.key});

  @override
  State<StudyFeesView> createState() => _StudyFeesViewState();
}

class _StudyFeesViewState extends State<StudyFeesView> {
  List data = [
    "الاسم الكامل",
    "الاولاد",
    "المستلم",
    "المبلغ الكامل",
    "المستحق",
    "الحالة",
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          context: context,
        title: 'الرسوم الدراسية'.tr,middleText: "تعرض هذه الواجهة اجمالي ادفعات المستلمة من الطلاب و اجمالي الدفعات الخير مستلمة واجمالي الدفعات المتأخرة عن الدفع عن هذا الشهر مع جدول يوضح تفاصيل الدفعات لكل اب مع امكانية استلام دفعة او التراجع عنها".tr
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(
                  MediaQuery.sizeOf(context).width -
                      (controller.isDrawerOpen ? 240 : 120),
                  1000) -
              60;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                GetBuilder<StudentViewModel>(builder: (studentController) {
                  return SizedBox(
                    width: Get.width,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: MediaQuery.sizeOf(context).width < 800
                          ? WrapAlignment.center
                          : WrapAlignment.spaceEvenly,
                      runSpacing: 25,
                      spacing: 0,
                      children: [
                        InkWell(
                            child: SquareWidget(
                                title: "الدفعات القادمة",
                                body:
                                    "${studentController.getAllNunReceivePay()}",
                                color: primaryColor,
                                png: "assets/poor.png")),
                        InkWell(
                            child: SquareWidget(
                                title: "الدفعات المستلمة",
                                body: "${studentController.getAllReceivePay()}",
                                color: blueColor,
                                png: "assets/profit.png")),
                        InkWell(
                            child: SquareWidget(
                                title: "الدفعات المتأخرة",
                                body:
                                    "${studentController.getAllNunReceivePayThisMonth()}",
                                color: Colors.redAccent,
                                png: "assets/late-payment.png")),
                        InkWell(
                            child: SquareWidget(
                                title: "الاجمالي",
                                body: "${studentController.getAllTotalPay()}",
                                color: Colors.black,
                                png: "assets/budget.png")),
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child:
                      GetBuilder<ParentsViewModel>(builder: (parentController) {
                    return SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: GetBuilder<StudentViewModel>(
                            builder: (studentController) {
                          return SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columnSpacing: 0,
                                dividerThickness: 0.3,

                                columns: List.generate(
                                    data.length,
                                    (index) => DataColumn(
                                        label: Container(
                                            width: size / data.length,
                                            child: Center(
                                                child: Text(data[index].toString().tr))))),
                                rows: [
                                  ...List.generate(
                                    parentController.parentMap.values
                                        .where(
                                          (element) =>
                                              (element.children?.length ?? 0) >
                                              0,
                                        )
                                        .length,
                                    (index) {
                                      ParentModel parent =
                                          parentController.parentMap.values
                                              .where(
                                                (element) =>
                                                    (element.children?.length ??
                                                        0) >
                                                    0,
                                              )
                                              .toList()[index];
                                      int payment = 0;
                                      int totalPayment = 0;
                                      for (var pat in parent.children!
                                          .map((e) => studentController
                                              .studentMap[e]!.totalPayment)
                                          .toList()) {
                                        totalPayment += pat!;
                                      }
                                      for (var pat in parent.children!
                                          .map((e) => studentController
                                              .studentMap[e]
                                              ?.installmentRecords
                                              ?.values
                                              .where(
                                                (element) =>
                                                    element.isPay == true,
                                              )
                                              .toList())
                                          .toList()) {
                                        for (var pay in pat ?? []) {
                                          payment += int.parse(
                                              pay.installmentCost.toString());
                                        }
                                      }
                                      return DataRow(
                                          color: WidgetStatePropertyAll(
                                              studentController
                                                      .chekaIfHaveLateInstallment(
                                                          parent.id!)
                                                  ? Colors.red.shade100
                                                  : Colors.transparent),
                                          cells: [
                                            dataRowItem(size / data.length,
                                                parent.fullName.toString()),
                                            dataRowItem(
                                                size / data.length,
                                                parent.children
                                                    ?.map(
                                                      (e) => studentController
                                                          .studentMap[e]!
                                                          .studentName,
                                                    )
                                                    .toString()),
                                            dataRowItem(size / data.length,
                                                "$payment درهم ".toString()),
                                            dataRowItem(size / data.length,
                                                "$totalPayment درهم"),
                                            dataRowItem(size / data.length,
                                                "${totalPayment - payment} درهم"),
                                            dataRowItem(
                                                size / data.length,
                                                payment - totalPayment >= 0
                                                    ? "تم استلام كامل المبلغ".tr
                                                    : "اضافة دفعة".tr,
                                                color: payment - totalPayment >=
                                                        0
                                                    ? blueColor
                                                    : Colors.green, onTap: () {
                                              Map<String,
                                                      List<InstallmentModel>>
                                                  instalmentStudent = {};

                                              for (var child
                                                  in parent.children!) {
                                                //studentController.studentMap[child]!.studentName!
                                                instalmentStudent[child] = [];
                                                studentController
                                                    .studentMap[child]!
                                                    .installmentRecords!
                                                    .values
                                                    .forEach(
                                                  (element) {
                                                    instalmentStudent[child]!
                                                        .add(element);
                                                  },
                                                );
                                              }

                                              showInstallmentDialog(
                                                  context, instalmentStudent);
                                            }),
                                          ]);
                                    },
                                  )
                                ]),
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void showInstallmentDialog(BuildContext context,
      Map<String, List<InstallmentModel>> installmentStudent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<StudentViewModel>(builder: (studentController) {
          return Dialog(
            backgroundColor: secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              width: Get.width / 1.5,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                children: [
                  Center(
                      child: Text('سجل الدفعات', style: Styles.headLineStyle1)),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                            height: defaultPadding,
                          ),
                      physics: ClampingScrollPhysics(),
                      itemCount: installmentStudent.length,
                      itemBuilder: (context, parentIndex) {
                        List<InstallmentModel> installment = installmentStudent
                            .values
                            .elementAt(
                                parentIndex) /*.where((element) => element.isPay!=true,)*/
                            .toList();
                        return Container(
                          alignment: Alignment.center,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: installment.length,
                            itemBuilder: (context, index) {
                              bool isLate = int.parse(
                                      installment[index].installmentDate!) <=
                                  DateTime.now().month;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (index == 0)
                                      Text(
                                        studentController
                                            .studentMap[installmentStudent.keys
                                                .elementAt(parentIndex)]!
                                            .studentName!,
                                        style: Styles.headLineStyle2,
                                      ),
                                    if (index == 0)
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                    Wrap(
                                      alignment: WrapAlignment.spaceEvenly,
                                      children: [

                                        Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: Get.width / 1.5,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: isLate &&
                                                          installment[index]
                                                                  .isPay !=
                                                              true
                                                      ? Colors.red
                                                          .withOpacity(0.5)
                                                      : installment[index]
                                                                  .isPay ==
                                                              true
                                                          ? Colors.green
                                                              .withOpacity(0.5)
                                                          : primaryColor
                                                              .withOpacity(
                                                                  0.5))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14.0, horizontal: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Spacer(),
                                                CustomTextField(
                                                  controller:
                                                      TextEditingController()
                                                        ..text =
                                                            installment[index]
                                                                .installmentDate
                                                                .toString(),
                                                  title: 'الشهر',
                                                  enable: false,
                                                  size: Get.width / 7.5,
                                                  isFullBorder: true,
                                                ),
                                                Spacer(),
                                                CustomTextField(
                                                  controller:
                                                      TextEditingController()
                                                        ..text =
                                                            installment[index]
                                                                .installmentCost
                                                                .toString(),
                                                  title: "الدفعة",
                                                  enable: false,
                                                  size: Get.width / 7.5,
                                                  isFullBorder: true,
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                          ),
                                        ),

                                        if (installment[index].isPay != true)
                                          IconButton(
                                              onPressed: () {
                                                studentController
                                                    .setInstallmentPay(
                                                        installment[index]
                                                            .installmentId!,
                                                        installmentStudent.keys
                                                            .elementAt(
                                                                parentIndex),
                                                        true);
                                                Get.back();
                                              },
                                              icon: Row(
                                                children: [
                                                  Text(
                                                    "تسديد!",
                                                    style: Styles.headLineStyle3
                                                        .copyWith(
                                                            color:
                                                                primaryColor),
                                                  ),
                                                  Icon(
                                                    Icons.check,
                                                    color: Colors.blue,
                                                  )
                                                ],
                                              ))
                                        else
                                          GetBuilder<DeleteManagementViewModel>(
                                            builder: (deleteController) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: AppButton(
                                                  text:checkIfPendingDelete(affectedId: installment[index]
                                                      .installmentId!)?'في انتظار الموفقة..': "تراجع",
                                                  onPressed: () {
                                                    if(checkIfPendingDelete(affectedId: installment[index]
                                                        .installmentId!))
                                                      QuickAlert.show(context: context, type:QuickAlertType.info,width: Get.width/2,title: "مراجعة المسؤول".tr,text: "يرجى مراجعة مسؤول المنصة".tr);
                                                      else
                                                   addDeleteOperation(collectionName: installmentCollection, affectedId: installment[index]
                                                       .installmentId!,relatedId:installmentStudent.keys
                                                       .elementAt(
                                                       parentIndex) );
                                         /*           studentController
                                                        .setInstallmentPay(
                                                            installment[index]
                                                                .installmentId!,
                                                            installmentStudent.keys
                                                                .elementAt(
                                                                    parentIndex),
                                                            false);*/

                                                  },
                                                ),
                                              );
                                            }
                                          ),

                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                      child: AppButton(
                    text: "تم",
                    onPressed: () {
                      Get.back();
                    },
                  )),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
