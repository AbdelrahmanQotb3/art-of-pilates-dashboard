import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';
part 'add_staff_member_response.g.dart';

@JsonSerializable()
class AddStaffMemberResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'StaffMember')
  final StaffMember? staffMember;

  AddStaffMemberResponse({this.message, this.staffMember});

  factory AddStaffMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$AddStaffMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddStaffMemberResponseToJson(this);
}
