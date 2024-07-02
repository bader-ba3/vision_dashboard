import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';

import '../../../controller/delete_management_view_model.dart';
import '../../../models/Bus_Model.dart';

class BusViewModel extends GetxController{

  final buseCollectionRef =
  FirebaseFirestore.instance.collection(busesCollection);
  final firebaseFirestore =
      FirebaseFirestore.instance;



  BusViewModel(){
    getAllBuse();
  }
  Map<String, BusModel> _busesMap = {};

  Map<String, BusModel> get busesMap => _busesMap;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;
  getAllBuse()async {
    listener  =  await   buseCollectionRef.snapshots().listen((value) {
      _busesMap.clear();
      for (var element in value.docs) {
        _busesMap[element.id] = BusModel.fromJson(element.data());
      }
      print("buses :${_busesMap.values.length}");
      update();
    });

  }

  addBus(BusModel buseModel) {
    buseCollectionRef.doc(buseModel.busId).set(buseModel.toJson(), SetOptions(merge: true));
    update();
  }

  updateBus(BusModel buseModel) async{
    await  buseCollectionRef
        .doc(buseModel.busId)
        .set(buseModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteBus(String buseId)async {
    await addDeleteOperation(
        collectionName: busesCollection,
        affectedId: buseId);
    update();
  }

  getOldBuse(String value) async{
    await   firebaseFirestore.collection(archiveCollection).doc(value).collection(busesCollection).get().then((value) {
      _busesMap.clear();
      for (var element in value.docs) {
        _busesMap[element.id] = BusModel.fromJson(element.data());

      }
      print("buses :${_busesMap.values.length}");
      update();
    });

  }

   addExpenses(String busId,String expensesId) {

     buseCollectionRef.doc(busId).set({"expense":FieldValue.arrayUnion([expensesId])}, SetOptions(merge: true));

   }

  getOldData(String value) {

    FirebaseFirestore.instance
        .collection(archiveCollection)
        .doc(value)
        .collection(busesCollection)
        .get().then((value) {
      _busesMap.clear();
      for (var element in value.docs) {
        _busesMap[element.id] = BusModel.fromJson(element.data());
      }
      print("buses :${_busesMap.values.length}");
      listener.cancel();
      update();
        },);
  }
  
  
}