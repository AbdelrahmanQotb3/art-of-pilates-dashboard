import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/core/utils/end_points.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/delete_pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plans_response.dart';
import 'package:retrofit/retrofit.dart';

part 'pricing_plans_api_client.g.dart';

@RestApi(baseUrl: EndPoints.baseUrl)
@injectable
abstract class PricingPlansApiClient {
  @factoryMethod
  factory PricingPlansApiClient(Dio dio) = _PricingPlansApiClient;

  @GET(EndPoints.getPricingPlans)
  Future<PricingPlansResponse> getPricingPlans();

  @GET(EndPoints.getPlan)
  Future<PricingPlanResponse> getPlan(@Query("planId") int id);

  @POST(EndPoints.addPlan)
  Future<PricingPlanResponse> addPlan(@Body() Map<String, dynamic> body);

  @DELETE(EndPoints.deletePlan)
  Future<DeletePricingPlanResponse> deletePlan(@Query("planId") int id);

  @PATCH(EndPoints.updatePlan)
  Future<PricingPlanResponse> updatePlan(
    @Path("id") int id,
    @Body() Map<String, dynamic> body,
  );
}
