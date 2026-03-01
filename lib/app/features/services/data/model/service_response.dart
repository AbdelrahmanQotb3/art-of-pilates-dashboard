import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';

part 'service_response.g.dart'; 

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'Service')
  Service? service;

  ServiceResponse({this.message, this.service});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => _$ServiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class Service {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  dynamic? imageUrl;
  int? price;
  String? currency;
  bool? isVisible;
  int? index;
  List<SessionItem>? sessions;

  Service({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.imageUrl,
    this.price,
    this.currency,
    this.isVisible,
    this.index,
    this.sessions,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
