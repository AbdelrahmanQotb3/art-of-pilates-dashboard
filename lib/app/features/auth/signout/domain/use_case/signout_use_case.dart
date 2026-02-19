import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/model/signout_model.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/repo/signout_repo_contract.dart';

@injectable
class SignoutUseCase {
  SignoutRepoContract _signoutRepoContract;
  SignoutUseCase(this._signoutRepoContract);
  Future<BaseResponse<SignoutModel>> signout() => _signoutRepoContract.signout();
}