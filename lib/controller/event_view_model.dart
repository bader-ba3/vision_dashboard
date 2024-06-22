

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:vision_dashboard/models/event_model.dart';

import '../utils/const.dart';


class EventViewModel extends GetxController{
  RxMap<String,EventModel> allEvents = <String,EventModel>{}.obs;
  final eventFireStore = FirebaseFirestore.instance.collection(Const.eventCollection).withConverter<EventModel>(
    fromFirestore: (snapshot, _) =>EventModel.fromJson(snapshot.data()!),
    toFirestore: (account, _) => account.toJson(),
  );

  EventViewModel(){
    eventFireStore.snapshots().listen((event) {
      allEvents = Map<String,EventModel>.fromEntries(event.docs.toList().map((i)=>MapEntry(i.id.toString(), i.data()))).obs;
      update();
    },);
  }

  addEvent(EventModel eventModel){
    eventFireStore.doc(eventModel.id).set(eventModel);
  }

  updateEvent(EventModel eventModel){
    eventFireStore.doc(eventModel.id).update(eventModel.toJson());
  }

  deleteEvent(EventModel eventModel){
    eventFireStore.doc(eventModel.id).delete();
  }

}