import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signin/domain/model/signin_model.dart';

abstract class SigninRepoContract {
  Future<BaseResponse<SigninModel>> signIn(String email, String password);
}
