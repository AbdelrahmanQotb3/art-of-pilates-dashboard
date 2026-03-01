import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/services/data/model/service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/services_response.dart';
import 'package:pilates_dashboard/app/features/staff_tab/data/model/staff_members_response.dart';

part 'sessions_response.g.dart';

@JsonSerializable()
class SessionsResponse {
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Sessions')
  final List<SessionItem>? sessions;

  SessionsResponse({this.message, this.sessions});

  factory SessionsResponse.fromJson(Map<String, dynamic> json) => _$SessionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SessionsResponseToJson(this);
}

@JsonSerializable()
class SessionItem {
  final String? id;
  final String? startTime;
  final String? endTime;
  final String? serviceId;
  final String? staffMemberId;
  final ServiceItem? service;
  final StaffMember? staffMember;

  SessionItem({
    this.id,
    this.startTime,
    this.endTime,
    this.serviceId,
    this.staffMemberId,
    this.service,
    this.staffMember,
  });

  factory SessionItem.fromJson(Map<String, dynamic> json) => _$SessionItemFromJson(json);
  Map<String, dynamic> toJson() => _$SessionItemToJson(this);
}