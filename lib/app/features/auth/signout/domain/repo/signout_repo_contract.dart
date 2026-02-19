import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signout/domain/model/signout_model.dart';

abstract class SignoutRepoContract {

  Future<BaseResponse<SignoutModel>> signout();
}