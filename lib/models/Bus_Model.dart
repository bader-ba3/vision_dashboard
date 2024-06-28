import 'dart:math';

import 'package:faker/faker.dart';

import 'event_record_model.dart';

class BusModel {
  String name;
  String number;
  String type;
  String employee;
  List<String> students;
  DateTime startDate;
  double expense;

  List<EventRecordModel> eventRecords;

  BusModel({
    required this.name,
    required this.number,
    required this.type,
    required this.employee,
    required this.students,
    required this.startDate,
    required this.expense,
    required this.eventRecords,

  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'number': number,
    'type': type,
    'employee': employee,
    'students': students,
    'startDate': startDate.toIso8601String(),
    'expense': expense,
    'eventRecords': eventRecords.map((event) => event.toJson()).toList(),
  };

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      name: json['name'],
      number: json['number'],
      type: json['type'],
      employee: json['employee'],
      students: List<String>.from(json['students']),
      startDate: DateTime.parse(json['startDate']),
      expense: json['expense'].toDouble(),
      eventRecords: (json['eventRecords'] as List<dynamic>?)
          ?.map((event) => EventRecordModel.fromJson(event))
          .toList()??[],
    );
  }

  @override
  String toString() {
    return 'Bus(name: $name, number: $number, type: $type, employee: $employee, students: $students, startDate: $startDate, expense: $expense, eventRecords: $eventRecords)';
  }
}
// Generate random buses
List<BusModel> generateRandomBuses(int count) {
  var faker = Faker();
  var random = Random();
  List<BusModel> buses = [];

  for (int i = 0; i < count; i++) {
    buses.add(BusModel(
      name: faker.vehicle.model(),
      number: faker.randomGenerator.integer(1000).toString(),
      type: faker.vehicle.vin(),
      employee: faker.person.name(),
      students: List<String>.generate(10, (_) => faker.person.name()), // 10 random students per bus
      startDate: faker.date.dateTime(minYear: 2020, maxYear: 2023),
      expense: random.nextDouble() * 1000,
      eventRecords: [],
    ));
  }

  return buses;
}