import 'package:json_annotation/json_annotation.dart';
part 'signin_response.g.dart';

@JsonSerializable()
class SigninResponse {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'user')
  final User? user;

  SigninResponse({this.message, this.token, this.user});

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'firstName')
  final String? firstName;

  @JsonKey(name: 'lastName')
  final String? lastName;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'role')
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
