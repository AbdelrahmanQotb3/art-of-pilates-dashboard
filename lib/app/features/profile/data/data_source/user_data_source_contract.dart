import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/profile/data/model/user_response.dart';

abstract class UserDataSourceContract {
  Future<BaseResponse<UserResponse>> getUser(int id);
  Future<BaseResponse<UserResponse>> updateUser(int id, String? firstName , String? lastName , String? email);
}
