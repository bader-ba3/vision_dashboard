import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:vision_dashboard/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';


class EmployeeTimeView extends StatefulWidget {
  @override
  State<EmployeeTimeView> createState() => _EmployeeTimeViewState();
}

class _EmployeeTimeViewState extends State<EmployeeTimeView> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSecure = true;
  AccountManagementViewModel accountManagementViewModel = Get.find<AccountManagementViewModel>();

  @override
  void initState() {
    accountManagementViewModel.initNFC(false);
    super.initState();
  }

  @override
  void dispose() {
    accountManagementViewModel.disposeNFC();
    super.dispose();
  }

bool isShowLogin = true ;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountManagementViewModel>(builder: (controller) {
      return SafeArea(
        child: Center(
          child:Column(
            children: [
              SizedBox(height: 30,),
              Container(
                height: 50,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade300,),
                width: MediaQuery.sizeOf(context).width*0.7,
                child:Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              isShowLogin = true;
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width*0.35,
                              decoration: BoxDecoration( color: isShowLogin ? Colors.blueAccent.shade700: Colors.transparent,borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15),)),

                              child: Center(child: Text("تسجيل دخول الموظف",style: TextStyle(color: isShowLogin ? Colors.white:Colors.black),)),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              isShowLogin = false;
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.sizeOf(context).width*0.35,
                             decoration: BoxDecoration( color: isShowLogin ? Colors.transparent: Colors.blueAccent.shade700,borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15),)),
                              child: Center(child: Text("عرض تفاصيل دوام الموظفين",style: TextStyle(color: isShowLogin ? Colors.black:Colors.white),)),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if(isShowLogin)
              Expanded(
                child: Container(
                  width: 400,
                  child: controller.loginUserPage!=null
                      ?Center(child: Text("اهلا بك "+controller.loginUserPage.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),)
                      :Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("تسجيل الدوام", style: Styles.headLineStyle1,),
                      SizedBox(height: 50,),
                      if(controller.isSupportNfc)
                        Column(
                          children: [
                            Text("Login Using Your Card",style: TextStyle(fontSize: 22),)
                          ],
                        )
                      else
                        Column(
                          children: [
                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "اسم المستخدم",
                                hintStyle: Styles.headLineStyle2,
                                fillColor: bgColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            SizedBox(height: 50,),
                            TextField(
                              controller: passwordController,
                              obscureText: isSecure,
                              decoration: InputDecoration(
                                hintText: "كلمة المرور",
                                hintStyle: Styles.headLineStyle2,
                                fillColor: bgColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                suffixIcon: GestureDetector(
                                  onLongPressDown: (_) {
                                    isSecure = false;
                                    setState(() {});
                                  },
                                  onLongPressUp: () {
                                    isSecure = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(defaultPadding * 0.75),
                                    margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Icon(Icons.remove_red_eye_sharp, size: 20, color: Color(0xff00308F),),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50,),
                            InkWell(
                              onTap: () {

                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(defaultPadding * 0.75),
                                // margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Center(child: Text("تسجيل الدخول", style: TextStyle(fontSize: 22, color: bgColor),)),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              )
              else
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      for(var i in controller.allAccountManagement.values)
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.grey.shade300,
                          child: Column(
                            children: [
                              Text(i.userName),
                              for(var j in  i.employeeTime.values)
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: SizedBox(
                                   height: 50,
                                   child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       Text(j.dayName.toString()),
                                       Text(j.startDate.toString(),textDirection: TextDirection.ltr,),
                                       Text(j.endDate==null?"لم يخرج بعد":j.endDate.toString(),textDirection: TextDirection.ltr,),
                                       Text((j.totalDate??0).toString()),
                                       Text(j.isDayEnd.toString()),
                                     ],
                                   ),
                                 ),
                               )
                            ],
                          ),
                        )
                    ],
                  ),
                )),
            ],
          ),
        ),
      );
    });
  }
}
