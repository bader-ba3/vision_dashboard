import 'dart:math';

import 'package:faker/faker.dart';

class ExamModel {
  String? subject,professor,id,examPassMark,examMaxMark;
  DateTime? date;
  double? passRate;
  bool? enableEdite;
  List<String>? questionImage,answerImage;
Map<String,dynamic>? marks;

  ExamModel({
     this.questionImage,
     this.subject,
     this.professor,
     this.date,
     this.marks,
     this.passRate,
    this.id,
    this.answerImage,
    this.examPassMark,
    this.examMaxMark,
    this.enableEdite,

  });

  Map<String, dynamic> toJson() => {
    'id':id,
    'examPassMark':examPassMark,
    'questionImage': questionImage!.toList(),
    'subject': subject,
    'professor': professor,
    'date': date!.toIso8601String(),
    'marks': marks,
    'examMaxMark': examMaxMark,
    'answerImage':answerImage!.toList(),
  };

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id:json['id']??'',
      questionImage:List<String>.from(json['questionImage']??[]),
      answerImage:  List<String>.from(json['answerImage']??[]),
      passRate:0.0,
      subject: json['subject']??'',
      examPassMark: json['examPassMark']??'0',
      examMaxMark: json['examMaxMark']??'0',
      professor: json['professor']??'',
      date: DateTime.parse(json['date']??DateTime.now()),
      marks: json['marks']??{"":"0"},

    );
  }

  @override
  String toString() {
    return 'Exam(image: $questionImage, subject: $subject, professor: $professor, date: $date, marks: ${marks!.values.toList()}, passRate: $passRate)';
  }
}
   List<ExamModel> generateRandomExams(int count) {
  var faker = Faker();
  var random = Random();
  List<ExamModel> exams = [];

  for (int i = 0; i < count; i++) {
    exams.add(ExamModel(
      id: faker.phoneNumber.us(),
      questionImage: [faker.sport.name()],
      subject: faker.sport.name(),
      professor: faker.person.name(),
      date: faker.date.dateTime(minYear: 2020, maxYear: 2023),
      marks: {"56456465465":"0"},
      passRate: (random.nextDouble() * 100).toDouble(),
    ));
  }

  return exams;
}