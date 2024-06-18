import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Parent_Model.dart';

class ParentsViewModel{

  final parentCollectionRef=FirebaseFirestore.instance.collection(parentsCollection);


  addParent(ParentModel parentModel){

    parentCollectionRef.add(parentModel.toJson());
  }
  updateParent(ParentModel parentModel){

    parentCollectionRef.doc(parentModel.id);
  }


}