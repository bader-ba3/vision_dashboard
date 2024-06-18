import 'dart:math';

import 'package:faker/faker.dart';

import 'Employee_Model.dart';


class ParentModel {
  String? fullName,
      parentID,
      number,
      address,
      phoneNumber,
      motherPhoneNumber,
      emergencyPhone,
  id,
      work;

  // List<ExamModel> exams;
  List<EventRecordModel>? eventRecords;

  ParentModel({
    this.id,
    this.fullName,
    this.number,
    this.address,
    this.phoneNumber,
    this.motherPhoneNumber,
    this.emergencyPhone,
    this.work,
    this.parentID,
    this.eventRecords,
  });

  // Method to convert ParentModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'parentID': parentID,
      'number': number,
      'address': address,
      'phoneNumber': phoneNumber,
      'mPhoneNumber': motherPhoneNumber,
      'emergencyPhone': emergencyPhone,
      'work': work,
      'id':id,
      'eventRecords': eventRecords?.map((event) => event.toJson()).toList(),
    };
  }

  // Method to create ParentModel instance from JSON
  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName'],
      parentID: json['parentID'],
      number: json['number'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      motherPhoneNumber: json['mPhoneNumber'],
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
    return 'ParentModel{fullName: $fullName, parentID: $parentID, number: $number, address: $address, phoneNumber: $phoneNumber, mPhoneNumber: $motherPhoneNumber, emergencyPhone: $emergencyPhone, work: $work, eventRecords: $eventRecords}';
  }
}

// Generate random parents
List<ParentModel> generateRandomParents(int count) {
  var faker = Faker();
  List<ParentModel> parents = [];

  for (int i = 0; i < count; i++) {
    parents.add(ParentModel(
      fullName: faker.person.name(),
      number: faker.randomGenerator.integer(100000).toString(),
      address: faker.address.streetAddress(),
      work: faker.address.country(),
      emergencyPhone:
          "971-5${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      phoneNumber:
          "971-5${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      motherPhoneNumber:
          "971-5${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}-${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}${Random().nextInt(9)}",
      parentID: faker.randomGenerator.integer(1000000).toString(),
      eventRecords: generateRandomEvents(5),
    ));
  }

  return parents;
}
