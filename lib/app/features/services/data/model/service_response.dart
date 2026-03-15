import 'package:json_annotation/json_annotation.dart';
part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Service')
  final Service? service;

  ServiceResponse({this.message, this.service});

  factory ServiceResponse.fromJson(Map<String, dynamic> json) => _$ServiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}

@JsonSerializable()
class Service {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? imageUrl; 
  final int? price;
  final String? currency;
  final bool? isVisible;
  final int? index;
  final String? bufferTime;
  final String? paymentType;
  final String? paymentPriceType;
  final double? paymentAmount;
  final String? paymentPref;
  final String? location;
  final String? bookingPolicy;
  
  final List<dynamic>? sessions; 

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
    this.bufferTime,
    this.paymentType,
    this.paymentPriceType,
    this.paymentAmount,
    this.paymentPref,
    this.location,
    this.bookingPolicy,
    this.sessions,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}