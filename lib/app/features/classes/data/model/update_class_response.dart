import 'package:json_annotation/json_annotation.dart';

part 'update_class_response.g.dart';

@JsonSerializable()
class UpdateClassResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Class')
  final SingleUpadteClass? classData;

  UpdateClassResponse({this.message, this.classData});

  factory UpdateClassResponse.fromJson(Map<String, dynamic> json) => 
      _$UpdateClassResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$UpdateClassResponseToJson(this);
}

@JsonSerializable()
class SingleUpadteClass {
  final String? id;
  final String? name;
  final String? tagLine;
  final String? description;
  final int? maxParticipations;
  
  // Use num? instead of double? to accept both 2000 (int) and 2000.0 (double)
  final num? price; 
  
  final String? location;

  SingleUpadteClass({
    this.id,
    this.name,
    this.tagLine,
    this.description,
    this.maxParticipations,
    this.price,
    this.location,
  });

  factory SingleUpadteClass.fromJson(Map<String, dynamic> json) => 
      _$SingleUpadteClassFromJson(json);
      
  Map<String, dynamic> toJson() => _$SingleUpadteClassToJson(this);
}