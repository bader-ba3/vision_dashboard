import 'dart:math';

import 'package:faker/faker.dart';


import 'event_record_model.dart';

class StudentModel {
  String? studentName,
      studentID,
      gender,
      StudentBirthDay,
stdLanguage,
      parentId,
      section,
      startDate,
      stdClass;
  String? studentNumber;
  double? grade;
  List<String>? stdExam;
  bool? available = true;

  List<EventRecordModel>? eventRecords;
  String? bus;

  // String? guardian;

  StudentModel({
    this.studentName,
    this.studentNumber,
    this.studentID,
    this.stdExam,
    this.gender,
    this.StudentBirthDay,
    this.grade,
    this.startDate,
    this.eventRecords,
    this.bus,
    this.parentId,
    this.available,
    this.section,
    this.stdClass,
    this.stdLanguage,
  });

  Map<String, dynamic> toJson() => {
        'studentName': studentName,
        'studentNumber': studentNumber,
        'studentID': studentID,
        'gender': gender,
        'StudentBirthDay': StudentBirthDay,
        'stdClass': stdClass,
        'grade': grade,
        'stdLanguage': stdLanguage,
        'stdExam': stdExam,
        'section': section,
        'startDate': startDate!,
        'eventRecords': eventRecords!.map((event) => event.toJson()).toList(),
        'parentId': parentId!,
        'bus': bus,
      };

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      grade: 0.0,
      studentName: json['studentName'],
      studentNumber: json['studentNumber'],
      studentID: json['studentID'],
      parentId: json['parentId'],
      section: json['section'],
      stdLanguage: json['stdLanguage'],
      stdExam: (json['stdExam'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList()??[],
      stdClass: json['stdClass'],
      gender: json['gender'],
      StudentBirthDay: json['StudentBirthDay'],
      startDate: json['startDate'],
      eventRecords: (json['eventRecords'] as List)
          .map((event) => EventRecordModel.fromJson(event))
          .toList(),
      bus: json['bus'],
      available: true,
    );
  }

  @override
  String toString() {
    return 'Student(studentName: $studentName, studentNumber: $studentNumber, address: address, section: $section, gender: $gender, age: $StudentBirthDay, grade: $grade, teachers: teachers, exams: exams, startDate: $startDate,, eventRecords: $eventRecords, bus: $bus, )';
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
      section: "الشعبة${random.nextInt(5)}",
      gender: random.nextBool() ? 'Male' : 'Female',
      parentId: faker.person.name(),
      StudentBirthDay: (random.nextInt(10) + 10).toString(),
      grade: random.nextDouble(),
      available: true,
      startDate: faker.date.dateTime(minYear: 2020, maxYear: 2023).toString(),
      eventRecords: [],
      bus: 'Bus ${random.nextInt(10) > 5 ? 'Yes' : 'NO'}',
      // guardian: faker.person.name(),
    ));
  }

  return students;
}
