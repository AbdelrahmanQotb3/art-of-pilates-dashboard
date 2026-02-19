import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/auth/signout/api/api_client/signout_api_client.dart';
import 'package:pilates_dashboard/app/features/auth/signout/data/data_source/signout_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/auth/signout/data/model/signout_response.dart';

@Injectable(as: SignoutDataSourceContract)
class SignoutDataSourceImpl implements SignoutDataSourceContract {
  SignoutApiClient signoutApiClient;
  SignoutDataSourceImpl(this.signoutApiClient);
  @override
  Future<BaseResponse<SignoutResponse>> signout() async {
    try{
      final response = await signoutApiClient.signout();
      return SuccessResponse<SignoutResponse>(data: response);
    }on Exception catch(e){
      return ErrorResponse<SignoutResponse>(error: e);
    }
  }
}