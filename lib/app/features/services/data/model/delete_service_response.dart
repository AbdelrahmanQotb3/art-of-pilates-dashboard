import 'package:json_annotation/json_annotation.dart';

part 'delete_service_response.g.dart';

@JsonSerializable()
class DeleteServiceResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Status')
  final String? status;

  DeleteServiceResponse({this.message, this.status});

  // Factory for creating a new instance from a map
  factory DeleteServiceResponse.fromJson(Map<String, dynamic> json) => 
      _$DeleteServiceResponseFromJson(json);

  // Method for converting the instance back to a map
  Map<String, dynamic> toJson() => _$DeleteServiceResponseToJson(this);
}