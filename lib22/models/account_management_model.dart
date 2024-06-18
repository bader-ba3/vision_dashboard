class AccountManagementModel{
  late String id ,userName , password ,type;
  String? serialNFC;
  late bool isActive ;

  AccountManagementModel({required this.id,required this.userName,required this.password,required this.type,required this.serialNFC,required this.isActive});

  AccountManagementModel.fromJson(json){
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    type = json['type'];
    serialNFC = json['serialNFC'];
    isActive = json['isActive']??true;
  }

  toJson(){
    return {
    "id":id ,
    "userName":userName ,
    "password":password ,
    "type":type ,
    "serialNFC": serialNFC,
    "isActive": isActive,
    };
  }
}