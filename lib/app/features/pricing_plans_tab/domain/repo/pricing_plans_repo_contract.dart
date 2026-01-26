import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/delete_pricing_plan_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';

abstract class PricingPlansRepoContract {
  Future<BaseResponse<PricingPlansModel>> getPricingPlans();

  Future<BaseResponse<PricingPlansEntity>> getPricingPlanDetails(int planId);

  Future<BaseResponse<PricingPlansEntity>> addPricingPlan(
    String planName,
    double pricing,
    String duration,
    String status,
  );

  Future<BaseResponse<DeletePricingPlanModel>> deletePricingPlan(int planId);

  Future<BaseResponse<PricingPlansEntity>> updatePricingPlan(
    int planId,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
  );
}
