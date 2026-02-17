import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/profile/api/api_client/user_api_client.dart';
import 'package:pilates_dashboard/app/features/profile/data/data_source/user_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/profile/data/model/user_response.dart';

@Injectable(as: UserDataSourceContract)
class UserDataSourceImpl implements UserDataSourceContract {
  UserApiClient userApiClient;

  UserDataSourceImpl(this.userApiClient);
  @override
  Future<BaseResponse<UserResponse>> getUser(int id)async  {
    try{
      final response = await userApiClient.getUser(id);
      return SuccessResponse<UserResponse>(data: response);
    } on Exception catch(e){
      return ErrorResponse<UserResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<UserResponse>> updateUser(int id, String? firstName , String? lastName , String? email)async  {
    try{
      final response = await userApiClient.updateUser(id, {"firstName":firstName,"lastName":lastName,"email":email});
      return SuccessResponse<UserResponse>(data: response);
    } on Exception catch(e){
      return ErrorResponse<UserResponse>(error: e);
    }
  }
}
