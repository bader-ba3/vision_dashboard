import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/expenses_model.dart';
import 'package:vision_dashboard/screens/Widgets/AppButton.dart';

import '../../constants.dart';
import '../../controller/account_management_view_model.dart';
import '../Widgets/Custom_Text_Filed.dart';

class ExpensesInputForm extends StatefulWidget {
  @override
  _ExpensesInputFormState createState() => _ExpensesInputFormState();
}

class _ExpensesInputFormState extends State<ExpensesInputForm> {
  final titleController = TextEditingController();
  final totalController = TextEditingController();
  final bodyController = TextEditingController();
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
            CustomTextField(controller: titleController, title: 'العنوان'),
            CustomTextField(controller: totalController, title: 'القيمة'),
            multiLineCustomTextField(controller: bodyController, title: 'تاريخ البداية'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("صورة الفاتورة"),
                SizedBox(height: 15,),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: () async {
                          FilePickerResult? _ = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: true);
                          if (_ != null) {
                            _.xFiles.forEach((element) async {
                              ImagesTempData.add(await element.path);
                            },);
                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                            height: 200,
                            width: 200,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                      ...List.generate(ImagesTempData.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(15)),
                              width: 200,
                              height: 200,
                              child: Image.file(File(ImagesTempData[index]), height: 200, width: 200, fit: BoxFit.fitHeight,)),
                        );
                      },)
                    ],
                  ),
                ),
              ],
            ),
            AppButton(text: "حفظ",    onPressed: () async {
              List imageLinkList = [];
              for(var i in ImagesTempData){
                final storageRef = FirebaseStorage.instance.ref().child('images/expenses/${DateTime.now().millisecondsSinceEpoch}.png');
                await storageRef.putFile(File(i));
                final imageLink = await storageRef.getDownloadURL();
                imageLinkList.add(imageLink);
              }
              ExpensesModel model = ExpensesModel(
                id: DateTime
                    .now()
                    .millisecondsSinceEpoch
                    .toString(),
                title: titleController.text,
                body: bodyController.text,
                total: int.parse(totalController.text),
                userId: getMyUserId(),
                images: imageLinkList,
              );
              controller.addExpenses(model);
              bodyController.clear();
              titleController.clear();
              totalController.clear();
              ImagesTempData.clear();
              setState(() {});
            },)

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
        decoration: BoxDecoration(color: Colors.white12, border: Border.all(color: primaryColor, width: 2), borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الوصف', style: TextStyle(color: primaryColor)),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                controller: controller,
                maxLines: null,
                decoration: InputDecoration(
                  //labelText: title,
                    labelStyle: TextStyle(color: primaryColor),
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

