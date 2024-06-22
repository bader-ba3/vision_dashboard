import 'dart:math';

import 'package:faker/faker.dart';

import 'event_record_model.dart';

class EmployeeModel {
  String? fullName, mobileNumber, address, nationality, gender, age, jobTitle,
      salary, contract, bus;
  DateTime? startDate;
bool? available=true;
  List<EventRecordModel>? eventRecords;

  EmployeeModel({
    this.fullName,
    this.mobileNumber,
    this.address,
    this.nationality,
    this.gender,
    this.age,
    this.jobTitle,
    this.salary,
    this.contract,
    this.bus,
    this.startDate,
    this.eventRecords,
    this.available
  });

  // Convert an Employee to a Map
  Map<String, dynamic> toJson() =>
      {
        'fullName': fullName,
        'mobileNumber': mobileNumber,
        'address': address,
        'nationality': nationality,
        'gender': gender,
        'age': age,
        'jobTitle': jobTitle,
        'salary': salary,
        'contract': contract,
        'bus': bus,
        if(startDate != null)
          'startDate': startDate!.toIso8601String(),
        if(eventRecords!.isNotEmpty)
          'eventRecords': eventRecords!.map((event) => event.toJson()).toList(),
      };

  // Create an Employee from a Map
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      fullName: json['fullName'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      nationality: json['nationality'],
      gender: json['gender'],
      age: json['age'],
      jobTitle: json['jobTitle'],
      salary: json['salary'],
      contract: json['contract'],
      bus: json['bus'],
      startDate: DateTime.parse(json['startDate']),
      eventRecords: (json['eventRecords'] as List)
          .map((event) => EventRecordModel.fromJson(event))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Employee(fullName: $fullName, mobileNumber: $mobileNumber, address: $address, nationality: $nationality, gender: $gender, age: $age, jobTitle: $jobTitle, salary: $salary, contract: $contract, bus: $bus, startDate: $startDate, eventRecords: $eventRecords)';
  }
}
  List<EventRecordModel> generateRandomEvents(int count) {

    List<EventRecordModel> events = [];



    return events;
  }
  List<EmployeeModel> generateRandomEmployees(int count) {
    var faker = Faker();
    var random = Random();
    List<String> genders = ['Male', 'Female'];
    List<String> contracts = ['Full-time', 'Part-time', 'Contract'];
    List<String> buses = ['Bus A', 'Bus B', 'Bus C'];
    List<EmployeeModel> employees = [];

    for (int i = 0; i < count; i++) {
      employees.add(EmployeeModel(
        fullName: faker.person.name(),
          available:true,
        mobileNumber: faker.phoneNumber.random.numberOfLength(8),
        address: faker.address.streetAddress(),
        nationality: faker.address.country(),
        gender: genders[random.nextInt(genders.length)],
        age: (random.nextInt(40) + 20).toString(),
        jobTitle: faker.job.title(),
        salary: ((random.nextInt(9000) + 1000).toDouble()).toString(),
        contract: contracts[random.nextInt(contracts.length)],
        bus: buses[random.nextInt(buses.length)],
        startDate: faker.date.dateTime(minYear: 2020, maxYear: 2023),
        eventRecords: generateRandomEvents(5),
      ));
    }

    return employees;
  }



