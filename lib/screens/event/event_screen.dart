import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/event_view_model.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';

import '../../utils/const.dart';
import '../Widgets/header.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = ["الرمز التسلسلي", "الاسم", "المستهدف", "اللون", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          context: context,
        title: 'الأحداث'.tr,middleText: "تعرض الواجهة انماط الاحداث التي يمكن ان تطبق لكل فئة من المشتركين داخل المنصة بالاضافة الى امكانية عمل نمط حدث جديد".tr
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
              child: GetBuilder<EventViewModel>(builder: (controller) {
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
                                        width: size / data.length,
                                        child: Center(
                                            child: Text(data[index].toString().tr))))),
                            rows: [
                              for (var event in controller.allEvents.values)
                                DataRow(
                                    color: WidgetStatePropertyAll(
                                        checkIfPendingDelete(
                                                affectedId: event.id)
                                            ? Colors.red
                                            : Colors.transparent),
                                    cells: [
                                      dataRowItem(size / data.length,
                                          event.id.toString()),
                                      dataRowItem(size / data.length,
                                          event.name.toString()),
                                      dataRowItem(size / data.length,
                                          getEventTypeFromEnum(event.role)),
                                      DataCell(
                                        Container(
                                          width: size / data.length,
                                          child: Center(
                                              child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color: Color(
                                                          event.color),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  15)))),
                                        ),
                                      ),
                                      dataRowItem(
                                          size / data.length,
                                          checkIfPendingDelete(
                                                  affectedId: event.id)
                                              ? "استرجاع".tr
                                              : "حذف".tr,
                                          color: checkIfPendingDelete(
                                                  affectedId: event.id)
                                              ? Colors.white
                                              : Colors.red,
                                          onTap:  () {
                                                  if (enableUpdate) {
                                                    if (checkIfPendingDelete(
                                                        affectedId:
                                                            event.id))
                                                      returnPendingDelete(
                                                          affectedId:
                                                              event.id);
                                                    else
                                                      addDeleteOperation(
                                                          collectionName: Const
                                                              .eventCollection,
                                                          affectedId:
                                                              event.id);
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
              textAlign: TextAlign.center,
              style: color == null ? null : TextStyle(color: color),
            ))),
      ),
    );
  }
}
