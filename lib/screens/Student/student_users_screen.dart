import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Student/Student_view_Screen.dart';
import 'package:vision_dashboard/screens/Student/student_user_details.dart';
import '../../constants.dart';


class StudentUsersScreen extends StatefulWidget {
  StudentUsersScreen({super.key});

  @override
  State<StudentUsersScreen> createState() => _StudentUsersScreenState();
}

class _StudentUsersScreenState extends State<StudentUsersScreen> {
  bool isAdd=false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: AnimatedCrossFade(
        duration: Duration(milliseconds: 500),
        firstChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: StudentViewScreen(),
        ),
        secondChild: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: StudentInputForm(),
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




