import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/Installment_model.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';

import '../../../constants.dart';
import '../../../controller/delete_management_view_model.dart';

class StudentViewModel extends GetxController {
  final studentCollectionRef =
      FirebaseFirestore.instance.collection(studentCollection);

  StudentViewModel() {
    getAllStudent();
  }

  Map<String, StudentModel> _studentMap = {};

  Map<String, StudentModel> get studentMap => _studentMap;

  ExamViewModel examViewModel = Get.find<ExamViewModel>();

  addExamToStudent(List<String> students, String examId) {
    students.forEach(
      (element) async {
        await studentCollectionRef.doc(element).set({
          "stdExam": FieldValue.arrayUnion([examId])
        }, SetOptions(merge: true));
      },
    );
  }

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  getAllStudent() async {
    listener = await studentCollectionRef.snapshots().listen((value) {
      _studentMap.clear();

      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());
      }
      print("Student :${_studentMap.keys.length}");

      examViewModel.getGrade(_studentMap);
      update();
    });
  }

  getAllStudentWithOutListen() async {
    await studentCollectionRef.get().then((value) {
      _studentMap.clear();

      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());
      }
      print("Student :${_studentMap.keys.length}");

      examViewModel.getGrade(_studentMap);
      update();
    });
  }

  addStudent(StudentModel studentModel) async {
    await studentCollectionRef
        .doc(studentModel.studentID)
        .set(studentModel.toJson());
    if (studentModel.parentId != null)
      await FirebaseFirestore.instance
          .collection(parentsCollection)
          .doc(studentModel.parentId)
          .set({
        "children": FieldValue.arrayUnion([studentModel.studentID])
      }, SetOptions(merge: true));

    update();
  }

  updateStudent(StudentModel studentModel) async {
    await studentCollectionRef
        .doc(studentModel.studentID)
        .set(studentModel.toJson());

    update();
  }

  double getAllTotalPay() {
    double total = 0.0;
    _studentMap.values.forEach(
      (element) {
        total += element.totalPayment!;
      },
    );
    return total;
  }

  double getAllReceivePay() {
    double total = 0;
    _studentMap.values.forEach(
      (element) {
        element.installmentRecords!.values.forEach(
          (element0) {
            if (element0.isPay == true) {
              total += int.parse(element0.installmentCost!);
            }
          },
        );
      },
    );
    return total;
  }

  deleteStudent(String studentId) async {
    await addDeleteOperation(
        collectionName: studentCollection, affectedId: studentId);
    update();
  }

  getOldData(String value) async {
    await FirebaseFirestore.instance
        .collection(archiveCollection)
        .doc(value)
        .collection(studentCollection)
        .get()
        .then((value) {
      _studentMap.clear();

      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());
      }
      print("Student :${_studentMap.keys.length}");

      examViewModel.getGrade(_studentMap);
      listener.cancel();
      update();
    });
  }

  int getAllNunReceivePay() {
    int total = 0;
    _studentMap.values.forEach(
      (element) {
        element.installmentRecords!.values.forEach(
          (element0) {
            if (element0.isPay != true) {
              total += int.parse(element0.installmentCost!);
            }
          },
        );
      },
    );
    return total;
  }

  int getAllNunReceivePayThisMonth() {
    int total = 0;
    _studentMap.values.forEach(
      (element) {
        element.installmentRecords!.values.forEach(
          (element0) {
            if (int.parse(element0.installmentDate!) <= DateTime.now().month &&
                element0.isPay != true) {
              total += int.parse(element0.installmentCost!);
            }
          },
        );
      },
    );
    return total;
  }

  double getAllReceiveMaxPay() {
    double total = 0;
    _studentMap.values.forEach(
      (element) {
        element.installmentRecords!.values.forEach(
          (element0) {
            if (element0.isPay == true) {
              if (int.parse(element0.installmentCost!) > total)
                total = int.parse(element0.installmentCost!) * 1.0;
            }
          },
        );
      },
    );
    return total + 50000;
  }

  double getAllReceivePayAtMonth(String month) {
    double total = 0;
    _studentMap.values.forEach(
      (element) {
        element.installmentRecords!.values.forEach(
          (element0) {
            if (element0.installmentDate! == month && element0.isPay == true) {
              total += int.parse(element0.installmentCost!);
            }
          },
        );
      },
    );
    return total;
  }

  setInstallmentPay(String installmentId, String studentId, bool isPay) {
    Map<String, InstallmentModel>? installmentRecords =
        _studentMap[studentId]!.installmentRecords;
    installmentRecords![installmentId]!.isPay = isPay;
    installmentRecords[installmentId]!.payTime = DateTime.now().toString();
    studentCollectionRef.doc(studentId).set(
        StudentModel(installmentRecords: installmentRecords).toJson(),
        SetOptions(merge: true));
  }

  bool chekaIfHaveLateInstallment(String parentId) {
    bool isLate = false;
    _studentMap.values
        .where(
      (element) => element.parentId == parentId,
    )
        .forEach(
      (element) {
        element.installmentRecords!.values.forEach(
          (element0) {
            if (int.parse(element0.installmentDate!) <= DateTime.now().month &&
                element0.isPay != true) {
              isLate = true;
            }
          },
        );
      },
    );
    return isLate;
  }
}
