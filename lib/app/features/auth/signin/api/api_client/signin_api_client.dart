import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/auth/signin/data/model/signin_response.dart';
import 'package:retrofit/retrofit.dart';

part 'signin_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class SigninApiClient {
  @factoryMethod
  factory SigninApiClient(Dio dio) = _SigninApiClient;

  @POST(EndPoints.signin)
  Future<SigninResponse> signin(@Body() Map<String, dynamic> body);
}
