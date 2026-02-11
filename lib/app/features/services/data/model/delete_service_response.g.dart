// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteServiceResponse _$DeleteServiceResponseFromJson(
  Map<String, dynamic> json,
) => DeleteServiceResponse(
  message: json['Message'] as String?,
  status: json['Status'] as String?,
);

Map<String, dynamic> _$DeleteServiceResponseToJson(
  DeleteServiceResponse instance,
) => <String, dynamic>{'Message': instance.message, 'Status': instance.status};
