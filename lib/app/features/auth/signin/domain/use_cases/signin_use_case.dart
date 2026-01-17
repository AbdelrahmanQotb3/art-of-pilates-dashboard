import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/model/signin_model.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/repo/signin_repo_contract.dart';

@injectable
class SigninUseCase {
  final SigninRepoContract _signinRepoContract;

  SigninUseCase(this._signinRepoContract);

  Future<BaseResponse<SigninModel>> signin(
    String email,
    String password,
  ) async => await _signinRepoContract.signIn(email, password);
}
