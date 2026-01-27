// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_staff_member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStaffMemberResponse _$UpdateStaffMemberResponseFromJson(
  Map<String, dynamic> json,
) => UpdateStaffMemberResponse(
  message: json['Message'] as String,
  staffMember: StaffMember.fromJson(
    json['StaffMember'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$UpdateStaffMemberResponseToJson(
  UpdateStaffMemberResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'StaffMember': instance.staffMember,
};
