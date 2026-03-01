// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_members_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffMembersResponse _$StaffMembersResponseFromJson(
  Map<String, dynamic> json,
) => StaffMembersResponse(
  message: json['Message'] as String?,
  staffMembers: (json['StaffMembers'] as List<dynamic>?)
      ?.map((e) => StaffMember.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StaffMembersResponseToJson(
  StaffMembersResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'StaffMembers': instance.staffMembers,
};

StaffMember _$StaffMemberFromJson(Map<String, dynamic> json) => StaffMember(
  id: json['id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  owner: json['owner'],
  name: json['name'] as String?,
  description: json['description'],
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  customAction: json['customAction'] as String?,
  pageUrl: json['pageUrl'],
  profilePic: json['profilePic'],
  resourceId: json['resourceId'] as String?,
  visibility: json['visibility'] as bool?,
  index: (json['index'] as num?)?.toInt(),
  sessions: (json['sessions'] as List<dynamic>?)
      ?.map((e) => SessionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StaffMemberToJson(StaffMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'owner': instance.owner,
      'name': instance.name,
      'description': instance.description,
      'email': instance.email,
      'phone': instance.phone,
      'customAction': instance.customAction,
      'pageUrl': instance.pageUrl,
      'profilePic': instance.profilePic,
      'resourceId': instance.resourceId,
      'visibility': instance.visibility,
      'index': instance.index,
      'sessions': instance.sessions,
    };
