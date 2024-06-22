import 'dart:math';

import 'package:faker/faker.dart';

class ExamModel {
  String? subject,professor,passRate,id;
  DateTime? date;
  List<String>? students,questionImage,answerImage;


  ExamModel({
     this.questionImage,
     this.subject,
     this.professor,
     this.date,
     this.students,
     this.passRate,
    this.id,
    this.answerImage,

  });

  Map<String, dynamic> toJson() => {
    'id':id,
    'questionImage': questionImage!.toList(),
    'subject': subject,
    'professor': professor,
    'date': date!.toIso8601String(),
    'students': students,
    'passRate': passRate,
    'answerImage':answerImage!.toList(),
  };

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id:json['id']??'',
      questionImage:List<String>.from(json['questionImage']??[]),
      answerImage:  List<String>.from(json['answerImage']??[]),

      subject: json['subject']??'',
      professor: json['professor']??'',
      date: DateTime.parse(json['date']??DateTime.now()),
      students: List<String>.from(json['students']??[]),
      passRate: json['passRate']??'',
    );
  }

  @override
  String toString() {
    return 'Exam(image: $questionImage, subject: $subject, professor: $professor, date: $date, students: $students, passRate: $passRate)';
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
      students: List<String>.generate(
          10, (_) => faker.person.name()), // 10 طلاب عشوائيين لكل امتحان
      passRate: (random.nextDouble() * 100).toDouble().toString(),
    ));
  }

  return exams;
}