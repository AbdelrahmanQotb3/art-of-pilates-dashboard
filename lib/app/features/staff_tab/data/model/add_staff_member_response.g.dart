// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_staff_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddStaffMemberResponse _$AddStaffMemberResponseFromJson(
  Map<String, dynamic> json,
) => AddStaffMemberResponse(
  message: json['Message'] as String?,
  staffMember: json['StaffMember'] == null
      ? null
      : StaffMember.fromJson(json['StaffMember'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AddStaffMemberResponseToJson(
  AddStaffMemberResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'StaffMember': instance.staffMember,
};
