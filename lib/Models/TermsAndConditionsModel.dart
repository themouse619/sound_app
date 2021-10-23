class TermsAndConditionsModel {
  String? success;
  List<TermsAndConditions>? TermsCondition;

  TermsAndConditionsModel({
    this.success,
    this.TermsCondition,
  });

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermsAndConditionsModel(
      success: json['success'] as String,
      TermsCondition: json['TermsCondition']
          .map<TermsAndConditions>((item) => TermsAndConditions.fromJson(item))
          .toList(),
    );
  }
}

class TermsAndConditions {
  int? id;
  String? terms_data;

  TermsAndConditions({
    this.id,
    this.terms_data,
  });

  factory TermsAndConditions.fromJson(Map<String, dynamic> json) {
    return TermsAndConditions(
      id: json['id'] as int,
      terms_data: json['terms_data'] as String,
    );
  }
}
