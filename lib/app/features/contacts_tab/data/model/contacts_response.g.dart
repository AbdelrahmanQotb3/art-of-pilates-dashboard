// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      message: json['Message'] as String?,
      contacts: (json['Contacts'] as List<dynamic>?)
          ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Contacts': instance.contacts,
    };

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
