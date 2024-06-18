import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Employee/Employee_user_details.dart';
import 'package:vision_dashboard/screens/Employee/Employee_users_screen.dart';
import 'package:vision_dashboard/screens/Student/Student_view_Screen.dart';
import 'package:vision_dashboard/screens/Student/student_user_details.dart';
import '../../constants.dart';


class EmployeeView extends StatefulWidget {
  EmployeeView({super.key});

  @override
  State<EmployeeView> createState() => _EmployeeViewState();
}

class _EmployeeViewState extends State<EmployeeView> {
  bool isAdd=false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: EmployeeUsersScreen(),
        ),
        secondChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: EmployeeInputForm(),
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




