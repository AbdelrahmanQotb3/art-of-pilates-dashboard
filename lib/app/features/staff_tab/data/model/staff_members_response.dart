import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';

part 'staff_members_response.g.dart';

@JsonSerializable()
class StaffMembersResponse {
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'StaffMembers')
  List<StaffMember>? staffMembers;

  StaffMembersResponse({this.message, this.staffMembers});

  factory StaffMembersResponse.fromJson(Map<String, dynamic> json) =>
      _$StaffMembersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StaffMembersResponseToJson(this);
}

@JsonSerializable()
class StaffMember {
  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic? owner;
  String? name;
  dynamic? description;
  String? email;
  String? phone;
  String? customAction;
  dynamic? pageUrl;
  dynamic? profilePic;
  String? resourceId;
  bool? visibility;
  int? index;
  List<SessionItem>? sessions;

  StaffMember({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.name,
    this.description,
    this.email,
    this.phone,
    this.customAction,
    this.pageUrl,
    this.profilePic,
    this.resourceId,
    this.visibility,
    this.index,
    this.sessions,
  });

  factory StaffMember.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberFromJson(json);
  Map<String, dynamic> toJson() => _$StaffMemberToJson(this);
}
