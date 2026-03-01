import 'package:json_annotation/json_annotation.dart';

part 'delete_session_response.g.dart'; 

@JsonSerializable()
class DeleteSessionResponse {
  @JsonKey(name: 'Message')
  String? message;

  DeleteSessionResponse({this.message});

  factory DeleteSessionResponse.fromJson(Map<String, dynamic> json) => 
      _$DeleteSessionResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$DeleteSessionResponseToJson(this);
}