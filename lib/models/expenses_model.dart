import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vision_dashboard/controller/delete_management_view_model.dart';

class ExpensesModel {
  String? id, title, userId, date;

  int? total;

  String? body, busId;

  List<dynamic>? images = [];

  ExpensesModel(
      {this.id,
      this.title,
      this.userId,
      this.total,
      this.busId,
      this.body,
      this.images,
      this.date});

  ExpensesModel.fromJson(json) {
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    total = json['total'];
    body = json['body'];
    busId = json['busId'];
    date = json['date'] ?? DateTime.now().toString();
    images = json['images'] == null
        ? []
        : json['images'].map((e) => e.toString()).toList();
  }

  String? affectedId() {
    return id;
  }

  String? affectedKey({String? type}) {
    return "id";
  }

  bool checkIfDelete(String id) {
    return checkIfPendingDelete(affectedId: id);
  }







  toJson() {
    return {
      "id": id,
      "title": title,
      "userId": userId,
      "total": total,
      "body": body,
      if (busId != null) "busId": busId,
      "images": images,
      "date": date,
    };
  }
}
