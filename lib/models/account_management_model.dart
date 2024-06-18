import 'package:vision_dashboard/models/employee_time_model.dart';

class AccountManagementModel {
  late String id, userName, password, type;
  String? serialNFC;
  late bool isActive;
  Map<String, EmployeeTimeModel> employeeTime = {};

  AccountManagementModel({required this.id, required this.userName, required this.password, required this.type, required this.serialNFC, required this.isActive});

  AccountManagementModel.fromJson(json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    type = json['type'];
    serialNFC = json['serialNFC'];
    isActive = json['isActive'] ?? true;
    (json['employeeTime'] ?? {}).forEach((k, v) {
      employeeTime[k] = EmployeeTimeModel.fromJson(v);
    });
  }

  toJson() {
    return {
      "id": id,
      "userName": userName,
      "password": password,
      "type": type,
      "serialNFC": serialNFC,
      "isActive": isActive,
      "employeeTime": Map.fromEntries(employeeTime.entries.map((e) => MapEntry(e.key, e.value.toJson())).toList())};
  }
}
