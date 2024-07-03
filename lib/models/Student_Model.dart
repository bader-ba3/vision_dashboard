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
  List<String>? stdExam,contractsImage;
  bool? available = false;

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
    this.contractsImage,
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
        if (contractsImage != null) 'contractsImage': contractsImage!,
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
    contractsImage =List.from(json['contractsImage'] ?? []) ;
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
    available = false;
  }

  @override
  String toString() {
    return 'Student(studentName: $studentName, studentNumber: $studentNumber, address: address, section: $section, gender: $gender, age: $StudentBirthDay, grade: $grade, teachers: teachers, exams: exams, startDate: $startDate,, eventRecords: $eventRecords, bus: $bus, )';
  }
}

