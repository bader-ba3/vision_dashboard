import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';
import 'package:vision_dashboard/models/Parent_Model.dart';

class ParentsViewModel extends GetxController {
  final parentCollectionRef =
      FirebaseFirestore.instance.collection(parentsCollection);


  ParentsViewModel(){
    getAllParent();
  }
  Map<String, ParentModel> _parentMap = {};

  Map<String, ParentModel> get parentMap => _parentMap;

  getAllParent()async {
    await   parentCollectionRef.get().then((value) {
      for (var element in value.docs) {
        _parentMap[element.id] = ParentModel.fromJson(element.data());
      }
      print("Parents :${_parentMap.keys.length}");

    });
    update();
  }

  addParent(ParentModel parentModel) {
    parentCollectionRef.doc(parentModel.id).set(parentModel.toJson());
    update();
  }

  updateParent(ParentModel parentModel) async{
    await  parentCollectionRef
        .doc(parentModel.id)
        .set(parentModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteParent(String parentId)async {
   await addDeleteOperation(
        collectionName: parentsCollection,
        affectedId: parentId);
    update();
  }
}
