import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';

import '../../utils/const.dart';
import '../Widgets/Data_Row.dart';
import '../Widgets/header.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = [
    "الرقم التسلسلي",
    "العنوان",
    "المبلغ",
    "اسم الموظف",
    "الوصف",
    "الفواتير المدخلة",
    "تاريخ",
    "العمليات",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          context: context,
          title: 'المصاريف'.tr,
          middleText:
              "تعرض هذه الواجهة معلومات عن مصاريف هذه السنة مع امكانية اضافة مصروف جديد \n ملاحظة : مصاريف الحافلات تتم اضافتها من واجهة الحافلات"
                  .tr),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(
                  MediaQuery.sizeOf(context).width -
                      (controller.isDrawerOpen ? 240 : 120),
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
              child: GetBuilder<ExpensesViewModel>(builder: (controller) {
                return SizedBox(
                  width: size + 60,
                  child: Scrollbar(
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child:
                          GetBuilder<DeleteManagementViewModel>(builder: (_) {
                        return DataTable(
                            columnSpacing: 0,
                            dividerThickness: 0.3,
                            columns: List.generate(
                                data.length,
                                (index) => DataColumn(
                                    label: Container(
                                        width: size / data.length,
                                        child: Center(
                                            child: Text(
                                                data[index].toString().tr))))),
                            rows: [
                              for (var expense in controller.allExpenses.values)
                                DataRow(
                                    color: WidgetStatePropertyAll(
                                        checkIfPendingDelete(
                                                affectedId: expense.id)
                                            ? Colors.red
                                            : Colors.transparent),
                                    cells: [
                                      dataRowItem(size / data.length,
                                          expense.id.toString()),
                                      dataRowItem(size / data.length,
                                          expense.title.toString()),
                                      dataRowItem(size / data.length,
                                          expense.total.toString()),
                                      dataRowItem(size / data.length,
                                          expense.userId.toString()),
                                      dataRowItem(size / data.length,
                                          expense.body.toString(), onTap: () {
                                        Get.defaultDialog(
                                            backgroundColor: Colors.white,
                                            title: "التفاصيل".tr,
                                            content: SizedBox(
                                                width: Get.height / 2,
                                                height: Get.height / 2,
                                                child: Center(
                                                  child: Text(
                                                    expense.body.toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: blueColor),
                                                  ),
                                                )));
                                      }),
                                      /*            dataRowItem(
                                          size / data.length, "عرض التفاصيل".tr,
                                          color: Colors.teal),*/
                                      dataRowItem(size / data.length,
                                          expense.images.length.toString(),
                                          onTap: () {
                                        Get.defaultDialog(
                                            backgroundColor: Colors.white,
                                            title: "الصور".tr,
                                            content: Container(
                                                color: Colors.white,
                                                width: Get.height / 1.5,
                                                height: Get.height / 1.5,
                                                child: PageView.builder(
                                                  itemCount:
                                                      expense.images.length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                        width: Get.height / 1.5,
                                                        child: Image.network(
                                                          expense.images[index],
                                                          fit: BoxFit.fitWidth,
                                                        ));
                                                  },
                                                )));
                                      }),
                                      dataRowItem(
                                          size / data.length, expense.date,
                                          color: Colors.teal),
                                      dataRowItem(
                                          size / data.length,
                                          checkIfPendingDelete(
                                                  affectedId: expense.id)
                                              ? "استرجاع".tr
                                              : "حذف".tr,
                                          color: checkIfPendingDelete(
                                                  affectedId: expense.id)
                                              ? Colors.white
                                              : Colors.red, onTap: () {
                                        if (enableUpdate) {
                                          if (checkIfPendingDelete(
                                              affectedId: expense.id))
                                            returnPendingDelete(
                                                affectedId: expense.id);
                                          else if (expense.busId != null) {
                                            addDeleteOperation(
                                                collectionName:
                                                    Const.expensesCollection,
                                                affectedId: expense.id,
                                                relatedId: expense.busId!);
                                          } else {
                                            addDeleteOperation(
                                                collectionName:
                                                    Const.expensesCollection,
                                                affectedId: expense.id);
                                          }
                                        }
                                      }),
                                    ]),
                            ]);
                      }),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
