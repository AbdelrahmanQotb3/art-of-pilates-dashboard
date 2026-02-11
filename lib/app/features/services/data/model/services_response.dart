import 'package:json_annotation/json_annotation.dart';

part 'services_response.g.dart';

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'Services')
  List<Service>? services;

  ServicesResponse({this.message, this.services});

  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class Service {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? imageUrl;
  int? price;
  String? currency;
  bool? isVisible;
  int? index;

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
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
