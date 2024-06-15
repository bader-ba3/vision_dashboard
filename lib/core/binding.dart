import 'package:vision_dashboard/controller/account_management_view_model.dart';
import 'package:vision_dashboard/controller/expenses_view_model.dart';
import 'package:vision_dashboard/controller/home_controller.dart';
import 'package:get/get.dart';
class GetBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(HomeViewModel());
    Get.put(AccountManagementViewModel());
    Get.put(ExpensesViewModel());
  }

}
