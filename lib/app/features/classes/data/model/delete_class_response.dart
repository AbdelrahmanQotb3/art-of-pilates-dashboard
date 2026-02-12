import 'package:json_annotation/json_annotation.dart';

part 'delete_class_response.g.dart';

@JsonSerializable()
class DeleteClassResponse {
  @JsonKey(name: 'Message')
  String? message;
  
  @JsonKey(name: 'Status')
  String? status;

  DeleteClassResponse({this.message, this.status});

  /// Factory constructor for creating a new instance from a map
  factory DeleteClassResponse.fromJson(Map<String, dynamic> json) => 
      _$DeleteClassResponseFromJson(json);

  /// Method to convert the instance into a map
  Map<String, dynamic> toJson() => _$DeleteClassResponseToJson(this);
}