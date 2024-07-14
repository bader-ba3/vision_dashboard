class ClassModel {
  String? className;
  String? classId;
  List<String>? classStudent;


  ClassModel({this.className, this.classId, this.classStudent,});


  ClassModel.fromJson(Map<String, dynamic> json) {
    className = json['className']??'';
    classId = json['classId']??'';
    classStudent =List<String>.from(json['classStudent']??[]) ;
  }


  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'classId': classId,
      'classStudent': classStudent,
    };
  }

  // toString: A method that returns a string representation of an instance
  @override
  String toString() {
    return 'ClassModel(className: $className, classId: $classId, classStudent: $classStudent, )';
  }
}