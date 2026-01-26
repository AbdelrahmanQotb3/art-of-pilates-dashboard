import 'package:pilates_dashboard/app/config/base_state/base_state.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/delete_pricing_plan_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';

class PricingPlansStates {
  BaseState<PricingPlansModel>? pricingPlansState;
  BaseState<PricingPlansEntity>? pricingPlanDetailsState;
  BaseState<PricingPlansEntity>? addPricingPlanState;
  BaseState<DeletePricingPlanModel>? deletePricingPlanState;
  BaseState<PricingPlansEntity>? updatePricingPlanState;

  PricingPlansStates({
    this.pricingPlansState,
    this.pricingPlanDetailsState,
    this.addPricingPlanState,
    this.deletePricingPlanState,
    this.updatePricingPlanState,
  });

  PricingPlansStates copyWith({
    BaseState<PricingPlansModel>? pricingPlansStateParam,
    BaseState<PricingPlansEntity>? pricingPlanDetailsStateParam,
    BaseState<PricingPlansEntity>? addPricingPlanStateParam,
    BaseState<DeletePricingPlanModel>? deletePricingPlanStateParam,
    BaseState<PricingPlansEntity>? updatePricingPlanStateParam,
  }) {
    return PricingPlansStates(
      pricingPlansState: pricingPlansStateParam ?? pricingPlansState,
      pricingPlanDetailsState:
          pricingPlanDetailsStateParam ?? pricingPlanDetailsState,
      addPricingPlanState: addPricingPlanStateParam ?? addPricingPlanState,
      deletePricingPlanState:
          deletePricingPlanStateParam ?? deletePricingPlanState,
      updatePricingPlanState:
          updatePricingPlanStateParam ?? updatePricingPlanState,
    );
  }
}
