import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/services/data/model/service_response.dart';

part 'add_service_response.g.dart';

@JsonSerializable()
class AddServiceResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Service')
  final Service? service;

  AddServiceResponse({this.message, this.service});

  factory AddServiceResponse.fromJson(Map<String, dynamic> json) => 
      _$AddServiceResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$AddServiceResponseToJson(this);
}
