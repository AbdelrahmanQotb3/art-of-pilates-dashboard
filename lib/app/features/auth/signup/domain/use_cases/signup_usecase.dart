import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/model/signup_model.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/repo/signup_repo_contract.dart';

@injectable
class SignupUseCase {
  final SignupRepoContract _signupRepoContract;

  SignupUseCase(this._signupRepoContract);

  Future<BaseResponse<SignupModel>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  ) async => await _signupRepoContract.signup(
    email,
    password,
    firstName,
    lastName,
    phoneNumber,
    role,
  );
}
