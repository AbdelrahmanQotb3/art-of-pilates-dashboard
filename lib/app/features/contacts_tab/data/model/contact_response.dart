import 'package:json_annotation/json_annotation.dart';

part 'contact_response.g.dart';

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Contact')
  final Contact? contact;

  ContactResponse({this.message, this.contact});

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class Contact {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? addressCity;
  final String? addressCountry;
  final String? labels;
  final String? source;
  final String? language;
  final String? createdAt;
  final String? lastActivityDate;
  final String? lastActivity;

  Contact({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.addressCity,
    this.addressCountry,
    this.labels,
    this.source,
    this.language,
    this.createdAt,
    this.lastActivityDate,
    this.lastActivity,
  });

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);
  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
