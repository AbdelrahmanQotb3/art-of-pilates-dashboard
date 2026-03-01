import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/data_source/sessions_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/delete_session_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/update_session_response.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/delete_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/update_session_model.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/repo/sessions_repo_contract.dart';

@Injectable(as: SessionsRepoContract)
class SessionsRepoImpl implements SessionsRepoContract {
  final SessionsDataSourceContract dataSource;
  SessionsRepoImpl(this.dataSource);
  @override
  Future<BaseResponse<DeleteSessionModel>> deleteSession(String id) async {
    final response = await dataSource.deleteSession(id);
    switch (response) {
      case SuccessResponse<DeleteSessionResponse>():  
        final model = DeleteSessionModel(message: response.data.message);
        return SuccessResponse<DeleteSessionModel>(data: model);
      case ErrorResponse<DeleteSessionResponse>():
        return ErrorResponse<DeleteSessionModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<SessionsModel>> getSessions() async {
    final response = await dataSource.getSessions();
    switch (response) {
      case SuccessResponse<SessionsResponse>():
        final model = SessionsModel(message: response.data.message, sessions: response.data.sessions?.map((s) {
          return SessionEntity(
            id: s.id,
            startTime: s.startTime,
            endTime: s.endTime,
            serviceId: s.serviceId,
            staffMemberId: s.staffMemberId,
            serviceName: s.service?.name,
            staffName: s.staffMember?.name,
          );
        }).toList() ?? []);
        return SuccessResponse<SessionsModel>(data: model);
      case ErrorResponse<SessionsResponse>():
        return ErrorResponse<SessionsModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<UpdateSessionModel>> updateSession(String id, DateTime? startTime, DateTime? endTime, String? serviceId, String? staffMemberId) async {
    final response = await dataSource.updateSession(id, startTime, endTime, serviceId, staffMemberId);
    switch (response) {
      case SuccessResponse<UpdateSessionResponse>():
        final model = UpdateSessionModel(
          message: response.data.message, 
          session: response.data.session != null ? SessionEntity(
            id: response.data.session!.id,
            startTime: response.data.session!.startTime,
            endTime: response.data.session!.endTime,
            serviceId: response.data.session!.serviceId,
            staffMemberId: response.data.session!.staffMemberId,
            serviceName: response.data.session!.service?.name,
            staffName: response.data.session!.staffMember?.name,
          ) : null
        );
        return SuccessResponse<UpdateSessionModel>(data: model);
      case ErrorResponse<UpdateSessionResponse>():
        return ErrorResponse<UpdateSessionModel>(error: response.error);
    }
  }
}