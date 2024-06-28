import 'dart:math';

import 'package:faker/faker.dart';
import 'package:vision_dashboard/models/Installment_model.dart';

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
      paymentWay,
      stdClass;
  String? studentNumber;
  int? totalPayment;
  double? grade;
  List<String>? stdExam;
  bool? available = true;

  Map<String, InstallmentModel>? installmentRecords = {};
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
    this.installmentRecords,
    this.bus,
    this.parentId,
    this.available,
    this.section,
    this.stdClass,
    this.stdLanguage,

    this.totalPayment,
    this.paymentWay,
  });

  Map<String, dynamic> toJson() => {
        if (studentName != null) 'studentName': studentName,
        if (studentNumber != null) 'studentNumber': studentNumber,
        if (studentID != null) 'studentID': studentID,
        if (gender != null) 'gender': gender,
        if (StudentBirthDay != null) 'StudentBirthDay': StudentBirthDay,
        if (stdClass != null) 'stdClass': stdClass,
        if (grade != null) 'grade': grade,
        if (stdLanguage != null) 'stdLanguage': stdLanguage,
        if (stdExam != null) 'stdExam': stdExam,
        if (section != null) 'section': section,
        if (startDate != null) 'startDate': startDate!,
        if (eventRecords != null)
          'eventRecords': eventRecords!.map((event) => event.toJson()).toList(),
        if (installmentRecords != null)
          'installmentRecords': Map.fromEntries(installmentRecords!.entries
              .map((e) => MapEntry(e.key, e.value.toJson()))
              .toList()),
        if (parentId != null) 'parentId': parentId!,
        if (bus != null) 'bus': bus,
        if (paymentWay != null) 'paymentWay': paymentWay,
        if (totalPayment != null) 'totalPayment': totalPayment,
      };

  StudentModel.fromJson(Map<String, dynamic> json) {
    grade = 0.0;
    studentName = json['studentName'] ?? '';
    studentNumber = json['studentNumber'] ?? '';
    studentID = json['studentID'] ?? '';
    parentId = json['parentId'] ?? '';
    section = json['section'] ?? '';
    stdLanguage = json['stdLanguage'] ?? '';
    stdExam = (json['stdExam'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList() ??
        [];
    stdClass = json['stdClass'] ?? '';
    gender = json['gender'] ?? '';
    StudentBirthDay = json['StudentBirthDay'] ?? '';
    startDate = json['startDate'] ?? '';
    eventRecords = (json['eventRecords'] as List<dynamic>?)
            ?.map((event) => EventRecordModel.fromJson(event))
            .toList() ??
        [];
    (json['installmentRecords'] ?? {}).forEach((k, v) {
      installmentRecords![k] = InstallmentModel.fromJson(v);
    });

    bus = json['bus'] ?? '';
    totalPayment = json['totalPayment'] ?? 0;
    paymentWay = json['paymentWay'] ?? '';
    available = true;
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
