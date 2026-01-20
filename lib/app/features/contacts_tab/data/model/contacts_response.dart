import 'package:json_annotation/json_annotation.dart';

part 'contacts_response.g.dart';

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Contacts')
  final List<Contact>? contacts;

  ContactsResponse({this.message, this.contacts});

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class Contact {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'addressCity')
  final String? addressCity;

  @JsonKey(name: 'addressCountry')
  final String? addressCountry;

  @JsonKey(name: 'labels')
  final String? labels;

  @JsonKey(name: 'source')
  final String? source;

  @JsonKey(name: 'language')
  final String? language;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'lastActivityDate')
  final String? lastActivityDate;

  @JsonKey(name: 'lastActivity')
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
