import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';
part 'services_response.g.dart';

@JsonSerializable()
class ServicesResponse {
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Services')
  final List<ServiceItem>? services;

  ServicesResponse({this.message, this.services});

  factory ServicesResponse.fromJson(Map<String, dynamic> json) => _$ServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesResponseToJson(this);
}

@JsonSerializable()
class ServiceItem {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final String? name;
  final String? imageUrl;
  final int? price;
  final String? currency;
  final bool? isVisible;
  final int? index;
  final List<SessionItem>? sessions;

  ServiceItem({
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

  factory ServiceItem.fromJson(Map<String, dynamic> json) => _$ServiceItemFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceItemToJson(this);
}
