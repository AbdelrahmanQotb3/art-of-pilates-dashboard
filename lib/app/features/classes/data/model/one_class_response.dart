import 'package:json_annotation/json_annotation.dart';

part 'one_class_response.g.dart';

@JsonSerializable()
class OneClassResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Class')
  final SingleClass? classData;

  OneClassResponse({this.message, this.classData});

  factory OneClassResponse.fromJson(Map<String, dynamic> json) => 
      _$OneClassResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$OneClassResponseToJson(this);
}

@JsonSerializable()
class SingleClass {
  final String? id;
  final String? name;
  final String? tagLine;
  final String? description;
  final int? maxParticipations;
  final double? price;
  final String? location;

  SingleClass({
    this.id,
    this.name,
    this.tagLine,
    this.description,
    this.maxParticipations,
    this.price,
    this.location,
  });

  factory SingleClass.fromJson(Map<String, dynamic> json) => 
      _$SingleClassFromJson(json);
      
  Map<String, dynamic> toJson() => _$SingleClassToJson(this);
}