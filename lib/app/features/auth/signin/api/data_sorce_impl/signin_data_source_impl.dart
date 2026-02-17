import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signin/api/api_client/signin_api_client.dart';
import 'package:pilates_dashboard/app/features/auth/signin/data/data_source/signin_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/auth/signin/data/model/signin_response.dart';

@Injectable(as: SigninDataSourceContract)
class SigninDataSourceImpl implements SigninDataSourceContract {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final SigninApiClient _signinApiClient;
  SigninDataSourceImpl(this._signinApiClient);
  @override
  Future<BaseResponse<SigninResponse>> signIn(
    String email,
    String password,
  ) async {
    try {
      final response = await _signinApiClient.signin({
        "email": email,
        "password": password,
      });
      String token = response.token!;
      int id = response.user!.id!;
      await secureStorage.write(key: 'token', value: token);
      await secureStorage.write(key: 'id',value: id.toString());

      return SuccessResponse<SigninResponse>(data: response);
    } on Exception catch (error) {
      // Log the actual error for debugging
      return ErrorResponse<SigninResponse>(
        error: Exception('Login failed: ${error.toString()}'),
      );
    }
  }
}
