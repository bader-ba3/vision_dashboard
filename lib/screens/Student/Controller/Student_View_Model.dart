import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vision_dashboard/models/Installment_model.dart';
import 'package:vision_dashboard/models/Student_Model.dart';
import 'package:vision_dashboard/screens/Exams/controller/Exam_View_Model.dart';

import '../../../constants.dart';
import '../../../controller/Wait_management_view_model.dart';
import '../../../utils/To_AR.dart';
import '../../Buses/Controller/Bus_View_Model.dart';
import '../../Parents/Controller/Parents_View_Model.dart';

class StudentViewModel extends GetxController {
  final studentCollectionRef =
      FirebaseFirestore.instance.collection(studentCollection);
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];

  Map<String, PlutoColumnType> data = {
    "الرقم التسلسلي": PlutoColumnType.text(),
    "اسم الطالب": PlutoColumnType.text(),
    "رقم الطالب": PlutoColumnType.text(),
    "الجنس": PlutoColumnType.text(),
    "التولد": PlutoColumnType.text(),
    "الصف": PlutoColumnType.text(),
    "تاريخ البداية": PlutoColumnType.text(),
    "الحافلة": PlutoColumnType.text(),
    "ولي الأمر": PlutoColumnType.text(),
    "المعدل": PlutoColumnType.text(),
    "سجل الأحداث": PlutoColumnType.text(),
    "موافقة المدير": PlutoColumnType.text(),
  };
  GlobalKey key = GlobalKey();

  StudentViewModel() {
    getColumns();

    getAllStudent();
  }

  getColumns() {
    columns.clear();
    columns.addAll(toAR(data));
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
    listener = await studentCollectionRef.snapshots().listen((value) async {
      _studentMap.clear();

      for (var element in value.docs) {
        _studentMap[element.id] = StudentModel.fromJson(element.data());
      }
      await Get.find<BusViewModel>().getAllWithoutListenBuse();
      await examViewModel.getGrade(_studentMap);
      key = GlobalKey();
      rows.clear();
      _studentMap.forEach(
        (key, value) {
          rows.add(
            PlutoRow(
              cells: {
                data.keys.elementAt(0): PlutoCell(value: key),
                data.keys.elementAt(1): PlutoCell(value: value.studentName),
                data.keys.elementAt(2): PlutoCell(value: value.studentNumber),
                data.keys.elementAt(3): PlutoCell(value: value.gender),
                data.keys.elementAt(4): PlutoCell(value: value.StudentBirthDay),
                data.keys.elementAt(5): PlutoCell(value: value.stdClass),
                data.keys.elementAt(6): PlutoCell(value: value.startDate),
                data.keys.elementAt(7): PlutoCell(
                    value: Get.find<BusViewModel>().busesMap[value.bus]?.name ??
                        value.bus),
                data.keys.elementAt(8): PlutoCell(
                    value: Get.find<ParentsViewModel>()
                        .parentMap[value.parentId]!
                        .fullName),
                data.keys.elementAt(9): PlutoCell(value: value.grade),
                data.keys.elementAt(10):
                    PlutoCell(value: value.eventRecords?.length ?? "0"),
                data.keys.elementAt(11): PlutoCell(value: value.isAccepted),
              },
            ),
          );
        },
      );
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
        .set(studentModel.toJson(), SetOptions(merge: true));

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
    await addWaitOperation(
        type: waitingListTypes.delete,
        collectionName: studentCollection,
        affectedId: studentId);
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

  void removeClass(String studentId) {
    studentCollectionRef
        .doc(studentId)
        .set({"stdClass": null}, SetOptions(merge: true));
  }

  setBus(String s, List std) {
    for (var student in std)
      studentCollectionRef
          .doc(student)
          .set({"bus": s}, SetOptions(merge: true));
  }

  removeExam(String examId, List studentList) {
    for (var std in studentList) {
      _studentMap[std]!.stdExam!.removeWhere(
            (element) => element == examId,
          );
      studentCollectionRef.doc(std).set(
          {"stdExam":_studentMap[std]!.stdExam},
          SetOptions(merge: true));
    }
  }
}
