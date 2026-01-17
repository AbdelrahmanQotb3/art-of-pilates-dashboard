import 'package:json_annotation/json_annotation.dart';

part 'signup_resposne.g.dart';

@JsonSerializable()
class SignupResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'User')
  final User? user;

  SignupResponse({this.message, this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class User {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? createdAt;
  final String? updatedAt;
  final String? role;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
