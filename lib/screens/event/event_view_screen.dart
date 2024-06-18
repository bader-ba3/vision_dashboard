import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Student/Student_view_Screen.dart';
import 'package:vision_dashboard/screens/Student/student_user_details.dart';
import 'package:vision_dashboard/screens/event/event_screen.dart';
import 'package:vision_dashboard/screens/expenses/expenses_input_form.dart';
import 'package:vision_dashboard/screens/expenses/expenses_users_screen.dart';
import '../../constants.dart';
import 'event_input_form.dart';


class EventViewScreen extends StatefulWidget {
  EventViewScreen({super.key});

  @override
  State<EventViewScreen> createState() => _EventViewScreenState();
}

class _EventViewScreenState extends State<EventViewScreen> {
  bool isAdd=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: EventScreen(),
        ),
        secondChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: EventInputForm(),
        ),
        crossFadeState: isAdd ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:primaryColor,
        onPressed: () {
          setState(() {
            isAdd = !isAdd;
          });
        },
        child: Icon(!isAdd? Icons.add:Icons.grid_view),
      ),
    );
  }
}




