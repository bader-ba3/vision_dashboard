import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/models/delete_management_model.dart';

class DeleteManagementView extends StatefulWidget {
  const DeleteManagementView({super.key});

  @override
  State<DeleteManagementView> createState() => _DeleteManagementViewState();
}

class _DeleteManagementViewState extends State<DeleteManagementView> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeleteManagementViewModel>(builder: (controller) {
      return DataTable(
        clipBehavior: Clip.hardEdge,
        columns: [
          DataColumn(label: Text("الرمز التسلسلي")),
          DataColumn(label: Text("التفاصيل")),
          DataColumn(label: Text("الرمز التسلسلي المتأثر")),
          DataColumn(label: Text("التصنيف المتأثر")),
          DataColumn(label: Text("العمليات")),
        ],
        rows: controller.allDelete.values.toList().map((deleteModel) => deleteModelDataRow(deleteModel)).toList(),
      );
    });
  }

  DataRow deleteModelDataRow(DeleteManagementModel deleteModel) {
    DeleteManagementViewModel deleteManagementViewModel = Get.find<DeleteManagementViewModel>();
    return DataRow(
      cells: [
        DataCell(Text(deleteModel.id.toString())),
        DataCell(Text(deleteModel.details??"لا يوجد")),
        DataCell(Text(deleteModel.affectedId.toString())),
        DataCell(Text(deleteModel.collectionName.toString())),
        DataCell(Row(
          children: [
            ElevatedButton(onPressed: (){
              deleteManagementViewModel.doTheDelete(deleteModel);
            }, child: Text("الموافقة"))
          ],
        )),
      ],
    );
  }
}
