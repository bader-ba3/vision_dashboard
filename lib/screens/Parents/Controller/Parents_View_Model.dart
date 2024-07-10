import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/models/Parent_Model.dart';

class ParentsViewModel extends GetxController {
  final parentCollectionRef =
      FirebaseFirestore.instance.collection(parentsCollection);
  final firebaseFirestore =
  FirebaseFirestore.instance;





  ParentsViewModel(){
    getAllParent();
  }
  Map<String, ParentModel> _parentMap = {};

  Map<String, ParentModel> get parentMap => _parentMap;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  getAllParent()async {
    listener=   await   parentCollectionRef.snapshots().listen((value) {
      _parentMap.clear();
      for (var element in value.docs) {
        _parentMap[element.id] = ParentModel.fromJson(element.data());
      }
      print("Parents :${_parentMap.values.length}");
      update();
    });
  }

  addParent(ParentModel parentModel) {
    parentCollectionRef.doc(parentModel.id).set(parentModel.toJson(), SetOptions(merge: true));
    update();
  }

  updateParent(ParentModel parentModel) async{
    await  parentCollectionRef
        .doc(parentModel.id)
        .set(parentModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteParent(String parentId,List studentList)async {
   await addDeleteOperation(
        collectionName: parentsCollection,
        affectedId: parentId,
   relatedList: studentList.map((e) => e.toString(),).toList());
    update();
  }

  getOldParent(String value) async{
    await   firebaseFirestore.collection(archiveCollection).doc(value).collection(parentsCollection).get().then((value) {
      _parentMap.clear();
      for (var element in value.docs) {
        _parentMap[element.id] = ParentModel.fromJson(element.data());

      }
      print("Parents :${_parentMap.values.length}");
      listener.cancel();
      update();
    });

  }
}
