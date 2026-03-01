// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionsResponse _$SessionsResponseFromJson(Map<String, dynamic> json) =>
    SessionsResponse(
      message: json['Message'] as String?,
      sessions: (json['Sessions'] as List<dynamic>?)
          ?.map((e) => SessionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionsResponseToJson(SessionsResponse instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Sessions': instance.sessions,
    };

SessionItem _$SessionItemFromJson(Map<String, dynamic> json) => SessionItem(
  id: json['id'] as String?,
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  serviceId: json['serviceId'] as String?,
  staffMemberId: json['staffMemberId'] as String?,
  service: json['service'] == null
      ? null
      : ServiceItem.fromJson(json['service'] as Map<String, dynamic>),
  staffMember: json['staffMember'] == null
      ? null
      : StaffMember.fromJson(json['staffMember'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SessionItemToJson(SessionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'serviceId': instance.serviceId,
      'staffMemberId': instance.staffMemberId,
      'service': instance.service,
      'staffMember': instance.staffMember,
    };
