import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/delete_session_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/sessions_response.dart';
import 'package:pilates_dashboard/app/features/sessions/data/model/update_session_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'sessions_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SessionsApiClient {

  @factoryMethod
  factory SessionsApiClient(Dio dio) = _SessionsApiClient;

  @GET(EndPoints.getSessions)
  Future<SessionsResponse> getSessions();

  @PATCH(EndPoints.updateSession)
  Future<UpdateSessionResponse> updateSession(
    @Query("id") String id,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(EndPoints.deleteSession)
  Future<DeleteSessionResponse> deleteSession(
    @Query("id") String id,
  );
}