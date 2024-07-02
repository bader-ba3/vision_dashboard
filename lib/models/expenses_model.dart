class ExpensesModel {
  late String id , title ,userId ;
  late int total  ;

  String? body,busId ;
  List<dynamic>  images = [];
  ExpensesModel({required this.id ,required this.title ,required this.userId ,required this.total,this.busId ,required this.body ,required this.images });
  ExpensesModel.fromJson(json){
    id = json['id'];
    title = json['title'];
    userId = json['userId'];
    total = json['total'];
    body = json['body'];
    busId = json['busId'];
    images = json['images'] == null ? []:json['images'].map((e)=>e.toString()).toList();
  }
  toJson(){
    return {
      "id":id,
      "title":title,
      "userId":userId,
      "total":total,
      "body":body,
    if(busId!=null)  "busId":busId,
      "images":images,
    };
  }
}