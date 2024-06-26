import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/constants.dart';
import 'package:vision_dashboard/models/Salary_Model.dart';
import 'package:vision_dashboard/screens/Salary/Salary_view.dart';

import '../../../controller/delete_management_view_model.dart';

class SalaryViewModel extends GetxController{
  final salaryCollectionRef =
  FirebaseFirestore.instance.collection(salaryCollection);


  SalaryViewModel(){
    getAllSalary();
  }
  Map<String, SalaryModel> _salaryMap = {};

  Map<String, SalaryModel> get salaryMap => _salaryMap;

  getAllSalary()async {
    await   salaryCollectionRef.snapshots().listen((value) {
      _salaryMap.clear();
      for (var element in value.docs) {
        _salaryMap[element.id] = SalaryModel.fromJson(element.data());
      }
      print("salaries :${_salaryMap.keys.length}");

      _salaryMap.forEach((key, value) {
        print("key $key-------------$value ");
      },);
      update();
    });
  }

  addSalary(SalaryModel salaryModel) {
    salaryCollectionRef.doc(salaryModel.salaryId).set(salaryModel.toJson());
    update();
  }

  updateSalary(SalaryModel salaryModel) async{
    await  salaryCollectionRef
        .doc(salaryModel.salaryId)
        .set(salaryModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteSalary(String salaryId)async {
    await addDeleteOperation(
        collectionName: salaryCollection,
        affectedId: salaryId);
    update();
  }
}