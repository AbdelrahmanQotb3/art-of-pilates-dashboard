import 'package:json_annotation/json_annotation.dart';

part 'create_contact_response.g.dart';

@JsonSerializable()
class CreateContactResponse {
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Contact')
  final Contact? contact;

  CreateContactResponse({this.message, this.contact});

  factory CreateContactResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateContactResponseToJson(this);
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
  final dynamic labels;
  final dynamic source;
  final String? language;
  final String? createdAt;
  final String? lastActivityDate;
  final dynamic lastActivity;

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
