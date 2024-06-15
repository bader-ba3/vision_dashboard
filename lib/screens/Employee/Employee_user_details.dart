import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeInputForm extends StatefulWidget {
  @override
  _EmployeeInputFormState createState() => _EmployeeInputFormState();
}

class _EmployeeInputFormState extends State<EmployeeInputForm> {
  final fullNameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  final nationalityController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final jobTitleController = TextEditingController();
  final salaryController = TextEditingController();
  final contractController = TextEditingController();
  final busController = TextEditingController();
  final startDateController = TextEditingController();
  final eventController = TextEditingController();
  final dateController = TextEditingController();

  List<Map<String, dynamic>> eventRecords = [];

  @override
  void dispose() {
    fullNameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    nationalityController.dispose();
    genderController.dispose();
    ageController.dispose();
    jobTitleController.dispose();
    salaryController.dispose();
    contractController.dispose();
    busController.dispose();
    startDateController.dispose();
    eventController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('نموذج إدخال الموظفين'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Wrap(
                clipBehavior: Clip.hardEdge,
                direction: Axis.horizontal,

                runSpacing: 50,
                spacing: 25,
                children: <Widget>[
                  CustomTextField(controller: fullNameController, title: "الاسم الكامل"),
                  CustomTextField(controller: mobileNumberController, title: 'رقم الموبايل', keyboardType: TextInputType.phone),
                  CustomTextField(controller: addressController, title: 'العنوان'),
                  CustomTextField(controller: nationalityController, title: 'الجنسية'),
                  CustomTextField(controller: genderController, title: 'الجنس'),
                  CustomTextField(controller: ageController, title: 'العمر', keyboardType: TextInputType.number),
                  CustomTextField(controller: jobTitleController, title: 'الوظيفة'),
                  CustomTextField(controller: salaryController, title: 'الراتب', keyboardType: TextInputType.number),
                  CustomTextField(controller: contractController, title: 'العقد'),
                  CustomTextField(controller: busController, title: 'الحافلة'),
                  CustomTextField(controller: startDateController, title: 'تاريخ البداية', keyboardType: TextInputType.datetime),
                  CustomTextField(controller: eventController, title: 'الحدث'),
                  CustomTextField(controller: dateController, title: 'التاريخ', keyboardType: TextInputType.datetime),
                  
                  Row(
                    children: [
                      ElevatedButton(

                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all(Colors.white),
                          backgroundColor: WidgetStateProperty.all(primaryColor)
                        ),
                        onPressed: () {
                          setState(() {
                            eventRecords.add({
                              'event': eventController.text,
                              'date': dateController.text,
                            });
                            eventController.clear();
                            dateController.clear();
                          });
                        },
                        child: Text('إضافة سجل حدث'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(

                        style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(Colors.white),
                            backgroundColor: WidgetStateProperty.all(primaryColor)
                        ),
                        onPressed: () {
                          final employee = EmployeeModel(
                            fullName: fullNameController.text,
                            mobileNumber: mobileNumberController.text,
                            address: addressController.text,
                            nationality: nationalityController.text,
                            gender: genderController.text,
                            age: ageController.text,
                            jobTitle: jobTitleController.text,
                            salary: salaryController.text,
                            contract: contractController.text,
                            bus: busController.text,
                            startDate: DateTime.parse(startDateController.text),
                            eventRecords: eventRecords.map((record) => EventRecordModel(
                              event: record['event'],
                              date: DateTime.parse(record['date']),
                            )).toList(),
                          );
                          print('بيانات الموظف: $employee');
                        },
                        child: Text('إرسال'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),

            SizedBox(height: defaultPadding*2,),
            Text('سجل الأحداث:', style: Styles.headLineStyle1),
            SizedBox(height: defaultPadding,),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: eventRecords.length,
                itemBuilder: (context, index) {
                  final record = eventRecords[index];
                  return ListTile(
                    title: Text(record['event'],style: Styles.headLineStyle1,),
                    subtitle: Text(record['date'],style: Styles.headLineStyle3,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,  this. keyboardType,this.enable
  });

  final TextEditingController controller;
  final String title;
  final TextInputType? keyboardType;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width/3.5,
      child:TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        enabled: enable,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(color: primaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          disabledBorder:UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor,width: 2),
            borderRadius: BorderRadius.circular(10),
          ),

        ),
      ),
    );
  }
}
