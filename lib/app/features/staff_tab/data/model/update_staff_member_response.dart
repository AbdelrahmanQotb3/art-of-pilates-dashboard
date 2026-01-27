import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';

part 'update_staff_member_response.g.dart';

@JsonSerializable()
class UpdateStaffMemberResponse {
  @JsonKey(name: 'Message')
  final String message;

  @JsonKey(name: 'StaffMember')
  final StaffMember staffMember;

  UpdateStaffMemberResponse({required this.message, required this.staffMember});

  factory UpdateStaffMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateStaffMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStaffMemberResponseToJson(this);
}
