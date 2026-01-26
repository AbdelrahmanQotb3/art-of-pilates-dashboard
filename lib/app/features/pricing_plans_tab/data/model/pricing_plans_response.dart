import 'package:json_annotation/json_annotation.dart';

part 'pricing_plans_response.g.dart';

@JsonSerializable()
class PricingPlansResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Plans')
  final List<Plan>? plans;

  PricingPlansResponse({this.message, this.plans});

  factory PricingPlansResponse.fromJson(Map<String, dynamic> json) =>
      _$PricingPlansResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PricingPlansResponseToJson(this);
}

@JsonSerializable()
class Plan {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'planName')
  final String? planName;

  @JsonKey(name: 'pricing')
  final double? pricing;

  @JsonKey(name: 'duration')
  final String? duration;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  Plan({
    this.id,
    this.planName,
    this.pricing,
    this.duration,
    this.status,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
