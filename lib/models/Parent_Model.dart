import 'dart:math';

import 'package:faker/faker.dart';


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

  List<dynamic>? children;
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
    this.nationality,

    this.children,
  });


  Map<String, dynamic> toJson() {
    return {
      if(startDate!=null)   'startDate':startDate,
      if(fullName!=null)   'fullName': fullName,
      if(parentID!=null)    'parentID': parentID,
      if(address!=null)  'address': address,
      if(nationality!=null)  'nationality':nationality,
      if(phoneNumber!=null)   'phoneNumber': phoneNumber,
      if(motherPhone!=null)    'motherPhone': motherPhone,
      if(emergencyPhone!=null)    'emergencyPhone': emergencyPhone,
      if(work!=null)    'work': work,
      if(id!=null)      'id':id,
      if(age!=null)     'age':age,
      if(children!=null)    'children':children,
      if(eventRecords!=null)   'eventRecords': eventRecords?.map((event) => event.toJson()).toList()??[],
    };
  }

  // Method to create ParentModel instance from JSON
  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      fullName: json['fullName']??'',
      parentID: json['parentID']??'',
      address: json['address']??'',
      age:json['age']??'',
      startDate:json['startDate']??'',
      nationality: json['nationality']??'',
      phoneNumber: json['phoneNumber']??'',
      motherPhone: json['motherPhone']??'',
      emergencyPhone: json['emergencyPhone']??'',
      work: json['work']??'',
      id: json['id']??'',
      children: json['children']??[],
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
      eventRecords: [],
    ));
  }

  return parents;
}
