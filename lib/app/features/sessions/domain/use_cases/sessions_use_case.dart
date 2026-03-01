import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/delete_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/update_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/repo/sessions_repo_contract.dart';

@injectable
class SessionsUseCase {
  final SessionsRepoContract _sessionsRepo;
  SessionsUseCase(this._sessionsRepo);

  Future<BaseResponse<SessionsModel>> getSessions() async {
    return await _sessionsRepo.getSessions();
  }

  Future<BaseResponse<DeleteSessionModel>> deleteSession(String id) async {
    return await _sessionsRepo.deleteSession(id);
  }

  Future<BaseResponse<UpdateSessionModel>> updateSession(String id, DateTime? startTime , DateTime? endTime, String? serviceId, String? staffMemberId) async {
    return await _sessionsRepo.updateSession(id, startTime, endTime, serviceId, staffMemberId);
  }
}