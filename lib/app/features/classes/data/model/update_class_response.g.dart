// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_class_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateClassResponse _$UpdateClassResponseFromJson(Map<String, dynamic> json) =>
    UpdateClassResponse(
      message: json['Message'] as String?,
      classData: json['Class'] == null
          ? null
          : SingleUpadteClass.fromJson(json['Class'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateClassResponseToJson(
  UpdateClassResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'Class': instance.classData,
};

SingleUpadteClass _$SingleUpadteClassFromJson(Map<String, dynamic> json) =>
    SingleUpadteClass(
      id: json['id'] as String?,
      name: json['name'] as String?,
      tagLine: json['tagLine'] as String?,
      description: json['description'] as String?,
      maxParticipations: (json['maxParticipations'] as num?)?.toInt(),
      price: json['price'] as num?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$SingleUpadteClassToJson(SingleUpadteClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagLine': instance.tagLine,
      'description': instance.description,
      'maxParticipations': instance.maxParticipations,
      'price': instance.price,
      'location': instance.location,
    };
