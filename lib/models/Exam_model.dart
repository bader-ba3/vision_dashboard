import 'dart:math';

import 'package:faker/faker.dart';

class ExamModel {
  String? subject,professor,id,examPassMark,examMaxMark;
  DateTime? date;
  double? passRate;
bool? isDone;
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
    this.isDone,

  });

  Map<String, dynamic> toJson() => {
   if(id!=null) 'id':id,
    if(examPassMark!=null)    'examPassMark':examPassMark,
    if(questionImage!=null)   'questionImage': questionImage!.toList(),
    if(subject!=null)   'subject': subject,
    if(professor!=null)    'professor': professor,
    if(date!=null)    'date': date!.toIso8601String(),
    if(marks!=null)    'marks': marks,
    if(examMaxMark!=null)     'examMaxMark': examMaxMark,
    if(isDone!=null)     'isDone': isDone,
    if(answerImage!=null)    'answerImage':answerImage!.toList(),
  };

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id:json['id']??'',
      questionImage:List<String>.from(json['questionImage']??[]),
      answerImage:  List<String>.from(json['answerImage']??[]),
      passRate:0.0,
      subject: json['subject']??'',
      isDone: json['isDone']??false,
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