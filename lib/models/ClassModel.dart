class ClassModel {
  String? className;
  String? classId;
  List<String>? classStudent;
  List<String>? classSection;


  ClassModel({this.className, this.classId, this.classStudent, this.classSection});


  ClassModel.fromJson(Map<String, dynamic> json) {
    className = json['className']??'';
    classId = json['classId']??'';
    classStudent =List<String>.from(json['classStudent']??[]) ;
    classSection = List<String>.from(json['classSection']??[]);
  }


  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'classId': classId,
      'classStudent': classStudent,
      'classSection': classSection,
    };
  }

  // toString: A method that returns a string representation of an instance
  @override
  String toString() {
    return 'ClassModel(className: $className, classId: $classId, classStudent: $classStudent, classSection: $classSection)';
  }
}