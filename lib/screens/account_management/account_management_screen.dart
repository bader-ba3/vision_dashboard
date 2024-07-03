import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/screens/Widgets/Custom_Drop_down.dart';
import 'package:vision_dashboard/screens/account_management/Controller/Min_View_Model.dart';

import '../../constants.dart';
import '../../controller/delete_management_view_model.dart';
import '../../controller/home_controller.dart';

import '../Widgets/header.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollDeleteController = ScrollController();
  List userData = [
    "User Name",
    "الاسم الكامل",
    "كامة السر",
    "الدور",
    "الحالة",
    "رقم الموبايل",
    "العنوان",
    "الجنسية",
    "الجنس",
    "العمر",
    "الوظيفة",
    "العقد",
    "الصفوف",
    "تاريخ البداية",
    "سجل الاحداث",
    "العمليات"
  ];
  List deleteData = [
    "الرمز التسلسلي",
    "التفاصيل",
    "الرمز التسلسلي المتأثر",
    "التصنيف المتأثر",
    "العمليات",
    ""
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        context: context,
          title: 'ادارة المنصة'.tr,
          middleText:
              "تقوم هذه الواجهة بعرض الامور الاساسية في المنصة وهي المستخدمين وامكانية اضافة او تعديل او حذف كما تعرض السجلات الممطلوب حذفها للموافقة عليها او استرجاعها كما يمكن ارشفة بيانات السنة الحالية او حذف البيانات او العودة الى نسخة سابقة"
                  .tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: GetBuilder<HomeViewModel>(builder: (controller) {
          double size = max(
                  MediaQuery.sizeOf(context).width -
                      (controller.isDrawerOpen ? 240 : 120),
                  1000) -
              60;
          return Padding(
            padding: const EdgeInsets.all(15),
            child:
                GetBuilder<AccountManagementViewModel>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "سجلات الموظفين".tr,
                    style: Styles.headLineStyle1,
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SizedBox(
                      width: size + 60,
                      child: Scrollbar(
                        controller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: GetBuilder<DeleteManagementViewModel>(
                              builder: (_) {
                            return DataTable(
                                columnSpacing: 10,
                                dividerThickness: 0.3,
                                columns: List.generate(
                                    userData.length,
                                    (index) => DataColumn(
                                        label: Container(
                                            width: size / userData.length + 10,
                                            child: Center(
                                                child: Text(userData[index]
                                                    .toString()
                                                    .tr))))),
                                rows: [
                                  for (var accountModel
                                      in controller.allAccountManagement.values)
                                    DataRow(cells: [
                                      dataRowItem(size / userData.length,
                                          accountModel.userName.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.fullName.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.password.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.type.toString()),
                                      dataRowItem(
                                        size / userData.length,
                                        accountModel.isActive
                                            ? "فعال".tr
                                            : "ملغى".tr,
                                      ),
                                      dataRowItem(size / userData.length,
                                          accountModel.mobileNumber.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.address.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.nationality.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.gender.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.age.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.jobTitle.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.contract.toString()),
                                      dataRowItem(size / userData.length,
                                          accountModel.bus.toString()),
                                      dataRowItem(
                                          size / userData.length,
                                          accountModel.startDate
                                              .toString()
                                              .split(" ")[0]),
                                      dataRowItem(
                                          size / userData.length, "عرض".tr,
                                          color: Colors.teal, onTap: () {}),
                                      dataRowItem(
                                          size / userData.length, "حذف".tr,
                                          color: Colors.red, onTap: () {
                                        if (enableUpdate)
                                          controller
                                              .deleteAccount(accountModel);
                                      }),
                                    ]),
                                ]);
                          }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    "سجلات الحذف".tr,
                    style: Styles.headLineStyle1,
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: GetBuilder<DeleteManagementViewModel>(
                        builder: (controller) {
                      return SizedBox(
                        width: size + 60,
                        child: Scrollbar(
                          controller: _scrollDeleteController,
                          child: SingleChildScrollView(
                            controller: _scrollDeleteController,
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columnSpacing: 0,
                                dividerThickness: 0.3,
                                columns: List.generate(
                                    deleteData.length,
                                    (index) => DataColumn(
                                        label: Container(
                                            width: size / deleteData.length,
                                            child: Center(
                                                child: Text(deleteData[index]
                                                    .toString()
                                                    .tr))))),
                                rows: [
                                  for (var deleteModel
                                      in controller.allDelete.values)
                                    DataRow(
                                        color: WidgetStatePropertyAll(
                                            checkIfPendingDelete(
                                                    affectedId: deleteModel.id)
                                                ? Colors.red
                                                : Colors.transparent),
                                        cells: [
                                          dataRowItem(size / deleteData.length,
                                              deleteModel.id.toString()),
                                          dataRowItem(
                                              size / deleteData.length,
                                              deleteModel.details ??
                                                  "لا يوجد".tr),
                                          dataRowItem(
                                              size / deleteData.length,
                                              deleteModel.affectedId
                                                  .toString()),
                                          dataRowItem(
                                              size / deleteData.length,
                                              deleteModel.collectionName
                                                  .toString()),
                                          dataRowItem(size / deleteData.length,
                                              "استرجاع".tr, color: Colors.teal,
                                              onTap: () {
                                            if (enableUpdate)
                                              controller
                                                  .undoTheDelete(deleteModel);
                                          }),
                                          dataRowItem(size / deleteData.length,
                                              "حذف نهائي".tr,
                                              color: Colors.red.shade700,
                                              onTap: () {


                                            if (enableUpdate)

                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                text: 'حذف هذا العنصر بشكل نهائي'.tr,
                                                title: 'هل انت متأكد ؟'.tr,
                                                onConfirmBtnTap: () =>
                                                {
                                                        controller.doTheDelete(
                                                            deleteModel),Get.back()
                                                      },
                                                onCancelBtnTap: () => Get.back(),
                                                confirmBtnText: 'نعم'.tr,
                                                cancelBtnText: 'لا'.tr,
                                                confirmBtnColor: Colors.redAccent,
                                                showCancelBtn: true
                                              );

                                          }),
                                        ]),
                                ]),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Text(
                    "الارشفة وحذف البيانات".tr,
                    style: Styles.headLineStyle1,
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: GetBuilder<MinViewModel>(builder: (controller) {
                      return Column(
                        children: [
                          Wrap(
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 50,
                            children: [
                              CustomDropDown(
                                value: 'الافتراضي'.tr,
                                listValue: controller.allArchive
                                    .map(
                                      (e) => e.toString().tr,
                                    )
                                    .toList(),
                                label: "السنة المختارة".tr,
                                onChange: (value) {
                                  if (value != null) {
                                    if (value != "الافتراضي".tr) {
                                      controller.getOldData(value);
                                      enableUpdate = false;
                                      controller.update();
                                    } else {
                                      controller.getDefaultData();
                                      enableUpdate = true;
                                      controller.update();
                                    }
                                  }
                                },
                              ),
                              CustomDropDown(
                                value: '',
                                listValue: ['عربي', 'English'],
                                label: 'اختر اللغة'.tr,
                                onChange: (value) {
                                  Get.find<MinViewModel>().changeLanguage(value!);

                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: defaultPadding * 2,
                          ),
                          Wrap(
                            runSpacing: 20,
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 50,
                            children: [
                              AppButton(
                                  text: "ارشفة البيانات الحالية".tr,
                                  onPressed: ()async {
                                    QuickAlert.show(
                                        width: Get.width / 2,
                                        context: context,
                                        type: QuickAlertType.loading,
                                        title: 'جاري التحميل'.tr,
                                        text: 'يتم العمل على الطلب'.tr,
                                        barrierDismissible: false);
                                  await  controller.archive();
                                  Get.back();
                                  }),
                              AppButton(
                                  text: "تصفير البيانات الحالية".tr,
                                  onPressed: ()async {
                                    QuickAlert.show(
                                        width: Get.width / 2,
                                        context: context,
                                        type: QuickAlertType.loading,
                                        title: 'جاري التحميل'.tr,
                                        text: 'يتم العمل على الطلب'.tr,
                                        barrierDismissible: false);
                                    await  controller.archive();
                                    Get.back();
                                  }),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),

                ],
              );
            }),
          );
        }),
      ),
    );
  }

  dataRowItem(size, text, {onTap, color}) {
    return DataCell(
      Container(
        width: size,
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
