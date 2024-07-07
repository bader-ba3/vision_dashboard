import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Bus_Model.dart';
import 'package:vision_dashboard/models/Exam_model.dart';
import 'package:vision_dashboard/models/Parent_Model.dart';
import 'package:vision_dashboard/screens/Buses/Controller/Bus_View_Model.dart';
import 'package:vision_dashboard/screens/Student/Controller/Student_View_Model.dart';

import '../models/delete_management_model.dart';
import '../screens/Exams/controller/Exam_View_Model.dart';
import '../screens/Parents/Controller/Parents_View_Model.dart';

import '../utils/const.dart';


class DeleteManagementViewModel extends GetxController {


  ExamViewModel _examViewModel = Get.find<ExamViewModel>();

  ParentsViewModel _parentsViewModel = Get.find<ParentsViewModel>();

  BusViewModel _busViewModel = Get.find<BusViewModel>();
  RxMap<String, DeleteManagementModel> allDelete =
      <String, DeleteManagementModel>{}.obs;
  final deleteManagementFireStore = FirebaseFirestore.instance
      .collection(Const.deleteManagementCollection)
      .withConverter<DeleteManagementModel>(
        fromFirestore: (snapshot, _) =>
            DeleteManagementModel.fromJson(snapshot.data()!),
        toFirestore: (account, _) => account.toJson(),
      );

  DeleteManagementViewModel() {
    getAllDeleteModel();
  }
  late StreamSubscription<QuerySnapshot<DeleteManagementModel>> listener;

  getAllDeleteModel() {
    listener=   deleteManagementFireStore.snapshots().listen(
      (event) {
        allDelete = Map<String, DeleteManagementModel>.fromEntries(event.docs
            .toList()
            .map((i) => MapEntry(i.id.toString(), i.data()))).obs;
        update();
      },
    );
  }

  doTheDelete(DeleteManagementModel deleteModel) {
    if(deleteModel.collectionName!=installmentCollection)
    FirebaseFirestore.instance
        .collection(deleteModel.collectionName)
        .doc(deleteModel.affectedId)
        .delete();
    else
      Get.find<StudentViewModel>()
          .setInstallmentPay(
          deleteModel.affectedId,
          deleteModel.relatedId.toString(),
          false);
    deleteDeleteOperation(deleteModel,true);
    switch (deleteModel.collectionName) {
      case Const.expensesCollection:
        if (deleteModel.relatedId != null) {
          deleteExpenseFromBus(
              deleteModel.relatedId.toString(), deleteModel.affectedId);
        }
        break;
      case studentCollection:
        deleteStudentFromParentsAndExam(
            deleteModel.affectedId, deleteModel.relatedId!,deleteModel.relatedList??[]);
        break;
    }
    update();
  }
  deleteStudentFromParentsAndExam(String studentId, String relatedId,List<String> exams)async {
    for( var examId in exams)
      {
        Map<String,dynamic> marks=_examViewModel.examMap[examId]!.marks!;
        marks .remove(studentId);
        await    _examViewModel.updateExam(ExamModel(
            id: examId, marks: {}));

        await    _examViewModel.updateExam(ExamModel(
            id: examId, marks: marks));
      }
      _parentsViewModel.parentMap[relatedId]!.children!.remove(studentId);
    await    _parentsViewModel.updateParent(ParentModel(
          id: relatedId,
          children: _parentsViewModel.parentMap[relatedId]!.children!));

  }

  deleteExpenseFromBus(String busId, String expensesId) {
    _busViewModel.busesMap[busId]!.expense!.remove(expensesId);
    _busViewModel.updateBus(BusModel(
        busId: busId, expense: _busViewModel.busesMap[busId]!.expense!));
  }

  undoTheDelete(DeleteManagementModel deleteModel) {
    deleteDeleteOperation(deleteModel,false);
    update();
  }

  addDeleteOperation(DeleteManagementModel deleteModel) {

    deleteManagementFireStore.doc(deleteModel.id).set(deleteModel);
    update();
  }

  updateDeleteOperation(DeleteManagementModel deleteModel) {
    deleteManagementFireStore.doc(deleteModel.id).update(deleteModel.toJson());
  }

  deleteDeleteOperation(DeleteManagementModel deleteModel,bool isAccepted) {
    if(isAccepted)
      deleteManagementFireStore.doc(deleteModel.id).set(deleteModel..isAccepted=true);
    else
    deleteManagementFireStore.doc(deleteModel.id).set(deleteModel..isAccepted=false);
  }



  getOldData(String value) {
    FirebaseFirestore.instance
        .collection(archiveCollection)
        .doc(value)
        .collection(Const.deleteManagementCollection)
        .get()
        .then(
      (event) {
        allDelete = Map<String, DeleteManagementModel>.fromEntries(event.docs
                .toList()
                .map((i) => MapEntry(
                    i.id.toString(), DeleteManagementModel.fromJson(i.data()))))
            .obs;
      },
    );
    listener.cancel();
    update();
  }
}

addDeleteOperation(
    {required String collectionName,
    required String affectedId,
    String? details,
    String? relatedId,
    List<String>? relatedList,

    }) {
  Get.find<DeleteManagementViewModel>().addDeleteOperation(
      DeleteManagementModel(
          id: generateId("DEL"),
          affectedId: affectedId,
          collectionName: collectionName,
          details: details,
          relatedId: relatedId,
        relatedList: relatedList,
      ));
  Get.find<DeleteManagementViewModel>().update();
}

bool checkIfPendingDelete({required String affectedId}) {
  return Get.find<DeleteManagementViewModel>()
          .allDelete
          .values
          .where(
            (element) => element.affectedId == affectedId&&!(element.isAccepted != null&&element.isAccepted == false),
          )
          .length >
      0;
}

returnPendingDelete({required String affectedId}) {
  DeleteManagementViewModel controller = Get.find<DeleteManagementViewModel>();
  DeleteManagementModel deleteManagementModel =
      controller.allDelete.values.firstWhere(
    (element) => element.affectedId == affectedId,
  );
  controller.undoTheDelete(deleteManagementModel);
  controller.update();
}
