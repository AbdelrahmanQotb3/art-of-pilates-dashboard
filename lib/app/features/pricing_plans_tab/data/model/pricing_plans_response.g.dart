// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_plans_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingPlansResponse _$PricingPlansResponseFromJson(
  Map<String, dynamic> json,
) => PricingPlansResponse(
  message: json['Message'] as String?,
  plans: (json['Plans'] as List<dynamic>?)
      ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PricingPlansResponseToJson(
  PricingPlansResponse instance,
) => <String, dynamic>{'Message': instance.message, 'Plans': instance.plans};

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
  id: (json['id'] as num?)?.toInt(),
  planName: json['planName'] as String?,
  pricing: (json['pricing'] as num?)?.toDouble(),
  duration: json['duration'] as String?,
  status: json['status'] as String?,
  imageUrl: json['imageUrl'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
  'id': instance.id,
  'planName': instance.planName,
  'pricing': instance.pricing,
  'duration': instance.duration,
  'status': instance.status,
  'imageUrl': instance.imageUrl,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
