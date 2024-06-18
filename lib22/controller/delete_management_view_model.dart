import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/screens/login/login_screen.dart';

import '../models/account_management_model.dart';
import '../models/delete_management_model.dart';
import '../screens/main/main_screen.dart';
import '../utils/const.dart';

class DeleteManagementViewModel extends GetxController{

  RxMap<String,DeleteManagementModel> allDelete = <String,DeleteManagementModel>{}.obs;
  final deleteManagementFireStore = FirebaseFirestore.instance.collection(Const.deleteManagementCollection).withConverter<DeleteManagementModel>(
    fromFirestore: (snapshot, _) => DeleteManagementModel.fromJson(snapshot.data()!),
    toFirestore: (account, _) => account.toJson(),
  );

  DeleteManagementViewModel(){
    deleteManagementFireStore.snapshots().listen((event) {
      allDelete = Map<String,DeleteManagementModel>.fromEntries(event.docs.toList().map((i)=>MapEntry(i.id.toString(), i.data()))).obs;
      update();
    },);
  }

  doTheDelete(DeleteManagementModel deleteModel){
    FirebaseFirestore.instance.collection(deleteModel.collectionName).doc(deleteModel.affectedId).delete();
    deleteDeleteOperation(deleteModel);
  }

  addDeleteOperation(DeleteManagementModel deleteModel){
    deleteManagementFireStore.doc(deleteModel.id).set(deleteModel);
  }

  updateDeleteOperation(DeleteManagementModel deleteModel){
    deleteManagementFireStore.doc(deleteModel.id).update(deleteModel.toJson());
  }

  deleteDeleteOperation(DeleteManagementModel deleteModel){
    deleteManagementFireStore.doc(deleteModel.id).delete();
  }
}

addDeleteOperation({required String collectionName, required String affectedId , String? details}){
  Get.find<DeleteManagementViewModel>().addDeleteOperation(DeleteManagementModel(id: DateTime.now().millisecondsSinceEpoch.toString(), affectedId: affectedId, collectionName: collectionName,details: details));
}

