class SalaryModel{
  String? salaryId,employeeId,constSalary,dilaySalary,paySalary,signImage;

  SalaryModel({
    this.salaryId,
    this.employeeId,
    this.constSalary,
    this.dilaySalary,
    this.paySalary,
    this.signImage,

  });

  // fromJson method
  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      salaryId: json['salaryId'] ,
      employeeId: json['employeeId'] ,
      constSalary: json['constSalary'] ,
      dilaySalary: json['dilaySalary'] ,
      paySalary: json['paySalary'],
      signImage: json['signImage'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'salaryId': salaryId,
      'employeeId': employeeId,
      'constSalary': constSalary,
      'dilaySalary': dilaySalary,
      'paySalary': paySalary,
      'signImage': signImage,
    };
  }

  // toString method
  @override
  String toString() {
    return 'SalaryModel{salaryId: $salaryId, employeeId: $employeeId, constSalary: $constSalary, dilaySalary: $dilaySalary, paySalary: $paySalary}';
  }
}
