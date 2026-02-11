import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/services/data/model/add_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/delete_service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/service_response.dart';
import 'package:pilates_dashboard/app/features/services/data/model/services_response.dart';
import 'package:retrofit/retrofit.dart';

part 'services_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class ServicesApiClient {
  @factoryMethod
  factory ServicesApiClient(Dio dio) => _ServicesApiClient(dio);

  @GET(EndPoints.getServices)
  Future<ServicesResponse> getServices();

  @GET(EndPoints.getOneService)
  Future<ServiceResponse> getOneService(@Query("id") String id);

  @POST(EndPoints.addService)
  Future<AddServiceResponse> addService(@Body() Map<String, dynamic> body);

  @DELETE(EndPoints.deleteService)
  Future<DeleteServiceResponse> deleteService(@Query("id") String id);

  @PATCH(EndPoints.updateService)
  Future<ServiceResponse> updateService(
    @Query("id") String id,
    @Body() Map<String, dynamic> body,
  );
}
