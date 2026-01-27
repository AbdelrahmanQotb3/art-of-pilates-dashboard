// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_members_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffMemebersResponse _$StaffMemebersResponseFromJson(
  Map<String, dynamic> json,
) => StaffMemebersResponse(
  message: json['Message'] as String?,
  staffMembers: (json['StaffMembers'] as List<dynamic>?)
      ?.map((e) => StaffMember.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StaffMemebersResponseToJson(
  StaffMemebersResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'StaffMembers': instance.staffMembers,
};

StaffMember _$StaffMemberFromJson(Map<String, dynamic> json) => StaffMember(
  id: json['id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  profilePic: json['profilePic'] as String?,
  visibility: json['visibility'] as bool?,
  index: (json['index'] as num?)?.toInt(),
  customAction: json['customAction'] as String?,
);

Map<String, dynamic> _$StaffMemberToJson(StaffMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'profilePic': instance.profilePic,
      'visibility': instance.visibility,
      'index': instance.index,
      'customAction': instance.customAction,
    };
