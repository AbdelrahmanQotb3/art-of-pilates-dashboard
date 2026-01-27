// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_member_resposne.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffMemberResponse _$StaffMemberResponseFromJson(Map<String, dynamic> json) =>
    StaffMemberResponse(
      message: json['Message'] as String?,
      staffMember: json['StaffMember'] == null
          ? null
          : StaffMember.fromJson(json['StaffMember'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StaffMemberResponseToJson(
  StaffMemberResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'StaffMember': instance.staffMember,
};
