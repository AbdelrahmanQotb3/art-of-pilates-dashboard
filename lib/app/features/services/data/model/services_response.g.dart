// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesResponse _$ServicesResponseFromJson(Map<String, dynamic> json) =>
    ServicesResponse(
      message: json['Message'] as String?,
      services: (json['Services'] as List<dynamic>?)
          ?.map((e) => Services.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesResponseToJson(ServicesResponse instance) =>
    <String, dynamic>{
      'Message': instance.message,
      'Services': instance.services,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) => Services(
  id: json['id'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  name: json['name'] as String?,
  imageUrl: json['imageUrl'] as String?,
  price: (json['price'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  isVisible: json['isVisible'] as bool?,
  index: (json['index'] as num?)?.toInt(),
  bufferTime: json['bufferTime'] as String?,
  paymentType: json['paymentType'] as String?,
  paymentPriceType: json['paymentPriceType'] as String?,
  paymentAmount: (json['paymentAmount'] as num?)?.toDouble(),
  paymentPref: json['paymentPref'] as String?,
  location: json['location'] as String?,
  bookingPolicy: json['bookingPolicy'] as String?,
  sessions: (json['sessions'] as List<dynamic>?)
      ?.map((e) => SessionItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'name': instance.name,
  'imageUrl': instance.imageUrl,
  'price': instance.price,
  'currency': instance.currency,
  'isVisible': instance.isVisible,
  'index': instance.index,
  'bufferTime': instance.bufferTime,
  'paymentType': instance.paymentType,
  'paymentPriceType': instance.paymentPriceType,
  'paymentAmount': instance.paymentAmount,
  'paymentPref': instance.paymentPref,
  'location': instance.location,
  'bookingPolicy': instance.bookingPolicy,
  'sessions': instance.sessions,
};
