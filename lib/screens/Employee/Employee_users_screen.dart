import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/models/Employee_Model.dart';
import '../../constants.dart';
import '../Widgets/header.dart';

class EmployeeUsersScreen extends StatefulWidget {
  const EmployeeUsersScreen({super.key});

  @override
  State<EmployeeUsersScreen> createState() => _EmployeeUsersScreenState();
}

class _EmployeeUsersScreenState extends State<EmployeeUsersScreen> {
  final ScrollController _scrollController = ScrollController();
  List data =    ["الاسم الكامل","رقم الموبايل","العنوان","الجنسية","الجنس","العمر","الوظيفة","الراتب","العقد","الصفوف","تاريخ البداية","سجل الاحداث","خيارات"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   Header(title:  'الموظفون',),
      body: SingleChildScrollView(
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(MediaQuery.sizeOf(context).width - (controller.isDrawerOpen?240:120), 1000)-60;
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

                  SizedBox(
                    width: size+60,
                    child: Scrollbar(
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: DataTable( columns:
                        List.generate(data.length,(index)=> DataColumn(label: Container(width: size / data.length, child: Center(child: Text(data[index]))))),
                            rows: [
                              for (var employees in generateRandomEmployees(20))
                                DataRow(cells: [
                                  dataRowItem(size / data.length, employees.fullName.toString()),
                                  dataRowItem(size / data.length, employees.mobileNumber.toString()),
                                  dataRowItem(size / data.length, employees.address.toString()),
                                  dataRowItem(size / data.length, employees.nationality.toString()),
                                  dataRowItem(size / data.length, employees.gender.toString()),
                                  dataRowItem(size / data.length, employees.age.toString()),
                                  dataRowItem(size / data.length, employees.jobTitle.toString()),
                                  dataRowItem(size / data.length, employees.salary.toString()),
                                  dataRowItem(size / data.length, employees.contract.toString()),
                                  dataRowItem(size / data.length, employees.bus.toString()),
                                  dataRowItem(size / data.length, employees.startDate.toString().split(" ")[0]),
                                  dataRowItem(size / data.length, "عرض",color: Colors.teal,onTap: (){}),
                                  dataRowItem(size / data.length, "حذف",color: Colors.red,onTap: (){
                                  }),
                                ]),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  dataRowItem(size, text, {onTap, color}) {
    return DataCell(
      Container(
        width: size ,
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
