import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
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
  String? role;
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  int selectedColor = 4294198070;
  @override
  Widget build(BuildContext context) {
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
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: "اسم الحدث",
                          fillColor: secondaryColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Text("المستهدف"),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: DropdownButton(
                        value: role ??Const.eventTypeStudent,
                        isExpanded: true,
                        onChanged: (_) {
                          role = _;
                          setState(() {});
                        },
                        items: Const.allEventType.map((e) => DropdownMenuItem(value: e.toString(), child: Text(getEventTypeFromEnum(e)))).toList(),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: MaterialColorPicker(
                            colors: [Colors.red, Colors.pink, Colors.purple, Colors.deepPurple, Colors.indigo, Colors.blue, Colors.lightBlue, Colors.cyan, Colors.teal, Colors.green, Colors.lime, Colors.yellow, Colors.amber, Colors.orange, Colors.deepOrange, Colors.brown, Colors.blueGrey],
                            allowShades: false,
                            onMainColorChange: (ColorSwatch? color) {
                              selectedColor = color!.value;
                              setState(() {});
                            },
                            selectedColor: Color(selectedColor)),
                      ),
                      InkWell(
                        onTap: () {
                          role ??= Const.eventTypeStudent;
                          EventModel model = EventModel(name: name.text, id: DateTime.now().millisecondsSinceEpoch.toString(), role: role!, color: selectedColor);
                          name.clear();
                          pass.clear();
                          role = null;
                          controller.addEvent(model);
                          setState(() {});
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            "Add",
                            style: TextStyle(color: Color(0xff00308F), fontSize: 22),
                          )),
                        ),
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
                          "All User",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: DataTable(
                            columnSpacing: defaultPadding,
                            // minWidth: 600,
                            columns: [
                              DataColumn(
                                label: Text("المز التسلسلي"),
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
                          ),
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
      cells: [
        DataCell(
          Text(event.id),
        ),
        DataCell(Text(event.name)),
        DataCell(Text(getEventTypeFromEnum(event.role))),
        DataCell(Container(height: 40, width: 40, decoration: BoxDecoration(color: Color(event.color), borderRadius: BorderRadius.circular(15)))),
        DataCell(ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.red),
          ),
          onPressed: () {
            EventViewModel eventViewModel = Get.find<EventViewModel>();
            eventViewModel.deleteEvent(event);
          },
          child: Text("حذف الحدث"),
        )),
      ],
    );
  }
}
