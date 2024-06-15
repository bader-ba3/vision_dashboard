import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/expenses_model.dart';
import '../utils/const.dart';

class ExpensesViewModel extends GetxController{
  RxMap<String,ExpensesModel> allExpenses = <String,ExpensesModel>{}.obs;
  final expensesFireStore = FirebaseFirestore.instance.collection(Const.expensesCollection).withConverter<ExpensesModel>(
    fromFirestore: (snapshot, _) => ExpensesModel.fromJson(snapshot.data()!),
    toFirestore: (data, _) => data.toJson(),
  );

  ExpensesViewModel(){
    expensesFireStore.snapshots().listen((event) {
      allExpenses = Map<String,ExpensesModel>.fromEntries(event.docs.toList().map((i)=>MapEntry(i.id.toString(), i.data()))).obs;
      update();
    },);
  }

  addExpenses(ExpensesModel expensesModel){
    expensesFireStore.doc(expensesModel.id).set(expensesModel);
  }

  updateExpenses(ExpensesModel expensesModel){
    expensesFireStore.doc(expensesModel.id).update(expensesModel.toJson());
  }

  deleteExpenses(ExpensesModel expensesModel){
    expensesFireStore.doc(expensesModel.id).delete();
  }
}