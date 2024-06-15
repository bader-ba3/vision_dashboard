import 'dart:math';

import 'package:faker/faker.dart';

class ExamModel {
  String? image,subject,professor,passRate;
  DateTime date;
  List<String> students;


  ExamModel({
    required this.image,
    required this.subject,
    required this.professor,
    required this.date,
    required this.students,
    required this.passRate,
  });

  Map<String, dynamic> toJson() => {
    'image': image,
    'subject': subject,
    'professor': professor,
    'date': date.toIso8601String(),
    'students': students,
    'passRate': passRate,
  };

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      image: json['image'],
      subject: json['subject'],
      professor: json['professor'],
      date: DateTime.parse(json['date']),
      students: List<String>.from(json['students']),
      passRate: json['passRate'].toDouble(),
    );
  }

  @override
  String toString() {
    return 'Exam(image: $image, subject: $subject, professor: $professor, date: $date, students: $students, passRate: $passRate)';
  }
}
   List<ExamModel> generateRandomExams(int count) {
  var faker = Faker();
  var random = Random();
  List<ExamModel> exams = [];

  for (int i = 0; i < count; i++) {
    exams.add(ExamModel(
      image: faker.image.image(random: true),
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