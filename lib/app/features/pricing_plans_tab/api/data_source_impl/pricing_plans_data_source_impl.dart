import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/api/api_client/pricing_plans_api_client.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/data_source/pricing_plans_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/delete_pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plans_response.dart';

@Injectable(as: PricingPlansDataSourceContract)
class PricingPlansDataSourceImpl implements PricingPlansDataSourceContract {
  PricingPlansApiClient apiClient;
  PricingPlansDataSourceImpl(this.apiClient);
  @override
  Future<BaseResponse<PricingPlansResponse>> getPricingPlans() async {
    final response = await apiClient.getPricingPlans();
    try {
      return SuccessResponse<PricingPlansResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<PricingPlansResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<PricingPlanResponse>> getPricingPlanDetails(
    int planId,
  ) async {
    final response = await apiClient.getPlan(planId);
    try {
      return SuccessResponse<PricingPlanResponse>(data: response);
    } on Exception catch (e) {
      return ErrorResponse<PricingPlanResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<PricingPlanResponse>> addPricingPlan(
    String planName,
    double pricing,
    String duration,
    String status,
  ) async {
    try {
      final response = await apiClient.addPlan({
        "planName": planName,
        "pricing": pricing,
        "duration": duration,
        "status": status,
      });
      return SuccessResponse<PricingPlanResponse>(data: response);
    } catch (e) {
      return ErrorResponse<PricingPlanResponse>(error: e as Exception);
    }
  }

  @override
  Future<BaseResponse<DeletePricingPlanResponse>> deletePricingPlan(
    int planId,
  ) async {
    try {
      final response = await apiClient.deletePlan(planId);
      return SuccessResponse<DeletePricingPlanResponse>(data: response);
    } catch (e) {
      return ErrorResponse<DeletePricingPlanResponse>(error: e as Exception);
    }
  }

  @override
  Future<BaseResponse<PricingPlanResponse>> updatePricingPlan(
    int planId,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
  ) async {
    try {
      final response = await apiClient.updatePlan(planId, {
        if (planName != null) "planName": planName,
        if (pricing != null) "pricing": pricing,
        if (duration != null) "duration": duration,
        if (status != null) "status": status,
      });
      return SuccessResponse<PricingPlanResponse>(data: response);
    } catch (e) {
      return ErrorResponse<PricingPlanResponse>(error: e as Exception);
    }
  }
}
