import 'package:json_annotation/json_annotation.dart';

part 'update_contact_response.g.dart';

@JsonSerializable()
class UpdateContactResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'User')
  final User? user;

  UpdateContactResponse({this.message, this.user});

  factory UpdateContactResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateContactResponseToJson(this);
}

@JsonSerializable()
class User {
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
  final dynamic labels;

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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
