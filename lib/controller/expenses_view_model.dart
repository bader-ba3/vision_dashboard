import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vision_dashboard/models/expenses_model.dart';
import '../constants.dart';
import '../utils/const.dart';

class ExpensesViewModel extends GetxController{
  RxMap<String,ExpensesModel> allExpenses = <String,ExpensesModel>{}.obs;
  final expensesFireStore = FirebaseFirestore.instance.collection(Const.expensesCollection).withConverter<ExpensesModel>(
    fromFirestore: (snapshot, _) => ExpensesModel.fromJson(snapshot.data()!),
    toFirestore: (data, _) => data.toJson(),
  );

  ExpensesViewModel(){
    getAllExpenses();
  }
  late StreamSubscription<QuerySnapshot<ExpensesModel>> listener;
  getAllExpenses(){
    listener=  expensesFireStore.snapshots().listen((event) {
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

   getOldData(String value) async{

    await FirebaseFirestore.instance.collection(archiveCollection).doc(value).collection(Const.expensesCollection).get().then((value) {
      allExpenses = Map<String,ExpensesModel>.fromEntries(value.docs.toList().map((i)=>MapEntry(i.id.toString(),ExpensesModel.fromJson(i.data()) ))).obs;
      listener.cancel();
      update();
    },);
  }
}