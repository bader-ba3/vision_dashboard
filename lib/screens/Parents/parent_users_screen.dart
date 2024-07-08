import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/Parents/parent_user_details.dart';
import '../../constants.dart';
import '../Widgets/Data_Row.dart';
import '../Widgets/header.dart';
import 'Controller/Parents_View_Model.dart';

class ParentUsersScreen extends StatefulWidget {
  const ParentUsersScreen({super.key});

  @override
  State<ParentUsersScreen> createState() => _ParentUsersScreenState();
}

class _ParentUsersScreenState extends State<ParentUsersScreen> {
  final ScrollController _scrollController = ScrollController();
  List data = [
    "الاسم الكامل",
    "العنوان",
    "الجنسية",
    "العمر",
    "العمل",
    "تاريخ البداية",
    "رقم الام",
    "رقم الطوارئ",
    "سجل الأحداث",
    "الخيارات",
    ""
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
          context: context,
        title: 'اولياء الامور'.tr,middleText: 'تقوم هذه الواجه بعرض معلومات تفصيلية عن الاباء ويمكن من خلالها اضافة اب جديد او تعديل اب موجود سابقا او حذفه'.tr
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<ParentsViewModel>(builder: (controller) {
                    return SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child:
                            GetBuilder<DeleteManagementViewModel>(builder: (_) {
                          return SingleChildScrollView(
                            controller: _scrollController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                dividerThickness: 0.3,
                                columnSpacing: 0,
                                columns: List.generate(
                                    data.length,
                                    (index) => DataColumn(
                                        label: Container(
                                            width: size / data.length,
                                            child: Center(
                                                child: Text(data[index].toString().tr))))),
                                rows: [
                                  for (var parent
                                      in controller.parentMap.values.toList())
                                    DataRow(
                                        color: WidgetStatePropertyAll(
                                          checkIfPendingDelete(
                                                  affectedId:
                                                      parent.id.toString())
                                              ? Colors.redAccent.withOpacity(0.2).withOpacity(0.2)
                                              : Colors.transparent,
                                        ),
                                        cells: [
                                          dataRowItem(size / data.length,
                                              parent.fullName.toString()),
                                          dataRowItem(size / data.length,
                                              parent.address.toString()),
                                          dataRowItem(size / data.length,
                                              parent.nationality.toString()),
                                          dataRowItem(size / data.length,
                                              parent.age.toString()),
                                          dataRowItem(size / data.length,
                                              parent.work.toString()),
                                          dataRowItem(size / data.length,
                                              parent.startDate.toString()),
                                          dataRowItem(size / data.length,
                                              parent.motherPhone.toString()),
                                          dataRowItem(size / data.length,
                                              parent.emergencyPhone.toString()),
                                          dataRowItem(
                                              size / data.length, parent.eventRecords?.length==0?"لايوجد":"عرض  (${parent.eventRecords?.length})  حدث".toString(),onTap: (){
                                            if(parent.eventRecords!.length>0)
                                           showEventDialog(context, parent.eventRecords!);
                                          }),

                                          dataRowItem(size / data.length, "تعديل".tr,
                                              color: Colors.teal, onTap: () {
                                                if (enableUpdate == true)
                                            showParentInputDialog(
                                                context, parent);
                                          }),
                                          dataRowItem(size / data.length,  checkIfPendingDelete(
                                              affectedId:
                                              parent.id.toString())?'استرجاع'.tr:"حذف".tr,
                                              color: checkIfPendingDelete(
                                                  affectedId:
                                                  parent.id.toString())?Colors.white: Colors.red, onTap: () {
                                            if (enableUpdate == true) {
                                              if (checkIfPendingDelete(
                                                  affectedId:
                                                      parent.id.toString()))
                                                _.returnDeleteOperation(
                                                    affectedId: parent.id!);
                                              else
                                                controller.deleteParent(
                                                    parent.id.toString(),parent.children??[]);
                                            }
                                          }),
                                        ]),
                                ]),
                          );
                        }),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void showParentInputDialog(BuildContext context, dynamic parent) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width/1.5,
            child: ParentInputForm(parent: parent),
          ),
        );
      },
    );
  }

  void showEventDialog(BuildContext context, dynamic eventRecords) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(25.0),
          ),
          child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            height: Get.height / 2,
            width: Get.width/2,
            child: Column(
              children: [
                Text('سجل الأحداث', style: Styles.headLineStyle1),
                SizedBox(height: defaultPadding),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: eventRecords.length,
                  itemBuilder: (context, index) {
                    final record = eventRecords[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(int.parse(record.color)).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Text("نوع الحدث: ",style: Styles.headLineStyle2,),
                              Text(
                                record.type,
                                style: Styles.headLineStyle1.copyWith(color: Colors.black),
                              ),
                              SizedBox(width: 10),
                              Text("تفاصيل الحدث: ",style: Styles.headLineStyle2,),
                              Text(
                                record.body,
                                style: Styles.headLineStyle1.copyWith(color: Colors.black),
                              ),
                              Spacer(),
                              Text("تاريخ الحدث: ",style: Styles.headLineStyle4,),

                              Text(
                                record.date,
                                style: Styles.headLineStyle3,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
