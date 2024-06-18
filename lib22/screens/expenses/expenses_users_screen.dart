import 'dart:math';

import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:vision_dashboard/models/Parent_Model.dart';
import 'package:vision_dashboard/models/RecentFile.dart' hide demoRecentFiles;
import 'package:vision_dashboard/models/expenses_model.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/components/date_table.dart';
import 'expenses_input_form.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({super.key});
  final List<ExpensesModel> expenses = [];
  final ScrollController _scrollController = ScrollController();



  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Get.find<HomeViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<ExpensesViewModel>(builder: (controller) {
            return Column(
              children: [
                Row(
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: homeViewModel.controlMenu,
                      ),
                    if (!Responsive.isMobile(context))
                      Text(
                        "المصاريف",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    if (!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        hintText: "بحث",
                        fillColor: secondaryColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.all(defaultPadding * 0.75),
                            margin: EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: SvgPicture.asset("assets/icons/Search.svg"),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  child: ExpensesInputForm()
                ),
                SizedBox(
                  height: 25,
                ),
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: DataTable(
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  DataRow expenseDataRow(ExpensesModel expense) {
    return DataRow(
      cells: [
        DataCell(Text(expense.id)),
        DataCell(Text(expense.title)),
        DataCell(Text(expense.total.toString())),
        DataCell(Text(expense.userId)),
        DataCell(Text(expense.images.length.toString())),
        DataCell(SizedBox(width:300,child: Text(expense.body.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,))),
        DataCell(
          Row(
            children: [
              ElevatedButton(

                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor)
                  ),onPressed: (){
               Get.defaultDialog(

                   backgroundColor: Colors.white,
                   title: "التفاصيل",content: SizedBox(
                   width: Get.height/2,
                   height: Get.height/2,
                   child: Text(expense.body.toString(),style: TextStyle(fontSize: 20),)));
              }, child: Text("التفاصيل",style: TextStyle(color: Colors.white),)),
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
              expense.images.isEmpty?null:
                  (){
                Get.defaultDialog(
                    backgroundColor: Colors.white,
                    title: "الصور",content: Container(
                  color: Colors.white,
                    width: Get.height/1.5,
                    height: Get.height/1.5,
                    child:PageView.builder(
                      itemCount: expense.images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                      return SizedBox(
                          width: Get.height/1.5,
                          child: Image.network(expense.images[0],fit: BoxFit.fitWidth,));
                    },)));
              }, child: Text("الصور",style: TextStyle(color: Colors.white),)),
              SizedBox(width: 20,),
              InkWell(
                  onTap: (){
                    ExpensesViewModel expensesViewModel = Get.find<ExpensesViewModel>();
                    // expensesViewModel.deleteExpenses(expense);
                  },
                  child: Icon(Icons.close,color: Colors.red,)),
            ],
          )
        )
      ],
    );
  }
}
