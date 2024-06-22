import 'dart:math';

import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:vision_dashboard/models/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Widgets/header.dart';
import '../../constants.dart';

import '../../utils/const.dart';


class ExpensesScreen extends StatefulWidget {
  ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<ExpensesModel> expenses = [];

  final ScrollController _scrollController = ScrollController();

  int total = 0;
  int limit = 6000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<ExpensesViewModel>(builder: (controller) {
            total = controller.allExpenses.values.map((e) => e.total,).reduce((value, element) => value + element,);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                 Header(title: "المصاريف"),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 150,
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " مصروف الشهري",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        Spacer(),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(8)),
                            height: 30,
                            width: MediaQuery
                                .sizeOf(context)
                                .width * 0.8,
                            child: Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(microseconds: 500),
                                  decoration: BoxDecoration(color: Colors.blueAccent.shade700, borderRadius: BorderRadius.circular(8)),
                                  width: MediaQuery
                                      .sizeOf(context)
                                      .width * 0.8 * total / limit,
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height: 30,
                                width: MediaQuery
                                    .sizeOf(context)
                                    .width * 0.8,
                                child: Row(
                                  children: [
                                    Text(total >= limit ?"":limit.toString()),
                                    Spacer(),
                                    Text("0"),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30,
                                width: MediaQuery
                                    .sizeOf(context)
                                    .width * 0.8 * min(total / limit,1),
                                child: Row(
                                  children: [
                                    Text(total.toString()),
                                    Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "كل المصاريف",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              child: GetBuilder<DeleteManagementViewModel>(builder: (_) {
                                return DataTable(
                                  columns: [
                                    DataColumn(label: Text("الرقم التسلسلي")),
                                    DataColumn(label: Text("العنوان")),
                                    DataColumn(label: Text("المبلغ")),
                                    DataColumn(label: Text("اسم الموظف")),
                                    DataColumn(label: Text("عدد الفواتير المدخلة")),
                                    DataColumn(label: Text("الوصف")),
                                    DataColumn(label: Text("العمليات")),
                                  ],
                                  rows: List.generate(
                                    controller.allExpenses.keys.length,
                                        (index) => expenseDataRow(controller.allExpenses.values.toList()[index]),
                                  ),
                                  // rows: expenses.map((expense) => expenseDataRow(expense)).toList(),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  DataRow expenseDataRow(ExpensesModel expense) {
    return DataRow(
      color: WidgetStatePropertyAll(checkIfPendingDelete(affectedId: expense.id) ? Colors.red : Colors.transparent),
      cells: [
        DataCell(Text(expense.id)),
        DataCell(Text(expense.title)),
        DataCell(Text(expense.total.toString())),
        DataCell(Text(expense.userId)),
        DataCell(Text(expense.images.length.toString())),
        DataCell(SizedBox(width: 300, child: Text(expense.body.toString(), maxLines: 1, overflow: TextOverflow.ellipsis,))),
        DataCell(
            Row(
              children: [
                ElevatedButton(

                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(primaryColor)
                    ), onPressed: () {
                  Get.defaultDialog(
                      backgroundColor: Colors.white,
                      title: "التفاصيل", content: SizedBox(
                      width: Get.height / 2,
                      height: Get.height / 2,
                      child: Text(expense.body.toString(), style: TextStyle(fontSize: 20),)));
                }, child: Text("التفاصيل", style: TextStyle(color: Colors.white),)),
                SizedBox(width: 20,),
                if(expense.images.isEmpty)
                  SizedBox(
                    width: 80,
                  )
                else
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(primaryColor)
                      ),
                      onPressed:
                      expense.images.isEmpty ? null :
                          () {
                        Get.defaultDialog(
                            backgroundColor: Colors.white,
                            title: "الصور", content: Container(
                            color: Colors.white,
                            width: Get.height / 1.5,
                            height: Get.height / 1.5,
                            child: PageView.builder(
                              itemCount: expense.images.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                    width: Get.height / 1.5,
                                    child: Image.network(expense.images[index], fit: BoxFit.fitWidth,));
                              },)));
                      }, child: Text("الصور", style: TextStyle(color: Colors.white),)),
                SizedBox(width: 20,),
                if(!checkIfPendingDelete(affectedId: expense.id))
                  InkWell(
                      onTap: () {
                        addDeleteOperation(collectionName: Const.expensesCollection, affectedId: expense.id);
                      },
                      child: Icon(Icons.close, color: Colors.red,)),
              ],
            )
        )
      ],
    );
  }
}
