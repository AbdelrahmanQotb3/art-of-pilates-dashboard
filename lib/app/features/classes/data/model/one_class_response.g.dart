// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_class_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneClassResponse _$OneClassResponseFromJson(Map<String, dynamic> json) =>
    OneClassResponse(
      message: json['Message'] as String?,
      classData: json['Class'] == null
          ? null
          : SingleClass.fromJson(json['Class'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OneClassResponseToJson(OneClassResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Class': instance.classData};

SingleClass _$SingleClassFromJson(Map<String, dynamic> json) => SingleClass(
  id: json['id'] as String?,
  name: json['name'] as String?,
  tagLine: json['tagLine'] as String?,
  description: json['description'] as String?,
  maxParticipations: (json['maxParticipations'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  location: json['location'] as String?,
);

Map<String, dynamic> _$SingleClassToJson(SingleClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagLine': instance.tagLine,
      'description': instance.description,
      'maxParticipations': instance.maxParticipations,
      'price': instance.price,
      'location': instance.location,
    };
