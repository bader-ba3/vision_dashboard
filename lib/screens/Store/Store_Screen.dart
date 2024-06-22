import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Parents/parent_user_details.dart';
import 'package:vision_dashboard/screens/Store/Controller/Store_View_Model.dart';
import '../../constants.dart';
import '../Widgets/header.dart';


class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = ["الكمية","اسم المادة"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'المستودع',),
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

                  GetBuilder<StoreViewModel>(builder: (controller) {
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
                                for (var parent in controller.storeMap.values.toList())
                                  DataRow(cells: [
                                    dataRowItem(size / data.length, parent.subName.toString()),
                                    dataRowItem(size / data.length, parent.subQuantity.toString()),

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
