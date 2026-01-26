import 'package:json_annotation/json_annotation.dart';

part 'delete_pricing_plan_response.g.dart';

@JsonSerializable()
class DeletePricingPlanResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Status')
  final String? status;

  DeletePricingPlanResponse({this.message, this.status});

  factory DeletePricingPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePricingPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePricingPlanResponseToJson(this);
}
