import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/data_source/pricing_plans_data_source_contract.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/delete_pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plan_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/data/model/pricing_plans_response.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/delete_pricing_plan_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/repo/pricing_plans_repo_contract.dart';

@Injectable(as: PricingPlansRepoContract)
class PricingPlansRepImpl implements PricingPlansRepoContract {
  PricingPlansDataSourceContract dataSource;
  PricingPlansRepImpl(this.dataSource);

  @override
  Future<BaseResponse<PricingPlansModel>> getPricingPlans() async {
    final response = await dataSource.getPricingPlans();
    switch (response) {
      case SuccessResponse<PricingPlansResponse>():
        final List<PricingPlansEntity> plans = response.data.plans!.map((
          planDto,
        ) {
          return PricingPlansEntity(
            id: planDto.id!,
            planName: planDto.planName!,
            pricing: planDto.pricing!,
            duration: planDto.duration!,
            status: planDto.status!,
            imageUrl: planDto.imageUrl,
          );
        }).toList();
        final model = PricingPlansModel(pricingPlans: plans);
        return SuccessResponse<PricingPlansModel>(data: model);
      case ErrorResponse<PricingPlansResponse>():
        return ErrorResponse<PricingPlansModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<PricingPlansEntity>> getPricingPlanDetails(
    int planId,
  ) async {
    final response = await dataSource.getPricingPlanDetails(planId);
    switch (response) {
      case SuccessResponse<PricingPlanResponse>():
        final plan = PricingPlansEntity(
          id: response.data.plan!.id,
          planName: response.data.plan!.planName,
          pricing: response.data.plan!.pricing,
          duration: response.data.plan!.duration,
          status: response.data.plan!.status,
          imageUrl: response.data.plan!.imageUrl,
        );
        return SuccessResponse<PricingPlansEntity>(data: plan);
      case ErrorResponse<PricingPlanResponse>():
        return ErrorResponse<PricingPlansEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<PricingPlansEntity>> addPricingPlan(
    String planName,
    double pricing,
    String duration,
    String status,
  ) async {
    final response = await dataSource.addPricingPlan(
      planName,
      pricing,
      duration,
      status,
    );
    switch (response) {
      case SuccessResponse<PricingPlanResponse>():
        final plan = PricingPlansEntity(
          id: response.data.plan!.id,
          planName: response.data.plan!.planName,
          pricing: response.data.plan!.pricing,
          duration: response.data.plan!.duration,
          status: response.data.plan!.status,
          imageUrl: response.data.plan!.imageUrl,
        );
        return SuccessResponse<PricingPlansEntity>(data: plan);
      case ErrorResponse<PricingPlanResponse>():
        return ErrorResponse<PricingPlansEntity>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<DeletePricingPlanModel>> deletePricingPlan(
    int planId,
  ) async {
    final response = await dataSource.deletePricingPlan(planId);
    switch (response) {
      case SuccessResponse<DeletePricingPlanResponse>():
        final model = DeletePricingPlanModel(
          message: response.data.message,
          status: response.data.status,
        );
        return SuccessResponse<DeletePricingPlanModel>(data: model);
      case ErrorResponse<DeletePricingPlanResponse>():
        return ErrorResponse<DeletePricingPlanModel>(error: response.error);
    }
  }

  @override
  Future<BaseResponse<PricingPlansEntity>> updatePricingPlan(
    int planId,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
  ) async {
    final response = await dataSource.updatePricingPlan(
      planId,
      planName,
      pricing,
      duration,
      status,
    );
    switch (response) {
      case SuccessResponse<PricingPlanResponse>():
        final plan = PricingPlansEntity(
          id: response.data.plan!.id,
          planName: response.data.plan!.planName,
          pricing: response.data.plan!.pricing,
          duration: response.data.plan!.duration,
          status: response.data.plan!.status,
          imageUrl: response.data.plan!.imageUrl,
        );
        return SuccessResponse<PricingPlansEntity>(data: plan);
      case ErrorResponse<PricingPlanResponse>():
        return ErrorResponse<PricingPlansEntity>(error: response.error);
    }
  }
}
