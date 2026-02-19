import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/auth/signout/data/model/signout_response.dart';
import 'package:retrofit/retrofit.dart';

part 'signout_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SignoutApiClient {
  @factoryMethod
  factory SignoutApiClient(Dio dio) => _SignoutApiClient(dio);

  @POST(EndPoints.signout)
  Future<SignoutResponse> signout();
}