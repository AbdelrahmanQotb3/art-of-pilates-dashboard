import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'Message')
  final String? message;
  
  @JsonKey(name: 'User')
  final User? user;

  UserResponse({this.message, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) => 
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class User {
  final int? id;
  final String? email;
  final String? createdAt;
  final String? updatedAt;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? profileImage;

  User({
    this.id,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.firstName,
    this.lastName,
    this.profileImage
  });

  factory User.fromJson(Map<String, dynamic> json) => 
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}