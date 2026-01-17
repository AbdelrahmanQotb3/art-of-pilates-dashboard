import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signin/data/data_source/signin_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/auth/signin/data/model/signin_response.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/model/signin_model.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/repo/signin_repo_contract.dart';

@Injectable(as: SigninRepoContract)
class SigninRepoImpl implements SigninRepoContract {
  final SigninDataSourceContract _signinDataSourceContract;

  SigninRepoImpl(this._signinDataSourceContract);
  @override
  Future<BaseResponse<SigninModel>> signIn(
    String email,
    String password,
  ) async {
    BaseResponse<SigninResponse> response = await _signinDataSourceContract
        .signIn(email, password);
    switch (response) {
      case SuccessResponse<SigninResponse>():
        SigninModel signinModel = SigninModel(
          token: response.data.token,
          message: response.data.message,
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
          id: response.data.user!.id,
        );
        return SuccessResponse<SigninModel>(data: signinModel);
      case ErrorResponse<SigninResponse>():
        return ErrorResponse<SigninModel>(error: response.error);
    }
  }
}
