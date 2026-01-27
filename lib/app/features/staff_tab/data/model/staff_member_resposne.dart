import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';

part 'staff_member_resposne.g.dart';

@JsonSerializable()
class StaffMemberResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'StaffMember')
  final StaffMember? staffMember;

  StaffMemberResponse({this.message, this.staffMember});

  factory StaffMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StaffMemberResponseToJson(this);
}
