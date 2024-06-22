import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Exam_model.dart';

import '../../../controller/delete_management_view_model.dart';

class ExamViewModel extends GetxController{

  final examCollectionRef =
  FirebaseFirestore.instance.collection(examsCollection);
  ParentsViewModel(){
    getAllExam();
  }
  Map<String, ExamModel> _examMap = {};

  Map<String, ExamModel> get examMap => _examMap;

  getAllExam()async {
    await   examCollectionRef.snapshots().listen((value) {
      _examMap.clear();
      for (var element in value.docs) {
        _examMap[element.id] = ExamModel.fromJson(element.data());
      }
      print("Parents :${_examMap.keys.length}");
      update();
    });
  }

  addParent(ExamModel examModel) {
    examCollectionRef.doc(examModel.id).set(examModel.toJson());
    update();
  }

  updateParent(ExamModel examModel) async{
    await  examCollectionRef
        .doc(examModel.id)
        .set(examModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteParent(String examId)async {
    await addDeleteOperation(
        collectionName: examsCollection,
        affectedId: examId);
    update();
  }
}