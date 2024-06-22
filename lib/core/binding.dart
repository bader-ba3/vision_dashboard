import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/controller/event_view_model.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';
import 'package:vision_dashboard/screens/Parents/Controller/Parents_View_Model.dart';
class GetBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(HomeViewModel());
    Get.put(AccountManagementViewModel());
    Get.put(ExpensesViewModel());
    Get.put(EventViewModel());
    Get.put(DeleteManagementViewModel());
    Get.put(ParentsViewModel());
    Get.put(ExamViewModel());
  }

}
