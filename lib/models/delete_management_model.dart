class DeleteManagementModel {
  late String id , affectedId , collectionName ;

  String? details,relatedId ;
  List<String>?relatedList;
  DeleteManagementModel({required this.id,required this.affectedId,required this.collectionName,this.details,this.relatedId,this.relatedList});
  DeleteManagementModel.fromJson(json){
    id = json['id'] ??'';
    affectedId = json['affectedId']??'' ;
    details = json['details'] ??'';
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
   if(relatedId!=null)   "relatedId":relatedId,
      if(relatedList!=null)   "relatedList":relatedList,
    };
  }
}