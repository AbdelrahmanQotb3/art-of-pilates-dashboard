import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signup/data/model/signup_resposne.dart';

abstract class SignupDataSourceContract {
  Future<BaseResponse<SignupResponse>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  );
}
