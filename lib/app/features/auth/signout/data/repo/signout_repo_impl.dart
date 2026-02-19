import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signout/data/data_source/signout_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/auth/signout/data/model/signout_response.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/model/signout_model.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/repo/signout_repo_contract.dart';

@Injectable(as: SignoutRepoContract)
class SignoutRepoImpl implements SignoutRepoContract {
  SignoutDataSourceContract _signoutDataSource;

  SignoutRepoImpl(this._signoutDataSource);
  @override
  Future<BaseResponse<SignoutModel>> signout() async {
    final response = await _signoutDataSource.signout();
    switch (response) {
      case SuccessResponse<SignoutResponse>():
        final model = SignoutModel(message: response.data.message, status: response.data.status);
        return SuccessResponse<SignoutModel>(data: model);
      case ErrorResponse<SignoutResponse>():
        return ErrorResponse<SignoutModel>(error: response.error);
    }
  }
}
