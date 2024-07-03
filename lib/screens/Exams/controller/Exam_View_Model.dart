import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:vision_dashboard/models/Student_Model.dart';

import '../../../controller/delete_management_view_model.dart';

class ExamViewModel extends GetxController {
  final examCollectionRef =
      FirebaseFirestore.instance.collection(examsCollection);

  ExamViewModel() {
    getAllExam();
  }

  Map<String, ExamModel> _examMap = {};

  Map<String, ExamModel> get examMap => _examMap;
  bool addMarks = false;

  changeExamScreen() {
    addMarks = !addMarks;
    update();
  }

  addMarkExam(Map marks, String examId) async {
    await examCollectionRef
        .doc(examId)
        .set({"marks": marks,"isDone":true}, SetOptions(merge: true));
    update();
  }
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  getAllExam() async {
    listener=   await examCollectionRef.snapshots().listen((value) async{
      _examMap.clear();
      for (var element in value.docs) {
        _examMap[element.id] = ExamModel.fromJson(element.data());
      }
      print("Exams :${_examMap.keys.length}");
      await getPassRate();
      update();
    });
  }getAllExamWithOutListen() async {
    await examCollectionRef.get().then((value)async {
      _examMap.clear();
      for (var element in value.docs) {
        _examMap[element.id] = ExamModel.fromJson(element.data());
      }
      print("Exams :${_examMap.keys.length}");
    await  getPassRate();
      update();
    });
  }

  addExam(ExamModel examModel) {
    examCollectionRef.doc(examModel.id).set(examModel.toJson());
    update();
  }

  updateExam(ExamModel examModel) async {
    await examCollectionRef
        .doc(examModel.id)
        .set(examModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteExam(String examId) async {
    await addDeleteOperation(
        collectionName: examsCollection, affectedId: examId);
    update();
  }

  getPassRate() {

    examMap.forEach(
      (key, value) {
        int numOfPass = 0;
        print(value.marks!.length);
        value.marks!.forEach(
          (_, value0) {
            double studentPercentage = double.parse(value0);
            int examMaxMark = int.parse(examMap[key]!.examMaxMark!);
            double studentMark = (studentPercentage * examMaxMark) / 100;
            int examPassMark = int.parse(examMap[key]!.examPassMark!);
            if (studentMark >= examPassMark) {
              numOfPass++;
            }
          },
        );

        examMap[key]!.passRate = (numOfPass / value.marks!.length) * 100;
      },
    );
  }

  getGrade(Map<String, StudentModel> studentMap)async {
  // await  getAllExamWithOutListen();
    studentMap.forEach((key, value) {
      for (var exam in value.stdExam!) {
        studentMap[key]!.grade = studentMap[key]!.grade! +
            double.parse(examMap[exam]?.marks?[key] ?? "0");
      }
      studentMap[key]!.grade =
          studentMap[key]!.grade! / studentMap[key]!.stdExam!.length;
    });
  }

   getOldData(String value) async{

    await FirebaseFirestore.instance.collection(archiveCollection).doc(value).collection(examsCollection).get().then((value) {
      _examMap.clear();
      for (var element in value.docs) {
        _examMap[element.id] = ExamModel.fromJson(element.data());
      }
      print("Exams :${_examMap.keys.length}");
      getPassRate();
      listener.cancel();
      update();
    });
  }
}
