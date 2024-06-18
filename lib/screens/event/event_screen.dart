import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/controller/event_view_model.dart';
import 'package:vision_dashboard/models/event_model.dart';
import 'package:vision_dashboard/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/account_management_model.dart';
import '../../utils/const.dart';

class EventScreen extends StatefulWidget {
  EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}


class _EventScreenState extends State<EventScreen> {

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Get.find<HomeViewModel>();

    return Scaffold(
      body: GetBuilder<EventViewModel>(builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
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
                          "ادارة الاحداث",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                        ),
                    ],
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
                          "جميع الاحداث",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: GetBuilder<DeleteManagementViewModel>(builder: (_) {
                            return DataTable(
                              columnSpacing: defaultPadding,
                              // minWidth: 600,
                              columns: [
                                DataColumn(
                                  label: Text("الرمز التسلسلي"),
                                ),
                                DataColumn(
                                  label: Text("الاسم"),
                                ),
                                DataColumn(
                                  label: Text("المستهدف"),
                                ),
                                DataColumn(
                                  label: Text("اللون"),
                                ),
                                DataColumn(
                                  label: Text("العمليات"),
                                ),
                              ],
                              rows: List.generate(
                                controller.allEvents.keys.length,
                                    (index) => workingDriverDataRow(controller.allEvents.values.toList()[index]),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }

  DataRow workingDriverDataRow(EventModel event) {
    return DataRow(
      color: WidgetStatePropertyAll(checkIfPendingDelete(affectedId: event.id) ? Colors.red : Colors.transparent),
      cells: [
        DataCell(
          Text(event.id),
        ),
        DataCell(Text(event.name)),
        DataCell(Text(getEventTypeFromEnum(event.role))),
        DataCell(Container(height: 40, width: 40, decoration: BoxDecoration(color: Color(event.color), borderRadius: BorderRadius.circular(15)))),
        DataCell(Row(
          children: [
            if(!checkIfPendingDelete(affectedId: event.id))
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red.shade600),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                addDeleteOperation(collectionName: Const.eventCollection, affectedId: event.id);
              },
              child: Text("حذف الحدث"),
            ),
          ],
        )),
      ],
    );
  }
}
