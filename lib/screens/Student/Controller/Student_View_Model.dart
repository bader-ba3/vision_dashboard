import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';

import '../../../constants.dart';
import '../../../controller/delete_management_view_model.dart';

class StudentViewModel extends GetxController{
  final studentCollectionRef =
  FirebaseFirestore.instance.collection(studentCollection);


  StudentViewModel(){
    getAllStudent();
  }
  Map<String, StudentModel> _studentMap = {};

  Map<String, StudentModel> get studentMap => _studentMap;

  getAllStudent()async {
    await   studentCollectionRef.snapshots().listen((value) {
      _studentMap.clear();
      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());
      }
      print("Student :${_studentMap.keys.length}");
      update();
    });
  }

  addStudent(StudentModel studentModel) {
    studentCollectionRef.doc(studentModel.studentID).set(studentModel.toJson());
    update();
  }

  updateStudent(StudentModel studentModel) async{
    await  studentCollectionRef
        .doc(studentModel.studentID)
        .set(studentModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteStudent(String studentId)async {
    await addDeleteOperation(
        collectionName: studentCollection,
        affectedId: studentId);
    update();
  }
}