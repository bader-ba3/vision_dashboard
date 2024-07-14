import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Store_Model.dart';

import '../../../controller/Wait_management_view_model.dart';

class StoreViewModel extends GetxController{
  final storeCollectionRef =
  FirebaseFirestore.instance.collection(storeCollection);


  StoreViewModel(){
    getAllStore();
  }
  Map<String, StoreModel> _storeMap = {};

  Map<String, StoreModel> get storeMap => _storeMap;

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  getAllStore()async {
    listener=   await   storeCollectionRef.snapshots().listen((value) {
      _storeMap.clear();
      for (var element in value.docs) {
        _storeMap[element.id] = StoreModel.fromJson(element.data());
      }
      print("StoreModel :${_storeMap.keys.length}");
      update();
    });
  }

  addStore(StoreModel storeModel) {
    storeCollectionRef.doc(storeModel.id).set(storeModel.toJson());
    update();
  }

  updateStore(StoreModel storeModel) async{
    await  storeCollectionRef
        .doc(storeModel.id)
        .set(storeModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteStore(String storeId)async {
    await addWaitOperation(
        type: waitingListTypes.delete,

        collectionName: storeCollection,
        affectedId: storeId);
    update();
  }



  getOldData(String value)async{

    await FirebaseFirestore.instance.collection(archiveCollection).doc(value).collection(storeCollection).get().then((value) {

      _storeMap.clear();
      for (var element in value.docs) {
        _storeMap[element.id] = StoreModel.fromJson(element.data());
      }
      print("StoreModel :${_storeMap.keys.length}");
      listener.cancel();
      update();
    });
  }
}