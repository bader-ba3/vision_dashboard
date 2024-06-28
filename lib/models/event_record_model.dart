class EventRecordModel {
  late String body , type , date , color ;
  bool? enableEdite;
  EventRecordModel({required this.body,required this.type,required this.date,required this.color,this.enableEdite});
  EventRecordModel.fromJson(json){
    body = json ['body'];
    type = json ['type'];
    date = json ['date'];
    color = json ['color'];
  }
  toJson(){
    return {
      "body":body,
      "type":type,
      "date":date,
      "color":color,
    };
  }
}