// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  message: json['Message'] as String?,
  user: json['User'] == null
      ? null
      : User.fromJson(json['User'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'User': instance.user};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  email: json['email'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  role: json['role'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  profileImage: json['profileImage'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'role': instance.role,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profileImage': instance.profileImage,
};
