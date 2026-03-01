// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddServiceResponse _$AddServiceResponseFromJson(Map<String, dynamic> json) =>
    AddServiceResponse(
      message: json['Message'] as String?,
      service: json['Service'] == null
          ? null
          : Service.fromJson(json['Service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddServiceResponseToJson(AddServiceResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Service': instance.service};
