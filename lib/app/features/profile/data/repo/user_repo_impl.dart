import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/profile/data/data_source/user_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/profile/data/model/user_response.dart';
import 'package:pilates_dashboard/app/features/profile/domain/model/user_model.dart';
import 'package:pilates_dashboard/app/features/profile/domain/repo/user_repo_contract.dart';

@Injectable(as: UserRepoContract)
class UserRepoImpl implements UserRepoContract {
  UserDataSourceContract userDataSourceContract;

  UserRepoImpl(this.userDataSourceContract);
  @override
  Future<BaseResponse<UserModel>> getUser(int id) async {
    final response = await  userDataSourceContract.getUser(id);
    switch (response) {
      case SuccessResponse<UserResponse>():
        final user = UserModel(
          id: response.data.user!.id!,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          email: response.data.user!.email,
          role: response.data.user!.role,
          profileImage: response.data.user!.profileImage
        );
        return SuccessResponse<UserModel>(data: user);
      case ErrorResponse<UserResponse>():
        return ErrorResponse<UserModel>(error: response.error);
    }
  }
  
  @override
  Future<BaseResponse<UserModel>> updateUser(int id, String? firstName, String? lastName, String? email) async {
    final response = await userDataSourceContract.updateUser(id, firstName, lastName, email);
    switch (response) {
      case SuccessResponse<UserResponse>():
        final user = UserModel(
          id: response.data.user!.id!,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          email: response.data.user!.email,
          role: response.data.user!.role,
          profileImage: response.data.user!.profileImage
        );
        return SuccessResponse<UserModel>(data: user);
      case ErrorResponse<UserResponse>():
        return ErrorResponse<UserModel>(error: response.error);
    }
  }
}