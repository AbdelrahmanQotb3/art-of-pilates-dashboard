import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/profile/data/model/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class UserApiClient {
  @factoryMethod
  factory UserApiClient(Dio dio) = _UserApiClient;

  @GET(EndPoints.currentUser)
  Future<UserResponse> getUser(@Query("id") int id);

  @PATCH(EndPoints.editProfile)
  Future<UserResponse> updateUser(@Query("id") int id , @Body() Map<String, dynamic> body);
}