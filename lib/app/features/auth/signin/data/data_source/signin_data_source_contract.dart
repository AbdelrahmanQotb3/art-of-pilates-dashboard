import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signin/data/model/signin_response.dart';

abstract class SigninDataSourceContract {
  Future<BaseResponse<SigninResponse>> signIn(String email, String password);
}
