import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vision_dashboard/constants.dart';

import '../../../controller/delete_management_view_model.dart';
import '../../../controller/expenses_view_model.dart';
import '../../../models/Bus_Model.dart';
import '../../../utils/To_AR.dart';

class BusViewModel extends GetxController {
  final buseCollectionRef =
      FirebaseFirestore.instance.collection(busesCollection);
  final firebaseFirestore = FirebaseFirestore.instance;
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];

  Map<String, PlutoColumnType> data = {
    "الرقم التسلسلي": PlutoColumnType.text(),
    "رقم الحافلة": PlutoColumnType.text(),
    "اسم الحافلة": PlutoColumnType.text(),
    "النوع": PlutoColumnType.text(),
    "عدد الطلاب": PlutoColumnType.text(),
    "عدد الموظفين": PlutoColumnType.text(),
    "المصروف": PlutoColumnType.currency(
      locale: 'ar',
      symbol: 'AED',
      name: 'درهم',
      decimalDigits: 2,
    ),
    "Start Date".tr: PlutoColumnType.date(),
  };

  GlobalKey key = GlobalKey();

  BusViewModel() {
    getColumns();
    getAllBuse();
  }

  Map<String, BusModel> _busesMap = {};

  Map<String, BusModel> get busesMap => _busesMap;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;

  getAllBuse() async {
    listener = await buseCollectionRef.snapshots().listen((value) async {
      _busesMap.clear();

      key = GlobalKey();
      rows.clear();
      // await   Get.find<ExpensesViewModel>().getAllWithoutListenExpenses();
      for (var element in value.docs) {
        int total = 0;
        _busesMap[element.id] = BusModel.fromJson(element.data());

        for (var ex in BusModel.fromJson(element.data()).expense ?? []) {
          total += Get.find<ExpensesViewModel>().allExpenses[ex]!.total ?? 0;
        }
        rows.add(
          PlutoRow(
            cells: {
              data.keys.elementAt(0): PlutoCell(value: element.id),
              data.keys.elementAt(1):
                  PlutoCell(value: BusModel.fromJson(element.data()).number),
              data.keys.elementAt(2):
                  PlutoCell(value: BusModel.fromJson(element.data()).name),
              data.keys.elementAt(3):
                  PlutoCell(value: BusModel.fromJson(element.data()).type),
              data.keys.elementAt(4): PlutoCell(
                  value: BusModel.fromJson(element.data())
                      .students
                      ?.length
                      .toString()),
              data.keys.elementAt(5): PlutoCell(
                  value: BusModel.fromJson(element.data())
                      .employees
                      ?.length
                      .toString()),
              data.keys.elementAt(6): PlutoCell(value: total),
              data.keys.elementAt(7):
                  PlutoCell(value: BusModel.fromJson(element.data()).startDate),
            },
          ),
        );
      }
      print("buses :${_busesMap.values.length}");
      update();
    });
  }

  getAllWithoutListenBuse() async {
    await buseCollectionRef.get().then((value) async {
      for (var element in value.docs) {
        _busesMap[element.id] = BusModel.fromJson(element.data());
      }
      print("buses Without Listen:${_busesMap.values.length}");
      update();
    });
  }

  addBus(BusModel buseModel) {
    buseCollectionRef
        .doc(buseModel.busId)
        .set(buseModel.toJson(), SetOptions(merge: true));
    update();
  }

  updateBus(BusModel buseModel) async {
    await buseCollectionRef
        .doc(buseModel.busId)
        .set(buseModel.toJson(), SetOptions(merge: true));
    update();
  }

  deleteBus(String buseId) async {
    await addDeleteOperation(
        collectionName: busesCollection, affectedId: buseId);
    update();
  }

  getOldBuse(String value) async {
    await firebaseFirestore
        .collection(archiveCollection)
        .doc(value)
        .collection(busesCollection)
        .get()
        .then((value) {
      _busesMap.clear();
      for (var element in value.docs) {
        _busesMap[element.id] = BusModel.fromJson(element.data());
      }
      print("buses :${_busesMap.values.length}");
      update();
    });
  }

  addExpenses(String busId, String expensesId) {
    buseCollectionRef.doc(busId).set({
      "expense": FieldValue.arrayUnion([expensesId])
    }, SetOptions(merge: true));
  }

  getOldData(String value) {
    FirebaseFirestore.instance
        .collection(archiveCollection)
        .doc(value)
        .collection(busesCollection)
        .get()
        .then(
      (value) {
        _busesMap.clear();
        for (var element in value.docs) {
          _busesMap[element.id] = BusModel.fromJson(element.data());
        }
        print("buses :${_busesMap.values.length}");
        listener.cancel();
        update();
      },
    );
  }

  getColumns() {
    columns.clear();
    columns.addAll(toAR(data));
  }
}
