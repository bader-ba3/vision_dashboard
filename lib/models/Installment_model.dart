class InstallmentModel {
  String? installmentId;
  String? installmentCost;
  String? installmentDate;
  String? payTime;
  bool? isPay;

  InstallmentModel({
    this.installmentId,
    this.installmentCost,
    this.installmentDate,
    this.isPay,
    this.payTime,
  });

  // fromJson method
  factory InstallmentModel.fromJson(Map<String, dynamic> json) {
    return InstallmentModel(
      installmentId: json['installmentId'] ?? '',
      installmentCost: json['installmentCost'] ?? '',
      installmentDate: json['installmentDate'] ?? '',
      isPay: json['isPay'] ?? false,
      payTime: json['payTime'] ?? '',
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'installmentId': installmentId,
      'installmentCost': installmentCost,
      'installmentDate': installmentDate,
      'isPay': isPay,
      'payTime': payTime,
    };
  }

  // toString method
  @override
  String toString() {
    return 'InstallmentModel{installmentId: $installmentId, installmentCost: $installmentCost, installmentDate: $installmentDate , isPay: $isPay}';
  }
}
