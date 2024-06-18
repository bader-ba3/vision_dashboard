import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:vision_dashboard/controller/event_view_model.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/expenses_model.dart';

import '../../constants.dart';
import '../../controller/account_management_view_model.dart';
import '../../controller/home_controller.dart';
import '../../models/Employee_Model.dart';
import '../../models/Parent_Model.dart';
import '../../models/event_model.dart';
import '../../models/event_record_model.dart';
import '../../utils/const.dart';
import '../Employee/Employee_user_details.dart';
import '../Widgets/Custom_Text_Filed.dart';

class EventInputForm extends StatefulWidget {
  @override
  _EventInputFormState createState() => _EventInputFormState();
}

class _EventInputFormState extends State<EventInputForm> {
  String? role;
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  int selectedColor = 4294198070;

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("إضافة حدث ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 500,
                    height: 50,
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
                  width: 50,
                ),
                Text("المستهدف"),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: 100,
                    height: 50,
                    child: DropdownButton(
                  value: role ?? Const.eventTypeStudent,
                  isExpanded: true,
                  onChanged: (_) {
                    role = _;
                    setState(() {});
                  },
                  items: Const.allEventType.map((e) => DropdownMenuItem(value: e.toString(), child: Text(getEventTypeFromEnum(e)))).toList(),
                )),
              ],
            ),
            SizedBox(height: 50,),
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
            SizedBox(height: 50,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.blue.shade600),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () {
                role ??= Const.eventTypeStudent;
                EventModel model = EventModel(name: name.text, id: DateTime.now().millisecondsSinceEpoch.toString(), role: role!, color: selectedColor);
                name.clear();
                pass.clear();
                role = null;
                EventViewModel eventViewModel = Get.find<EventViewModel>();
                eventViewModel.addEvent(model);
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "إضافة",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
