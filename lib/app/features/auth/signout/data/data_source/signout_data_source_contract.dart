import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signout/data/model/signout_response.dart';

abstract class SignoutDataSourceContract {

  Future<BaseResponse<SignoutResponse>> signout();
}