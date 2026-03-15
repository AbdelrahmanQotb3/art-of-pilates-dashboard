// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponse _$ServiceResponseFromJson(Map<String, dynamic> json) =>
    ServiceResponse(
      message: json['Message'] as String?,
      service: json['Service'] == null
          ? null
          : Service.fromJson(json['Service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceResponseToJson(ServiceResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Service': instance.service};

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
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
  sessions: json['sessions'] as List<dynamic>?,
);

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
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
