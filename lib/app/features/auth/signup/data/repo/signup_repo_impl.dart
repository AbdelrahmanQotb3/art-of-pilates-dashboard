import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signup/data/data_source/signup_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/auth/signup/data/model/signup_resposne.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/model/signup_model.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/repo/signup_repo_contract.dart';

@Injectable(as: SignupRepoContract)
class SignupRepoImpl implements SignupRepoContract {
  final SignupDataSourceContract _signupDataSourceContract;

  SignupRepoImpl(this._signupDataSourceContract);
  @override
  Future<BaseResponse<SignupModel>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  ) async {
    BaseResponse<SignupResponse> response = await _signupDataSourceContract
        .signup(email, password, firstName, lastName, phoneNumber, role);
    switch (response) {
      case SuccessResponse<SignupResponse>():
        SignupModel signupModel = SignupModel(
          message: response.data.message,
          id: response.data.user!.id,
          email: response.data.user!.email,
          firstName: response.data.user!.firstName,
          lastName: response.data.user!.lastName,
          role: response.data.user!.role,
        );
        return SuccessResponse<SignupModel>(data: signupModel);
      case ErrorResponse<SignupResponse>():
        return ErrorResponse<SignupModel>(error: response.error);
    }
  }
}
