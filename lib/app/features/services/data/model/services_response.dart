import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';

part 'services_response.g.dart';

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'Services')
  final List<Services>? services;

  ServicesResponse({this.message, this.services});

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => _$ServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class Services {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'price')
  final int? price;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'isVisible')
  final bool? isVisible;
  @JsonKey(name: 'index')
  final int? index;
  @JsonKey(name: 'bufferTime')
  final String? bufferTime;
  @JsonKey(name: 'paymentType')
  final String? paymentType;
  @JsonKey(name: 'paymentPriceType')
  final String? paymentPriceType;
  @JsonKey(name: 'paymentAmount')
  final double? paymentAmount;
  @JsonKey(name: 'paymentPref')
  final String? paymentPref;
  @JsonKey(name: 'location')
  final String? location;
  @JsonKey(name: 'bookingPolicy')
  final String? bookingPolicy;
  @JsonKey(name: 'sessions')
  final List<SessionItem>? sessions;

  Services({
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

  factory Services.fromJson(Map<String, dynamic> json) => _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
