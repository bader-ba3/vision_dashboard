class StoreModel{
  String? id,subName,subQuantity;


  StoreModel({
    this.id,
    this.subName,
    this.subQuantity,

  });

  // fromJson method
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      subName: json['subName'],
      subQuantity: json['subQuantity'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subName': subName,
      'subQuantity': subQuantity,
    };
  }

}