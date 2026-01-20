// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) =>
    ContactResponse(
      message: json['Message'] as String?,
      contact: json['Contact'] == null
          ? null
          : Contact.fromJson(json['Contact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactResponseToJson(ContactResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Contact': instance.contact};

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  addressCity: json['addressCity'] as String?,
  addressCountry: json['addressCountry'] as String?,
  labels: json['labels'] as String?,
  source: json['source'] as String?,
  language: json['language'] as String?,
  createdAt: json['createdAt'] as String?,
  lastActivityDate: json['lastActivityDate'] as String?,
  lastActivity: json['lastActivity'] as String?,
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
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
