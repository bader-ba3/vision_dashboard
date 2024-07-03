import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/models/account_management_model.dart';
import 'package:vision_dashboard/screens/Buses/Controller/Bus_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import '../../constants.dart';
import '../../models/Bus_Model.dart';
import '../../models/Student_Model.dart';
import '../../models/event_record_model.dart';
import '../Widgets/Custom_Text_Filed.dart';

class BusInputForm extends StatefulWidget {

  BusInputForm({this.busModel,});
  @override
  _BusInputFormState createState() => _BusInputFormState();

  late final BusModel? busModel;
}

class _BusInputFormState extends State<BusInputForm> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final typeController = TextEditingController();

  final startDateController = TextEditingController();

  List<String> selectedEmployee = [];
  List<EventRecordModel> eventRecords = [];
  List<String> selectedStudent = [];

   Map<String, StudentModel> allSection =
      Get.find<StudentViewModel>().studentMap;
   Map<String, AccountManagementModel> allEmployee =
      Get.find<AccountManagementViewModel>().allAccountManagement;

   initBus(){
     if(widget.busModel!=null)
       {
         nameController.text=widget.busModel!.name.toString();
         numberController.text=widget.busModel!.number.toString();
         typeController.text=widget.busModel!.type.toString();
         startDateController.text=widget.busModel!.startDate.toString().split(" ")[0];

         allEmployee.forEach((key, value) {
         if(widget.busModel!.employees!.contains(key))
           {
             value.available=true;
             selectedEmployee.add(key);
           }
         },);
         allSection.forEach((key, value) {
           if(widget.busModel!.students!.contains(key))
           {
             value.available=true;
             selectedStudent.add(key);
           }
         },);
       }
   }
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBus();
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    typeController.dispose();
    startDateController.dispose();
    super.dispose();
  }
  clearControl(){
    nameController.clear();
    numberController.clear();
    typeController.clear();
    startDateController.clear();
    allSection.values.forEach((element) {
      element.available=false;
    },);
    allEmployee.values.forEach((element) {
      element.available=false;
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(25.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Wrap(
                  clipBehavior: Clip.hardEdge,
                  direction: Axis.horizontal,
                  runSpacing: 50,
                  spacing: 25,
                  children: [
                    CustomTextField(
                        controller: nameController, title: 'اسم الحافلة'.tr),
                    CustomTextField(
                        controller: numberController, title: 'رقم الحافلة'.tr),
                    CustomTextField(
                        controller: typeController, title: 'نوع الحافلة'.tr),


                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: startDateController,
                          title: 'تاريخ البداية'.tr,
                          enable: false,
                          keyboardType: TextInputType.datetime,
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              if (date != null) {
                                startDateController.text = date.toString().split(" ")[0];
                              }
                            });
                          },
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    GetBuilder<BusViewModel>(
                      builder: (busController) {
                        return AppButton(
                          text: 'حفظ'.tr,
                          onPressed: ()async {
                            QuickAlert.show(
                                width: Get.width / 2,
                                context: context,
                                type: QuickAlertType.loading,
                                title: 'جاري التحميل'.tr,
                                text: 'يتم العمل على الطلب'.tr,
                                barrierDismissible: false);
                            BusModel bus = BusModel(
                              name: nameController.text,
                              busId:widget.busModel==null? generateId("BUS"):widget.busModel!.busId!,
                              number: numberController.text,
                              type: typeController.text,
                              employees: selectedEmployee,
                              students: selectedStudent,
                              startDate: DateTime.parse(startDateController.text),

                            );
                         await   busController.addBus(bus);
                            clearControl();
                            setState(() {
                            });
                            if(widget.busModel!=null)
                                Get.back();
                                Get.back();

                          },
                        );
                      }
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: defaultPadding,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: Get.width,
                  child: DataTable(
                    clipBehavior: Clip.hardEdge,
                    columns: [
                      DataColumn(label: Text("اسم الطالب".tr)),
                      DataColumn(label: Text("رقم الطالب".tr)),
                      DataColumn(label: Text("تاريخ البداية".tr)),
                      DataColumn(label: Text("ولي الأمر".tr)),
                      DataColumn(label: Text("موجود".tr)),
                    ],
                    rows: allSection.values
                        .map(
                          (e) => studentDataRow(e),
                        )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: Get.width,
                  child: DataTable(
                    clipBehavior: Clip.hardEdge,
                    columns: [
                      DataColumn(label: Text("اسم الموظف".tr)),
                      DataColumn(label: Text("العنوان".tr)),
                      DataColumn(label: Text("تاريخ البداية".tr)),
                      DataColumn(label: Text("الجنس".tr)),
                      DataColumn(label: Text("موجود".tr)),
                    ],
                    rows: allEmployee.values
                        .map(
                          (e) => employeeDataRow(e),
                        )
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

            ])));
  }

  DataRow studentDataRow(StudentModel student) {
    return DataRow(
      cells: [
        DataCell(Text(student.studentName.toString())),
        DataCell(Text(student.studentNumber.toString())),
        DataCell(Text(student.startDate.toString())),
        DataCell(Text(student.parentId.toString())),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            print(v);
            student.available = v ?? false;
            selectedStudent.contains(student.studentID) ?selectedStudent.remove(student.studentID):selectedStudent.add(student.studentID.toString());

            setState(() {});
          },
          value: student.available,
        )),
      ],
    );
  }

  DataRow employeeDataRow(AccountManagementModel employee) {
    return DataRow(
      cells: [
        DataCell(Text(employee.userName.toString())),
        DataCell(Text(employee.address.toString())),
        DataCell(Text(employee.startDate.toString())),
        DataCell(Text(employee.gender.toString())),
        DataCell(Checkbox(
          fillColor: WidgetStateProperty.all(primaryColor),
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (v) {
            print(v);
            employee.available = v ?? false;
            selectedEmployee.contains(employee.id) ?selectedEmployee.remove(employee.id):selectedEmployee.add(employee.id.toString());
            setState(() {});
          },
          value: employee.available,
        )),
      ],
    );
  }
}
