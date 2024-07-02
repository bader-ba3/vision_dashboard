import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Store/Controller/Store_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Text_Filed.dart';
import '../../constants.dart';
import '../../models/Store_Model.dart';
import '../Widgets/header.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = ["اسم المادة", "الكمية", "الخيارات", ""];
  final TextEditingController subNameController = TextEditingController();
  final TextEditingController subQuantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'المستودع'.tr,middleText: 'تستخدم هذه الواجهة لعرض تفاصيل المواد داخل المستودع'.tr
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<StoreViewModel>(builder: (controller) {
                    return SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: GetBuilder<DeleteManagementViewModel>(
                            builder: (_) {
                              return DataTable(
                                  columnSpacing: 0,
                                  dividerThickness: 0.3,
                                  columns: List.generate(
                                      data.length,
                                      (index) => DataColumn(
                                          label: Container(
                                              width: size / (data.length),
                                              child: Center(
                                                  child: Text(data[index].toString().tr))))),

                                  rows: [
                                    for (var storeModel
                                        in controller.storeMap.values.toList())
                                      DataRow(
                                          color: WidgetStatePropertyAll(checkIfPendingDelete(affectedId: storeModel.id!)?Colors.red:Colors.transparent),
                                          cells: [
                                        dataRowItem(size / (data.length),
                                            storeModel.subQuantity.toString()),
                                        dataRowItem(size / (data.length),
                                            storeModel.subName.toString()),
                                        dataRowItem(size / (data.length), "تعديل".tr,
                                            color: Colors.teal, onTap: () {
                                          buildEditDialog(context, storeModel);
                                        }),
                                        DataCell(
                                            Container(
                                            width: size / (data.length),
                                            child: IconButton(
                                                onPressed: () {
                                                  checkIfPendingDelete(affectedId: storeModel.id!)?
                                                      returnPendingDelete(affectedId:  storeModel.id!):
                                                      addDeleteOperation(collectionName: storeCollection, affectedId:  storeModel.id!);
                                                },
                                                icon: Row(
                                                  children: [
                                                    Spacer(),
                                                    Icon(
                                                      checkIfPendingDelete(affectedId: storeModel.id!)?Icons.check:  Icons.delete,
                                                      color: checkIfPendingDelete(affectedId: storeModel.id!)? Colors.green:Colors.red,
                                                    ),
                                                 SizedBox(width: 5,),
                                                    Text(checkIfPendingDelete(affectedId: storeModel.id!)?"استرجاع".tr:"حذف".tr),
                                                    Spacer(),
                                                  ],
                                                ))))
                                      ]),
                                  ]);
                            }
                          ),
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

  Future<dynamic> buildEditDialog(BuildContext context, StoreModel storeModel) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: secondaryColor,
        title: Text("تعديل المادة"),
        actions: [
          CustomTextField(
              controller: subQuantityController
                ..text = storeModel.subQuantity.toString(),
              title: data[0]),
          CustomTextField(
              controller: subNameController
                ..text = storeModel.subName.toString(),
              title: data[1]),
          AppButton(
            text: 'حفظ',
            onPressed: () {
              StoreModel store = StoreModel(
                subName: subNameController.text,
                subQuantity: subQuantityController.text,
                id: storeModel.id,
              );

              Get.find<StoreViewModel>().updateStore(store);
              print('store Model: $store');
              Get.back();
            },
          )
        ],
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
