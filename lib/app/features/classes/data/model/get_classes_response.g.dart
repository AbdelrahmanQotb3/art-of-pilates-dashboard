// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_classes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClassesResponse _$GetClassesResponseFromJson(Map<String, dynamic> json) =>
    GetClassesResponse(
      message: json['Message'] as String?,
      classes: (json['Classes'] as List<dynamic>?)
          ?.map((e) => ClassItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetClassesResponseToJson(GetClassesResponse instance) =>
    <String, dynamic>{'Message': instance.message, 'Classes': instance.classes};

ClassItem _$ClassItemFromJson(Map<String, dynamic> json) => ClassItem(
  id: json['id'] as String?,
  name: json['name'] as String?,
  tagLine: json['tagLine'] as String?,
  description: json['description'] as String?,
  maxParticipations: (json['maxParticipations'] as num?)?.toInt(),
  price: (json['price'] as num?)?.toDouble(),
  location: json['location'] as String?,
);

Map<String, dynamic> _$ClassItemToJson(ClassItem instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'tagLine': instance.tagLine,
  'description': instance.description,
  'maxParticipations': instance.maxParticipations,
  'price': instance.price,
  'location': instance.location,
};
