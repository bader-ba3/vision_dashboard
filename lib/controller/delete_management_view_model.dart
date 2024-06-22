

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../models/delete_management_model.dart';
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
    update();
  }

  undoTheDelete(DeleteManagementModel deleteModel){
    deleteDeleteOperation(deleteModel);
    update();
  }

  addDeleteOperation(DeleteManagementModel deleteModel){
    deleteManagementFireStore.doc(deleteModel.id).set(deleteModel);
    update();
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
  Get.find<DeleteManagementViewModel>().update();
}

bool checkIfPendingDelete({ required String affectedId}){
 return Get.find<DeleteManagementViewModel>().allDelete.values.where((element) => element.affectedId == affectedId,).length >0;
}

