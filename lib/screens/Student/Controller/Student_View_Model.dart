import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';

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

  ExamViewModel examViewModel=Get.find<ExamViewModel>();

  addExamToStudent(List<String> students,String examId){
    students.forEach((element)async {
      await  studentCollectionRef
          .doc(element)
          .set({"stdExam":FieldValue.arrayUnion([examId])}, SetOptions(merge: true));

    },);

  }
  getAllStudent()async {
    await   studentCollectionRef.snapshots().listen((value) {
      _studentMap.clear();

      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());


      }
      print("Student :${_studentMap.keys.length}");

      examViewModel. getGrade( _studentMap);
      update();
    });

  }
  getAllStudentWithOutListen()async {
    await   studentCollectionRef.get().then((value) {
      _studentMap.clear();

      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());


      }
      print("Student :${_studentMap.keys.length}");

      examViewModel. getGrade( _studentMap);
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