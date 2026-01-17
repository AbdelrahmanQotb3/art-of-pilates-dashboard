import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/auth/signup/data/model/signup_resposne.dart';
import 'package:retrofit/retrofit.dart';

part 'signup_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SignupApiClient {
  @factoryMethod
  factory SignupApiClient(Dio dio) = _SignupApiClient;

  @POST(EndPoints.signup)
  Future<SignupResponse> signup(@Body() Map<String, dynamic> body);
}
