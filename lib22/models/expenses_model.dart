class ExpensesModel {
  late String id , title ,userId ;
  late int total  ;
  String? body ;
  List<dynamic>  images = [];
  ExpensesModel({required this.id ,required this.title ,required this.userId ,required this.total ,required this.body ,required this.images });
  ExpensesModel.fromJson(json){
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    total = json['total'];
    body = json['body'];
    images = json['images'] == null ? []:json['images'].map((e)=>e.toString()).toList();
  }
  toJson(){
    return {
      "id":id,
      "title":title,
      "userId":userId,
      "total":total,
      "body":body,
      "images":images,
    };
  }
}