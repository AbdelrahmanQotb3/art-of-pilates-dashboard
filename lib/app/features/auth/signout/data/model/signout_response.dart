import 'package:json_annotation/json_annotation.dart';
part 'signout_response.g.dart';

@JsonSerializable()
class SignoutResponse {
  final String? message;
  @JsonKey(name: 'Status')
  final String? status;

  SignoutResponse({this.message, this.status});
  factory SignoutResponse.fromJson(Map<String, dynamic> json) =>
      _$SignoutResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SignoutResponseToJson(this);
}
