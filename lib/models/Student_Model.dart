import 'dart:math';


import 'package:faker/faker.dart';

import 'Employee_Model.dart';
import 'Parent_Model.dart';
import 'event_record_model.dart';

class StudentModel {
  String? studentName,studentID,gender,StudentBirthDay,grade;
  String? studentNumber;
  bool? available=true;
  // String? address;
  // String? nationality;
  // List<String>? teachers;
  // List<ExamModel>? exams;
  ParentModel? parentModel;
  DateTime? startDate;
  // Map<String, double>? grades;
  List<EventRecordModel>? eventRecords;
  String? bus;
  // String? guardian;

  StudentModel({
     this.studentName,
     this.studentNumber,
     this.studentID,

     this.gender,
     this.StudentBirthDay,
     this.grade,

     this.startDate,

     this.eventRecords,
     this.bus,
     this.parentModel,
    this.available
  });

  Map<String, dynamic> toJson() => {
    'studentName': studentName,
    'studentNumber': studentNumber,
    'studentID': studentID,
    'gender': gender,
    'age': StudentBirthDay,
    'grade': grade,
    'startDate': startDate!.toIso8601String(),
    'eventRecords': eventRecords!.map((event) => event.toJson()).toList(),
    'parentModel': parentModel!.toJson(),
    'bus': bus,
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentName: json['studentName'],
      studentNumber: json['studentNumber'],
      studentID: json['studentID'],
      parentModel: ParentModel.fromJson(json['parentModel']),
      gender: json['gender'],
      StudentBirthDay: json['age'],
      grade: json['grade'],
      startDate: DateTime.parse(json['startDate']),
      eventRecords: (json['eventRecords'] as List)
          .map((event) => EventRecordModel.fromJson(event))
          .toList(),
      bus: json['bus'],
      // guardian: json['guardian'],
    );
  }

  @override
  String toString() {
    return 'Student(studentName: $studentName, studentNumber: $studentNumber, address: address, nationality: nationality, gender: $gender, age: $StudentBirthDay, grade: $grade, teachers: teachers, exams: exams, startDate: $startDate,, eventRecords: $eventRecords, bus: $bus, )';
  }
}
List<StudentModel> generateRandomStudents(int count) {
  var faker = Faker();
  var random = Random();
  List<StudentModel> students = [];

  for (int i = 0; i < count; i++) {
    students.add(StudentModel(
      studentName: faker.person.name(),
      studentNumber: faker.randomGenerator.integer(100000).toString(),
      studentID: faker.randomGenerator.integer(100000).toString(),
      // address: faker.address.streetAddress(),
      // nationality: faker.address.country(),
      gender: random.nextBool() ? 'Male' : 'Female',
      parentModel: generateRandomParents(1).first,
      StudentBirthDay: (random.nextInt(10) + 10).toString(),
      grade: 'Grade ${random.nextInt(12) + 1}',
      available: true,
      // teachers: List<String>.generate(5, (_) => faker.person.name()),
      // exams: generateRandomExams(3),
      startDate: faker.date.dateTime(minYear: 2020, maxYear: 2023),
      // grades: {
      //   'Math': random.nextDouble() * 100,
      //   'Science': random.nextDouble() * 100,
      //   'English': random.nextDouble() * 100,
      // },
      eventRecords: generateRandomEvents(5),
      bus: 'Bus ${random.nextInt(10)>5? 'Yes':'NO'}',
      // guardian: faker.person.name(),
    ));
  }

  return students;
}