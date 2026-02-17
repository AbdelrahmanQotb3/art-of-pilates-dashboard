import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/profile/domain/model/user_model.dart';
import 'package:pilates_dashboard/app/features/profile/domain/repo/user_repo_contract.dart';

@injectable
class UserUseCase {

  UserRepoContract userRepoContract;

  UserUseCase(this.userRepoContract);

  Future<BaseResponse<UserModel>> getUser(int id) => userRepoContract.getUser(id);
  Future<BaseResponse<UserModel>> updateUser(int id, String? firstName, String? lastName, String? email) => userRepoContract.updateUser(id, firstName, lastName, email);
}