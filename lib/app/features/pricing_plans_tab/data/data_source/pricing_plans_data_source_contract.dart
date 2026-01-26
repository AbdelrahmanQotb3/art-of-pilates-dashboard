import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/delete_pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plans_response.dart';

abstract class PricingPlansDataSourceContract {
  Future<BaseResponse<PricingPlansResponse>> getPricingPlans();

  Future<BaseResponse<PricingPlanResponse>> getPricingPlanDetails(int planId);

  Future<BaseResponse<PricingPlanResponse>> addPricingPlan(
    String planName,
    double pricing,
    String duration,
    String status,
  );

  Future<BaseResponse<DeletePricingPlanResponse>> deletePricingPlan(int planId);

  Future<BaseResponse<PricingPlanResponse>> updatePricingPlan(
    int planId,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
  );
}
