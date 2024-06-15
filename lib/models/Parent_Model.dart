import 'dart:math';

import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:faker/faker.dart';

class ParentModel {
  String fullName;
  String number;
  String address;
  String nationality;
  String gender;
  int age;
  List<String> children;
  DateTime startDate;
  List<ExamModel> exams;
  List<EventRecordModel> eventRecords;

  ParentModel({
    required this.fullName,
    required this.number,
    required this.address,
    required this.nationality,
    required this.gender,
    required this.age,
    required this.children,
    required this.startDate,
    required this.exams,
    required this.eventRecords,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'number': number,
    'address': address,
    'nationality': nationality,
    'gender': gender,
    'age': age,
    'children': children,
    'startDate': startDate.toIso8601String(),
    'exams': exams.map((exam) => exam.toJson()).toList(),
    'eventRecords': eventRecords.map((event) => event.toJson()).toList(),
  };

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName'],
      number: json['number'],
      address: json['address'],
      nationality: json['nationality'],
      gender: json['gender'],
      age: json['age'],
      children: List<String>.from(json['children']),
      startDate: DateTime.parse(json['startDate']),
      exams: (json['exams'] as List)
          .map((exam) => ExamModel.fromJson(exam))
          .toList(),
      eventRecords: (json['eventRecords'] as List)
          .map((event) => EventRecordModel.fromJson(event))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Parent(fullName: $fullName, number: $number, address: $address, nationality: $nationality, gender: $gender, age: $age, children: $children, startDate: $startDate, exams: $exams, eventRecords: $eventRecords)';
  }
}

// Generate random parents
List<ParentModel> generateRandomParents(int count) {
  var faker = Faker();
  var random = Random();
  List<ParentModel> parents = [];

  for (int i = 0; i < count; i++) {
    parents.add(ParentModel(
      fullName: faker.person.name(),
      number: faker.randomGenerator.integer(100000).toString(),
      address: faker.address.streetAddress(),
      nationality: faker.address.country(),
      gender: random.nextBool() ? 'Male' : 'Female',
      age: random.nextInt(30) + 30,
      children: List<String>.generate(3, (_) => faker.person.name()), // 3 random children per parent
      startDate: faker.date.dateTime(minYear: 2020, maxYear: 2023),
      exams: generateRandomExams(3),
      eventRecords: generateRandomEvents(5),
    ));
  }

  return parents;
}