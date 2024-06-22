import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';

import '../Widgets/header.dart';

class DeleteManagementView extends StatefulWidget {
  const DeleteManagementView({super.key});

  @override
  State<DeleteManagementView> createState() => _DeleteManagementViewState();
}

class _DeleteManagementViewState extends State<DeleteManagementView> {
  final ScrollController _scrollController = ScrollController();
  List data = ["الرمز التسلسلي", "التفاصيل", "الرمز التسلسلي المتأثر", "التصنيف المتأثر", "العمليات","الحذف"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'منصة الحذف',
      ),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(MediaQuery.sizeOf(context).width - (controller.isDrawerOpen ? 240 : 120), 1000) - 60;
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
                    "كل طلبات الحذف",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  GetBuilder<DeleteManagementViewModel>(builder: (controller) {
                    return SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                         child: DataTable(columnSpacing: 0, columns: List.generate(data.length, (index) => DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))), rows: [
                           for (var deleteModel in controller.allDelete.values)
                             DataRow(
                                 color: WidgetStatePropertyAll(checkIfPendingDelete(affectedId: deleteModel.id) ? Colors.red : Colors.transparent),
                                 cells: [
                                   dataRowItem(size / data.length, deleteModel.id.toString()),
                                   dataRowItem(size / data.length, deleteModel.details??"لا يوجد"),
                                   dataRowItem(size / data.length, deleteModel.affectedId.toString()),
                                   dataRowItem(size / data.length, deleteModel.collectionName.toString()),
                                   dataRowItem(size / data.length, "استرجاع",color: Colors.teal,onTap: (){
                                     controller.undoTheDelete(deleteModel);
                                   }),
                                   dataRowItem(size / data.length, "حذف نهائي",color: Colors.red.shade700,onTap: (){
                                     controller.doTheDelete(deleteModel);
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
