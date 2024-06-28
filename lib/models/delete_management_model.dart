class DeleteManagementModel {
  late String id , affectedId , collectionName ;
  bool? enableEdite;
  String? details;
  DeleteManagementModel({required this.id,required this.affectedId,required this.collectionName,this.details,this.enableEdite});
  DeleteManagementModel.fromJson(json){
    id = json['id'] ;
    affectedId = json['affectedId'] ;
    details = json['details'] ;
    collectionName = json['collectionName'] ;
  }

  toJson(){
    return {
      "id":id,
      "details":details,
      "affectedId":affectedId,
      "collectionName":collectionName,
    };
  }
}