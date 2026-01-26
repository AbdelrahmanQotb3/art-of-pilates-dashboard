// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingPlanResponse _$PricingPlanResponseFromJson(Map<String, dynamic> json) =>
    PricingPlanResponse(
      message: json['Message'] as String?,
      plan: json['Plan'] == null
          ? null
          : PricingPlan.fromJson(json['Plan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PricingPlanResponseToJson(
  PricingPlanResponse instance,
) => <String, dynamic>{'Message': instance.message, 'Plan': instance.plan};

PricingPlan _$PricingPlanFromJson(Map<String, dynamic> json) => PricingPlan(
  id: (json['id'] as num?)?.toInt(),
  planName: json['planName'] as String?,
  pricing: (json['pricing'] as num?)?.toDouble(),
  duration: json['duration'] as String?,
  status: json['status'] as String?,
  imageUrl: json['imageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$PricingPlanToJson(PricingPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'planName': instance.planName,
      'pricing': instance.pricing,
      'duration': instance.duration,
      'status': instance.status,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
