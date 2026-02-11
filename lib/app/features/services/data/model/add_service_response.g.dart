// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddServiceResponse _$AddServiceResponseFromJson(Map<String, dynamic> json) =>
    AddServiceResponse(
      message: (json['Message'] ?? json['message']) as String?,
    service: (json['Service'] ?? json['service']) == null
        ? null
        : Service.fromJson((json['Service'] ?? json['service']) as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddServiceResponseToJson(AddServiceResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Service': instance.service};
