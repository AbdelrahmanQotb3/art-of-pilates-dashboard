import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';

class UpdateSessionModel {
  String? message;
  SessionEntity? session;
  UpdateSessionModel({this.message, this.session});
}