import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/sessions/api/api_client/sessions_api_client.dart';
import 'package:pilates_dashboard/app/features/sessions/data/data_source/sessions_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/delete_session_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/update_session_response.dart';

@Injectable(as: SessionsDataSourceContract)
class SessionsDataSourceImpl implements SessionsDataSourceContract{
  final SessionsApiClient apiClient;
  SessionsDataSourceImpl(this.apiClient);

  @override
  Future<BaseResponse<DeleteSessionResponse>> deleteSession(String id) async {
    try{
      final response = await apiClient.deleteSession(id);
      return SuccessResponse<DeleteSessionResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<DeleteSessionResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<SessionsResponse>> getSessions() async {
    try{
      final response = await  apiClient.getSessions();
      return SuccessResponse<SessionsResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<SessionsResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<UpdateSessionResponse>> updateSession(String id, DateTime? startTime, DateTime? endTime, String? serviceId, String? staffMemberId) async{
    try{
      final body = {
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "serviceId": serviceId,
        "staffMemberId": staffMemberId,
      };
      
      final response = await apiClient.updateSession(id, body);
      return SuccessResponse<UpdateSessionResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<UpdateSessionResponse>(error: e);
    }
  }
}