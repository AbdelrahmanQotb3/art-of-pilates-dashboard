import 'package:json_annotation/json_annotation.dart';

part 'staff_members_response.g.dart';

@JsonSerializable()
class StaffMemebersResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'StaffMembers')
  final List<StaffMember>? staffMembers;

  StaffMemebersResponse({this.message, this.staffMembers});

  factory StaffMemebersResponse.fromJson(Map<String, dynamic> json) =>
      _$StaffMemebersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StaffMemebersResponseToJson(this);
}

@JsonSerializable()
class StaffMember {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'profilePic')
  final String? profilePic;

  @JsonKey(name: 'visibility')
  final bool? visibility;

  @JsonKey(name: 'index')
  final int? index;

  @JsonKey(name: 'customAction')
  final String? customAction;

  StaffMember({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.visibility,
    this.index,
    this.customAction,
  });

  factory StaffMember.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberFromJson(json);

  Map<String, dynamic> toJson() => _$StaffMemberToJson(this);
}
