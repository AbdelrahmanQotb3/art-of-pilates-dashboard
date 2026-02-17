import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/profile/domain/model/user_model.dart';

abstract class UserRepoContract {

  Future<BaseResponse<UserModel>> getUser(int id);
  Future<BaseResponse<UserModel>> updateUser(int id, String? firstName , String? lastName , String? email);
}