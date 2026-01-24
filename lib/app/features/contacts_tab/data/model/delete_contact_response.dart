import 'package:json_annotation/json_annotation.dart';

part 'delete_contact_response.g.dart';

@JsonSerializable()
class DeleteContactResponse {
  @JsonKey(name: 'Message')
  final String? message;

  @JsonKey(name: 'Status')
  final String? status;

  DeleteContactResponse({this.message, this.status});

  factory DeleteContactResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteContactResponseToJson(this);
}
