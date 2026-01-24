// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteContactResponse _$DeleteContactResponseFromJson(
  Map<String, dynamic> json,
) => DeleteContactResponse(
  message: json['Message'] as String?,
  status: json['Status'] as String?,
);

Map<String, dynamic> _$DeleteContactResponseToJson(
  DeleteContactResponse instance,
) => <String, dynamic>{'Message': instance.message, 'Status': instance.status};
