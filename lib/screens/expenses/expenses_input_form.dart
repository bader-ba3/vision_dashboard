import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/expenses_model.dart';
import 'package:vision_dashboard/screens/Buses/Controller/Bus_View_Model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';
import 'package:vision_dashboard/utils/Dialogs.dart';

import '../../constants.dart';
import '../../controller/account_management_view_model.dart';
import '../Widgets/Custom_Text_Filed.dart';

class ExpensesInputForm extends StatefulWidget {
  const ExpensesInputForm({super.key, this.busId,this.expensesModel});

  @override
  _ExpensesInputFormState createState() => _ExpensesInputFormState();

  final String? busId;
  final ExpensesModel? expensesModel;
}

class _ExpensesInputFormState extends State<ExpensesInputForm> {
  final titleController = TextEditingController();
  final totalController = TextEditingController();
  final bodyController = TextEditingController();
  List imageLinkList = [];
  List<String> ImagesTempData = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpensesViewModel>(builder: (controller) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Wrap(
          clipBehavior: Clip.hardEdge,
          direction: Axis.horizontal,
          runSpacing: 25,
          spacing: 25,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(controller: titleController, title: 'العنوان'.tr),
            CustomTextField(controller: totalController, title: 'القيمة'.tr),
            multiLineCustomTextField(
                controller: bodyController, title: 'تاريخ البداية'.tr),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("صورة الفاتورة".tr),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () async {
                          FilePickerResult? _ = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.image, allowMultiple: true);
                          if (_ != null) {
                            _.xFiles.forEach(
                              (element) async {
                                ImagesTempData.add(await element.path);
                              },
                            );
                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(15)),
                            height: 200,
                            width: 200,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                      ...List.generate(
                        widget.expensesModel == null?  ImagesTempData.length:imageLinkList.length,
                        (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                                width: 200,
                                height: 200,
                                child:  widget.expensesModel == null?  Image.file(
                                  File(ImagesTempData[index]),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.fitHeight,
                                ): Image.file(
                                  File(ImagesTempData[index]),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.fitHeight,
                                )),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            AppButton(
              text: "حفظ".tr,
              onPressed: () async {

                QuickAlert.show(
                    width: Get.width / 2,
                    context: context,
                    type: QuickAlertType.loading,
                    title: 'جاري التحميل'.tr,
                    text: 'يتم العمل على الطلب'.tr,
                    barrierDismissible: false);
             if( widget.expensesModel == null)
                uploadImages(ImagesTempData, "expenses").then((value) =>imageLinkList=value ,);
                String expId = generateId("ExP");

                BusViewModel busController = Get.find<BusViewModel>();
                ExpensesModel model = ExpensesModel(
                  id: expId,
                  busId: widget.busId,
                  title: titleController.text,
                  body: widget.busId != null
                      ? "مصروف الحافلة ${busController.busesMap[widget.busId]!.name}\n ${bodyController.text}"
                      : bodyController.text,
                  total: int.parse(totalController.text),
                  userId: getMyUserId(),
                  images: imageLinkList,
                );
                if (widget.busId != null)
                  await busController.addExpenses(widget.busId!, expId);
                controller.addExpenses(model);
                bodyController.clear();
                titleController.clear();
                totalController.clear();
                ImagesTempData.clear();
                setState(() {});
                if (widget.busId != null)
                  Get.back();
                  Get.back();
              },
            )
          ],
        ),
      );
    });
  }
}

class multiLineCustomTextField extends StatelessWidget {
  const multiLineCustomTextField({
    super.key,
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width / 1,
      height: 200,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white12,
            border: Border.all(color: primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الوصف'.tr, style: TextStyle(color: primaryColor)),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                controller: controller,
                maxLines: null,
                decoration: InputDecoration(
                    //labelText: title,
                    labelStyle: TextStyle(color: primaryColor),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
