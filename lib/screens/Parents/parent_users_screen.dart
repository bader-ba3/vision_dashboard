import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Parents/parent_user_details.dart';
import '../../constants.dart';
import '../Widgets/header.dart';
import 'Controller/Parents_View_Model.dart';


class ParentUsersScreen extends StatefulWidget {
  const ParentUsersScreen({super.key});

  @override
  State<ParentUsersScreen> createState() => _ParentUsersScreenState();
}

class _ParentUsersScreenState extends State<ParentUsersScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = ["الاسم الكامل", "العنوان", "الجنسية", "العمر", "العمل", "تاريخ البداية", "رقم الام", "رقم الطوارئ", "سجل الأحداث", "الخيارات", "الحذف"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'اولياء الامور',),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(MediaQuery
              .sizeOf(context)
              .width - (controller.isDrawerOpen ? 240 : 120), 1000) - 60;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  GetBuilder<ParentsViewModel>(builder: (controller) {
                    return SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columnSpacing: 0, columns:
                          List.generate(data.length, (index) => DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))),
                              rows: [
                                for (var parent in controller.parentMap.values.toList())
                                  DataRow(cells: [
                                    dataRowItem(size / data.length, parent.fullName.toString()),
                                    dataRowItem(size / data.length, parent.address.toString()),
                                    dataRowItem(size / data.length, parent.nationality.toString()),
                                    dataRowItem(size / data.length, parent.age.toString()),
                                    dataRowItem(size / data.length, parent.work.toString()),
                                    dataRowItem(size / data.length, parent.startDate.toString()),
                                    dataRowItem(size / data.length, parent.motherPhone.toString()),
                                    dataRowItem(size / data.length, parent.emergencyPhone.toString()),
                                    dataRowItem(size / data.length, "عرض"),
                                    dataRowItem(size / data.length, "عرض", color: Colors.purpleAccent, onTap: () {
                                      showParentInputDialog(context, parent);
                                    }),
                                    dataRowItem(size / data.length, "حذف", color: Colors.red, onTap: () {
                                      controller.deleteParent(parent.id.toString());
                                    }),
                                  ]),
                              ]),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void showParentInputDialog(BuildContext context, dynamic parent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width,
            child: ParentInputForm(parent: parent),
          ),
        );
      },
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
                  textAlign: TextAlign.center,
                  style: color == null ? null : TextStyle(color: color),
                ))),
      ),
    );
  }
}
