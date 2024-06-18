import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Parents/Parents_View_Model.dart';
import 'package:vision_dashboard/screens/delete_management/delete_management_view.dart';
import '../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Parent_Model.dart';
import '../../responsive.dart';
import '../dashboard/components/date_table.dart';
import 'parent_user_details.dart';

class ParentUsersScreen extends StatelessWidget {
  ParentUsersScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  DataRow parentDataRow(
      ParentModel parent, bool isDelete, ParentsViewModel controller) {
    return DataRow(
      color: isDelete ? WidgetStatePropertyAll(Colors.redAccent) : null,
      cells: [
        DataCell(Text(parent.fullName!)),
        DataCell(Text(parent.address!)),
        DataCell(Text(parent.nationality!)),
        DataCell(Text(parent.age!)),
        DataCell(Text(parent.work!)),
        DataCell(Text(parent.startDate.toString().split(" ")[0])),
        DataCell(Text(parent.motherPhone.toString())),
        DataCell(Text(parent.emergencyPhone.toString())),
        DataCell(IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white,
            ))),
        DataCell(isDelete?Container():Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  controller.deleteParent(parent.id.toString());
                  print('delete');
                },
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.redAccent,
                )),
          ],
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: GetBuilder<HomeViewModel>(builder: (controller) {
            return Column(
              children: [
                Row(
                  children: [
                    if (!Responsive.isDesktop(context))
                      IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: primaryColor,
                        ),
                        onPressed: controller.controlMenu,
                      ),
                    if (!Responsive.isMobile(context))
                      Text(
                        "اولياء الامور",
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
                        "كل اولياء الامور",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      GetBuilder<ParentsViewModel>(builder: (controller) {
                        return SizedBox(
                          width: Get.width,
                          child: Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              child: GetBuilder<DeleteManagementViewModel>(
                                builder: (_) {
                                  return DataTable(
                                    columns: [
                                      DataColumn(label: Text("الاسم الكامل")),
                                      DataColumn(label: Text("العنوان")),
                                      DataColumn(label: Text("الجنسية")),
                                      DataColumn(label: Text("العمر")),
                                      DataColumn(label: Text("العمل")),
                                      DataColumn(label: Text("تاريخ البداية")),
                                      DataColumn(label: Text("رقم الام")),
                                      DataColumn(label: Text("رقم الطوارئ")),
                                      DataColumn(label: Text("سجل الأحداث")),
                                      DataColumn(label: Text("الخيارات")),
                                    ],
                                    rows: controller.parentMap.values
                                        .map((parent) => parentDataRow(
                                            parent,
                                            checkIfPendingDelete(
                                                affectedId: parent.id.toString()),
                                            controller))
                                        .toList(),
                                  );
                                }
                              ),
                            ),
                          ),
                        );
                      }),
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
}
