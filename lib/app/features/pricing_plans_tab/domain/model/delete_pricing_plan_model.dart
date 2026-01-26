class DeletePricingPlanModel {
  String? message;
  String? status;

  DeletePricingPlanModel({this.message, this.status});

  DeletePricingPlanModel copyWith({String? message, String? status}) {
    return DeletePricingPlanModel(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }
}
