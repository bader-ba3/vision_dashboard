import 'package:vision_dashboard/models/employee_time_model.dart';

import 'event_record_model.dart';

class AccountManagementModel {
  late String id, userName, password, type;
  String? serialNFC;
  int? salary, dayOfWork;
  late bool isActive;
  Map<String, EmployeeTimeModel> employeeTime = {};
  String? mobileNumber,
      address,
      nationality,
      gender,
      age,
      jobTitle,
      contract,
      bus,
      startDate,salaryWithDelay,

  fullName;
List<dynamic>? salaryReceived;
  bool? available = true;
  List<EventRecordModel>? eventRecords;

  AccountManagementModel(
      {required this.id,
      required this.userName,
      required this.password,
      required this.type,
      required this.serialNFC,
      required this.isActive,
      required this.salary,
      required this.dayOfWork,
      this.mobileNumber,
      this.address,
      this.nationality,
      this.gender,
      this.age,
      this.jobTitle,
      this.contract,
      this.bus,
      this.startDate,
      this.eventRecords,
      this.salaryReceived,
      this.salaryWithDelay,
      this.fullName,
      this.available});

  AccountManagementModel.fromJson(json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    type = json['type'];
    fullName = json['fullName'];
    serialNFC = json['serialNFC'];
    salary = json['salary'];
    salaryReceived = json['salaryReceived']??[];
    dayOfWork = json['dayOfWork'];
    isActive = json['isActive'] ?? true;
    (json['employeeTime'] ?? {}).forEach((k, v) {
      employeeTime[k] = EmployeeTimeModel.fromJson(v);
    });
    mobileNumber = json['mobileNumber'];
    address = json['address'];
    nationality = json['nationality'];
    gender = json['gender'];
    age = json['age'];
    jobTitle = json['jobTitle'];
    contract = json['contract'];
    bus = json['bus'];
    startDate = json['startDate'];
    eventRecords = ((json['eventRecords'] ??[])as List)
        .map((event) => EventRecordModel.fromJson(event))
        .toList();
  }

  toJson() {
    return {
      "id": id,
      "userName": userName,
      "fullName": fullName,
      "password": password,
      "salaryReceived": salaryReceived?.toList(),
      "type": type,
      "serialNFC": serialNFC,
      "isActive": isActive,
      "salary": salary,
      "dayOfWork": dayOfWork,
      "employeeTime": Map.fromEntries(employeeTime.entries
          .map((e) => MapEntry(e.key, e.value.toJson()))
          .toList()),
      'mobileNumber': mobileNumber,
      'address': address,
      'nationality': nationality,
      'gender': gender,
      'age': age,
      'jobTitle': jobTitle,
      'contract': contract,
      'bus': bus,
      if (startDate != null) 'startDate': startDate!,
        'eventRecords':eventRecords!.isNotEmpty? eventRecords!.map((event) => event.toJson()).toList():[],
    };
  }
}
