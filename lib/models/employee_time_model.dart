class EmployeeTimeModel{
  String? dayName ;
  DateTime? startDate , endDate ;
  int? totalDate;
  bool? isDayEnd;
  EmployeeTimeModel({required this.dayName,required this.startDate,required this.endDate,required this.totalDate,required this.isDayEnd,});
  EmployeeTimeModel.fromJson(json){
    dayName = json['dayName'];
    startDate = json['startDate']==null ?null :json['startDate'].toDate();
    endDate = json['endDate']==null ?null :json['endDate'].toDate();
    totalDate = json['totalDate'];
    isDayEnd = json['isDayEnd'];
  }
  toJson(){
    return {
      "dayName":dayName,
      "startDate":startDate,
      'endDate':endDate,
      "totalDate":totalDate,
      'isDayEnd':isDayEnd,
    };
  }
}