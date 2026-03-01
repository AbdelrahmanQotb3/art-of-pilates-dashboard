// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_session_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSessionResponse _$UpdateSessionResponseFromJson(
  Map<String, dynamic> json,
) => UpdateSessionResponse(
  message: json['Message'] as String?,
  session: json['Session'] == null
      ? null
      : SessionItem.fromJson(json['Session'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateSessionResponseToJson(
  UpdateSessionResponse instance,
) => <String, dynamic>{
  'Message': instance.message,
  'Session': instance.session,
};
