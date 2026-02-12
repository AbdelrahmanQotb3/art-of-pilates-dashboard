import 'package:json_annotation/json_annotation.dart';

part 'get_classes_response.g.dart';

@JsonSerializable()
class GetClassesResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Classes')
  final List<ClassItem>? classes;

  GetClassesResponse({this.message, this.classes});

  factory GetClassesResponse.fromJson(Map<String, dynamic> json) => 
      _$GetClassesResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$GetClassesResponseToJson(this);
}

@JsonSerializable()
class ClassItem {
  final String? id;
  final String? name;
  final String? tagLine;
  final String? description;
  final int? maxParticipations;
  final double? price; // Changed to double for safety with API numbers
  final String? location;

  ClassItem({
    this.id,
    this.name,
    this.tagLine,
    this.description,
    this.maxParticipations,
    this.price,
    this.location,
  });

  factory ClassItem.fromJson(Map<String, dynamic> json) => 
      _$ClassItemFromJson(json);
      
  Map<String, dynamic> toJson() => _$ClassItemToJson(this);
}