import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/delete_pricing_plan_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/use_cases/pricing_plans_use_case.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/view_model/pricing_plans_states.dart';

@injectable
class PricingPlanDetailsViewModel extends Cubit<PricingPlansStates> {
  PricingPlansUseCase pricingPlansUseCase;
  int? planId;
  TextEditingController planNameController = TextEditingController();
  TextEditingController pricingController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  PricingPlanDetailsViewModel(this.pricingPlansUseCase)
    : super(PricingPlansStates());

  Future<BaseResponse<PricingPlansEntity>> getPricingPlanDetails(
    int planId,
  ) async {
    emit(
      state.copyWith(
        pricingPlanDetailsStateParam: BaseState<PricingPlansEntity>(
          isLoading: true,
        ),
      ),
    );
    final response = await pricingPlansUseCase.getPricingPlanDetails(planId);
    switch (response) {
      case SuccessResponse<PricingPlansEntity>():
        emit(
          state.copyWith(
            pricingPlanDetailsStateParam: BaseState<PricingPlansEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        break;
      case ErrorResponse<PricingPlansEntity>():
        emit(
          state.copyWith(
            pricingPlanDetailsStateParam: BaseState<PricingPlansEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        break;
    }
    return response;
  }

  Future<bool> deletePricingPlan(int planId) async {
    emit(
      state.copyWith(
        deletePricingPlanStateParam: BaseState<DeletePricingPlanModel>(
          isLoading: true,
        ),
      ),
    );
    final response = await pricingPlansUseCase.deletePricingPlan(planId);
    switch (response) {
      case SuccessResponse<DeletePricingPlanModel>():
        emit(
          state.copyWith(
            deletePricingPlanStateParam: BaseState<DeletePricingPlanModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<DeletePricingPlanModel>():
        emit(
          state.copyWith(
            deletePricingPlanStateParam: BaseState<DeletePricingPlanModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }

  Future<bool> updatePricingPlan(
    int planId,
    String? planName,
    double? pricing,
    String? duration,
    String? status,
  ) async {
    emit(
      state.copyWith(
        updatePricingPlanStateParam: BaseState<PricingPlansEntity>(
          isLoading: true,
        ),
      ),
    );
    final response = await pricingPlansUseCase.updatePricingPlan(
      planId,
      planName,
      pricing,
      duration,
      status,
    );
    switch (response) {
      case SuccessResponse<PricingPlansEntity>():
        emit(
          state.copyWith(
            updatePricingPlanStateParam: BaseState<PricingPlansEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<PricingPlansEntity>():
        emit(
          state.copyWith(
            updatePricingPlanStateParam: BaseState<PricingPlansEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }
}
