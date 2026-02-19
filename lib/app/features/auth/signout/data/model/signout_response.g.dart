// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignoutResponse _$SignoutResponseFromJson(Map<String, dynamic> json) =>
    SignoutResponse(
      message: json['message'] as String?,
      status: json['Status'] as String?,
    );

Map<String, dynamic> _$SignoutResponseToJson(SignoutResponse instance) =>
    <String, dynamic>{'message': instance.message, 'Status': instance.status};
