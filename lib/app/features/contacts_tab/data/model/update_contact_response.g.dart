// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateContactResponse _$UpdateContactResponseFromJson(
  Map<String, dynamic> json,
) => UpdateContactResponse(
  message: json['Message'] as String?,
  user: json['User'] == null
      ? null
      : User.fromJson(json['User'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateContactResponseToJson(
  UpdateContactResponse instance,
) => <String, dynamic>{'Message': instance.message, 'User': instance.user};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  addressCity: json['addressCity'] as String?,
  addressCountry: json['addressCountry'] as String?,
  labels: json['labels'],
  source: json['source'] as String?,
  language: json['language'] as String?,
  createdAt: json['createdAt'] as String?,
  lastActivityDate: json['lastActivityDate'] as String?,
  lastActivity: json['lastActivity'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'phone': instance.phone,
  'addressCity': instance.addressCity,
  'addressCountry': instance.addressCountry,
  'labels': instance.labels,
  'source': instance.source,
  'language': instance.language,
  'createdAt': instance.createdAt,
  'lastActivityDate': instance.lastActivityDate,
  'lastActivity': instance.lastActivity,
};
