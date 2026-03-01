// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesResponse _$ServicesResponseFromJson(Map<String, dynamic> json) =>
    ServicesResponse(
      message: json['Message'] as String?,
      services: (json['Services'] as List<dynamic>?)
          ?.map((e) => ServiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesResponseToJson(ServicesResponse instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Services': instance.services,
    };

ServiceItem _$ServiceItemFromJson(Map<String, dynamic> json) => ServiceItem(
  id: json['id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  name: json['name'] as String?,
  imageUrl: json['imageUrl'] as String?,
  price: (json['price'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  isVisible: json['isVisible'] as bool?,
  index: (json['index'] as num?)?.toInt(),
  sessions: (json['sessions'] as List<dynamic>?)
      ?.map((e) => SessionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ServiceItemToJson(ServiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'currency': instance.currency,
      'isVisible': instance.isVisible,
      'index': instance.index,
      'sessions': instance.sessions,
    };
