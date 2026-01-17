import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signup/domain/model/signup_model.dart';

abstract class SignupRepoContract {
  Future<BaseResponse<SignupModel>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  );
}
