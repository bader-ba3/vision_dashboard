import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';

import '../../utils/const.dart';
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
    "كامل الوصف",
    "عدد الفواتير المدخلة",
    "الصور",
    "العمليات"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'المصاريف',
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
                                        child:
                                            Center(child: Text(data[index]))))),
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
                                          expense.body.toString()),
                                      dataRowItem(
                                          size / data.length, "عرض التفاصيل",
                                          color: Colors.teal, onTap: () {
                                        Get.defaultDialog(
                                            backgroundColor: Colors.white,
                                            title: "التفاصيل",
                                            content: SizedBox(
                                                width: Get.height / 2,
                                                height: Get.height / 2,
                                                child: Text(
                                                  expense.body.toString(),
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )));
                                      }),
                                      dataRowItem(size / data.length,
                                          expense.images.length.toString()),
                                      dataRowItem(
                                          size / data.length, "عرض الصور",
                                          color: Colors.teal, onTap: () {
                                        Get.defaultDialog(
                                            backgroundColor: Colors.white,
                                            title: "الصور",
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
                                          size / data.length,
                                          checkIfPendingDelete(
                                                  affectedId: expense.id)
                                              ? "استرجاع"
                                              : "حذف",
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

  dataRowItem(size, text, {onTap, color}) {
    return DataCell(
      Container(
        width: size,
        child: InkWell(
            onTap: onTap,
            child: Center(
                child: Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: color == null ? null : TextStyle(color: color),
            ))),
      ),
    );
  }
}
