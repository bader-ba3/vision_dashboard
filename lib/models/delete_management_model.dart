class DeleteManagementModel {
  late String id , affectedId , collectionName ;

  String? details,relatedId ;
  List<String>?relatedList;

  bool? isAccepted;
  DeleteManagementModel({required this.id,required this.affectedId,required this.collectionName,this.details,this.relatedId,this.relatedList,this.isAccepted});
  DeleteManagementModel.fromJson(json){
    id = json['id'] ??'';
    affectedId = json['affectedId']??'' ;
    details = json['details'] ??'لا يوجد';
    isAccepted = json['isAccepted'] ;
    collectionName = json['collectionName']??'' ;
    relatedId = json['relatedId'] ;
    relatedList =List.from( json['relatedList'] ??[]) ;
  }

  toJson(){
    return {
      "id":id,
      "details":details,
      "collectionName":collectionName,
      "affectedId":affectedId,
      "isAccepted":isAccepted,
   if(relatedId!=null)   "relatedId":relatedId,
      if(relatedList!=null)   "relatedList":relatedList,
    };
  }
}