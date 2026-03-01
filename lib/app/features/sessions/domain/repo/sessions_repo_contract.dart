import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/delete_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/update_session_model.dart';

abstract class SessionsRepoContract {
  Future<BaseResponse<SessionsModel>> getSessions();
  Future<BaseResponse<DeleteSessionModel>> deleteSession(String id);
  Future<BaseResponse<UpdateSessionModel>> updateSession(String id, DateTime? startTime , DateTime? endTime, String? serviceId, String? staffMemberId);
}