import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/use_cases/pricing_plans_use_case.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/view_model/pricing_plans_states.dart';

@injectable
class PricingPlansViewModel extends Cubit<PricingPlansStates> {
  TextEditingController searchController = TextEditingController();
  TextEditingController planNameController = TextEditingController();
  TextEditingController pricingController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  PricingPlansUseCase pricingPlansUseCase;
  PricingPlansViewModel(this.pricingPlansUseCase) : super(PricingPlansStates());

  Future<void> doIntent() async {
    await getPricingPlans();
  }

  Future<BaseResponse<PricingPlansModel>> getPricingPlans() async {
    emit(
      state.copyWith(
        pricingPlansStateParam: BaseState<PricingPlansModel>(isLoading: true),
      ),
    );
    final response = await pricingPlansUseCase.getPricingPlans();
    switch (response) {
      case SuccessResponse<PricingPlansModel>():
        emit(
          state.copyWith(
            pricingPlansStateParam: BaseState<PricingPlansModel>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        break;
      case ErrorResponse<PricingPlansModel>():
        emit(
          state.copyWith(
            pricingPlansStateParam: BaseState<PricingPlansModel>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        break;
    }
    return response;
  }

  Future<bool> addPricingPlan(
    String planName,
    double pricing,
    String duration,
    String status,
  ) async {
    emit(
      state.copyWith(
        addPricingPlanStateParam: BaseState<PricingPlansEntity>(
          isLoading: true,
        ),
      ),
    );
    final response = await pricingPlansUseCase.addPricingPlan(
      planName,
      pricing,
      duration,
      status,
    );
    switch (response) {
      case SuccessResponse<PricingPlansEntity>():
        emit(
          state.copyWith(
            addPricingPlanStateParam: BaseState<PricingPlansEntity>(
              data: response.data,
              isLoading: false,
            ),
          ),
        );
        return true;
      case ErrorResponse<PricingPlansEntity>():
        emit(
          state.copyWith(
            addPricingPlanStateParam: BaseState<PricingPlansEntity>(
              errorMessage: response.error.toString(),
              isLoading: false,
            ),
          ),
        );
        return false;
    }
  }
}
