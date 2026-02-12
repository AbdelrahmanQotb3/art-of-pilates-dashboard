import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/delete_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/get_classes_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/one_class_response.dart';
import 'package:pilates_dashboard/app/features/classes/data/model/update_class_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'classes_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class ClassesApiClient {
  @factoryMethod
  factory ClassesApiClient(Dio dio) = _ClassesApiClient;

  @GET(EndPoints.getClasses)
  Future<GetClassesResponse> getClasses();

  @POST(EndPoints.addClass)
  Future<OneClassResponse> addClass(@Body() Map<String, dynamic> body);

  @GET(EndPoints.getOneClass)
  Future<OneClassResponse> getOneClass(@Query("id") String id);

  @DELETE(EndPoints.deleteClass)
  Future<DeleteClassResponse> deleteClass(@Query("id") String id);

  @PATCH(EndPoints.updateClass)
  Future<UpdateClassResponse> updateClass(
    @Query("id") String id,
    @Body() Map<String, dynamic> body,
  );
}
