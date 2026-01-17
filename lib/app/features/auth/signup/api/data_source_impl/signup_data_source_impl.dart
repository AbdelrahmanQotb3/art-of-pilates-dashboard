import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signup/api/api_client/signup_api_client.dart';
import 'package:pilates_dashboard/app/features/auth/signup/data/data_source/signup_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/auth/signup/data/model/signup_resposne.dart';

@Injectable(as: SignupDataSourceContract)
class SignupDataSourceImpl implements SignupDataSourceContract {
  final SignupApiClient _signupApiClient;

  SignupDataSourceImpl(this._signupApiClient);
  @override
  Future<BaseResponse<SignupResponse>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String phoneNumber,
    String role,
  ) async {
    try {
      final response = await _signupApiClient.signup({
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "role": role,
      });
      return SuccessResponse<SignupResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<SignupResponse>(error: e);
    }
  }
}
