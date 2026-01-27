import 'package:json_annotation/json_annotation.dart';

part 'delete_staff_memeber_response.g.dart';

@JsonSerializable()
class DeleteStaffMemberResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Status')
  final String? status;

  DeleteStaffMemberResponse({this.message, this.status});

  factory DeleteStaffMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteStaffMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteStaffMemberResponseToJson(this);
}
