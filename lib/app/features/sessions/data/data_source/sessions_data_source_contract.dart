import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/delete_session_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/update_session_response.dart';

abstract class SessionsDataSourceContract {
  Future<BaseResponse<SessionsResponse>> getSessions();
  Future<BaseResponse<DeleteSessionResponse>> deleteSession(String id);
  Future<BaseResponse<UpdateSessionResponse>> updateSession(String id, DateTime? startTime , DateTime? endTime, String? serviceId, String? staffMemberId);
}