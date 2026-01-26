import 'package:json_annotation/json_annotation.dart';

part 'pricing_plan_response.g.dart';

@JsonSerializable()
class PricingPlanResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Plan')
  final PricingPlan? plan;

  PricingPlanResponse({this.message, this.plan});

  factory PricingPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$PricingPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PricingPlanResponseToJson(this);
}

@JsonSerializable()
class PricingPlan {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'planName')
  final String? planName;

  @JsonKey(name: 'pricing')
  final double? pricing; // تم التغيير لـ double لضمان دقة العملات

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

  PricingPlan({
    this.id,
    this.planName,
    this.pricing,
    this.duration,
    this.status,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  PricingPlan copyWith({
    int? id,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return PricingPlan(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      pricing: pricing ?? this.pricing,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory PricingPlan.fromJson(Map<String, dynamic> json) =>
      _$PricingPlanFromJson(json);

  Map<String, dynamic> toJson() => _$PricingPlanToJson(this);
}
