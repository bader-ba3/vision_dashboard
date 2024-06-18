import 'dart:math';

import 'package:faker/faker.dart';

import 'Employee_Model.dart';
import 'event_record_model.dart';


class ParentModel {
  String? fullName,
      parentID,
      address,
      phoneNumber,
      motherPhone,
      emergencyPhone,age,
  id,
  nationality,startDate,
      work;

  // List<ExamModel> exams;
  List<EventRecordModel>? eventRecords;

  ParentModel({
    this.id,
    this.age,
    this.fullName,
    this.address,
    this.phoneNumber,
    this.motherPhone,
    this.startDate,
    this.emergencyPhone,
    this.work,
    this.parentID,
    this.eventRecords,
    this.nationality
  });

  // Method to convert ParentModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'startDate':startDate,
      'fullName': fullName,
      'parentID': parentID,
      'address': address,
      'nationality':nationality,
      'phoneNumber': phoneNumber,
      'mPhoneNumber': motherPhone,
      'emergencyPhone': emergencyPhone,
      'work': work,
      'id':id,
      'age':age,
      'eventRecords': eventRecords?.map((event) => event.toJson()).toList(),
    };
  }

  // Method to create ParentModel instance from JSON
  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName'],
      parentID: json['parentID'],
      address: json['address'],
      age:json['age'],
      startDate:json['startDate'],
      nationality: json['nationality'],
      phoneNumber: json['phoneNumber'],
      motherPhone: json['motherPhone'],
      emergencyPhone: json['emergencyPhone'],
      work: json['work'],
      id: json['id'],
      eventRecords: (json['eventRecords'] as List<dynamic>?)
          ?.map((event) => EventRecordModel.fromJson(event))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'ParentModel{fullName: $fullName, parentID: $parentID, address: $address, phoneNumber: $phoneNumber, mPhoneNumber: $motherPhone, emergencyPhone: $emergencyPhone, work: $work, eventRecords: $eventRecords}';
  }
}

// Generate random parents
List<ParentModel> generateRandomParents(int count) {
  var faker = Faker();
  List<ParentModel> parents = [];

  for (int i = 0; i < count; i++) {
    parents.add(ParentModel(
      fullName: faker.person.name(),
      address: faker.address.streetAddress(),
      work: faker.conference.name(),
      age: Random().nextInt(99).toString(),
      nationality: faker.address.country(),
      startDate: faker.date.dateTimeBetween(DateTime(2010), DateTime.now()).toString(),
      emergencyPhone:
          "05${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      phoneNumber:
          "05${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      motherPhone:
          "05${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      parentID: faker.randomGenerator.integer(1000000).toString(),
      eventRecords: generateRandomEvents(5),
    ));
  }

  return parents;
}
