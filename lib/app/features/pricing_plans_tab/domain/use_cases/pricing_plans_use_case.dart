import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/delete_pricing_plan_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/repo/pricing_plans_repo_contract.dart';

@injectable
class PricingPlansUseCase {
  PricingPlansRepoContract repoContract;
  PricingPlansUseCase(this.repoContract);

  Future<BaseResponse<PricingPlansModel>> getPricingPlans() {
    return repoContract.getPricingPlans();
  }

  Future<BaseResponse<PricingPlansEntity>> getPricingPlanDetails(int planId) {
    return repoContract.getPricingPlanDetails(planId);
  }

  Future<BaseResponse<PricingPlansEntity>> addPricingPlan(
    String planName,
    double pricing,
    String duration,
    String status,
  ) {
    return repoContract.addPricingPlan(planName, pricing, duration, status);
  }

  Future<BaseResponse<DeletePricingPlanModel>> deletePricingPlan(int planId) {
    return repoContract.deletePricingPlan(planId);
  }

  Future<BaseResponse<PricingPlansEntity>> updatePricingPlan(
    int planId,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
  ) {
    return repoContract.updatePricingPlan(
      planId,
      planName,
      pricing,
      duration,
      status,
    );
  }
}
