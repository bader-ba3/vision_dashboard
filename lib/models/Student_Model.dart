import 'dart:math';

import 'package:vision_dashboard/models/Employee_Model.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:faker/faker.dart';

class StudentModel {
  String? studentName;
  String? studentNumber;
  String? address;
  String? nationality;
  String? gender;
  String? age;
  String? grade;
  List<String>? teachers;
  List<ExamModel>? exams;
  DateTime? startDate;
  Map<String, double>? grades;
  List<EventRecordModel>? eventRecords;
  String? bus;
  String? guardian;

  StudentModel({
    required this.studentName,
    required this.studentNumber,
    required this.address,
    required this.nationality,
    required this.gender,
    required this.age,
    required this.grade,
    required this.teachers,
    required this.exams,
    required this.startDate,
    required this.grades,
    required this.eventRecords,
    required this.bus,
    required this.guardian,
  });

  Map<String, dynamic> toJson() => {
    'studentName': studentName,
    'studentNumber': studentNumber,
    'address': address,
    'nationality': nationality,
    'gender': gender,
    'age': age,
    'grade': grade,
    'teachers': teachers,
    'exams': exams!.map((exam) => exam.toJson()).toList(),
    'startDate': startDate!.toIso8601String(),
    'grades': grades,
    'eventRecords': eventRecords!.map((event) => event.toJson()).toList(),
    'bus': bus,
    'guardian': guardian,
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentName: json['studentName'],
      studentNumber: json['studentNumber'],
      address: json['address'],
      nationality: json['nationality'],
      gender: json['gender'],
      age: json['age'],
      grade: json['grade'],
      teachers: List<String>.from(json['teachers']),
      exams: (json['exams'] as List)
          .map((exam) => ExamModel.fromJson(exam))
          .toList(),
      startDate: DateTime.parse(json['startDate']),
      grades: Map<String, double>.from(json['grades']),
      eventRecords: (json['eventRecords'] as List)
          .map((event) => EventRecordModel.fromJson(event))
          .toList(),
      bus: json['bus'],
      guardian: json['guardian'],
    );
  }

  @override
  String toString() {
    return 'Student(studentName: $studentName, studentNumber: $studentNumber, address: $address, nationality: $nationality, gender: $gender, age: $age, grade: $grade, teachers: $teachers, exams: $exams, startDate: $startDate, grades: $grades, eventRecords: $eventRecords, bus: $bus, guardian: $guardian)';
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
      address: faker.address.streetAddress(),
      nationality: faker.address.country(),
      gender: random.nextBool() ? 'Male' : 'Female',
      age: (random.nextInt(10) + 10).toString(),
      grade: 'Grade ${random.nextInt(12) + 1}',
      teachers: List<String>.generate(5, (_) => faker.person.name()),
      exams: generateRandomExams(3),
      startDate: faker.date.dateTime(minYear: 2020, maxYear: 2023),
      grades: {
        'Math': random.nextDouble() * 100,
        'Science': random.nextDouble() * 100,
        'English': random.nextDouble() * 100,
      },
      eventRecords: generateRandomEvents(5),
      bus: 'Bus ${random.nextInt(10) + 1}',
      guardian: faker.person.name(),
    ));
  }

  return students;
}