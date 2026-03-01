import 'package:json_annotation/json_annotation.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';

part 'update_session_response.g.dart'; 

@JsonSerializable()
class UpdateSessionResponse {
  @JsonKey(name: 'Message')
  String? message;
  @JsonKey(name: 'Session')
  SessionItem? session;

  UpdateSessionResponse({this.message, this.session});

  factory UpdateSessionResponse.fromJson(Map<String, dynamic> json) => _$UpdateSessionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateSessionResponseToJson(this);
}
