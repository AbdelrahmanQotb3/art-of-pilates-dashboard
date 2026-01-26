import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/domain/model/pricing_plans_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/view_model/pricing_plans_states.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/view_model/pricing_plans_view_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/views/pricing_plan_details_screen.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/loading_dialog.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class PricingPlansTab extends StatelessWidget {
  const PricingPlansTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<PricingPlansViewModel>();

    return BlocProvider(
      create: (context) => viewModel..doIntent(),
      child: BlocConsumer<PricingPlansViewModel, PricingPlansStates>(
        builder: (context, state) {
          final pricingPlans =
              state.pricingPlansState?.data?.pricingPlans ?? [];

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: AppLocale(context).search,
                        hint: AppLocale(context).search,
                        onChanged: (value) {
                          // TODO: Implement search logic
                        },
                        controller: viewModel.searchController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showAddPricingPlanDialog(context);
                      },
                      icon: const Icon(Icons.add, color: AppColors.whiteColor),
                      label: Text(AppLocalizations.of(context)!.addPlan),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: PrimaryTable<PricingPlansEntity>(
                    columns: _buildColumns(context),
                    items: pricingPlans,
                    cellPadding: const EdgeInsets.all(8),
                    showBorder: true,
                    isSelectable: true,
                    rowHeight: 80,
                    onRowTap: (item) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PricingPlanDetailsScreen(planId: item.id),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          final addPlanStatus = state.addPricingPlanState;
          if (addPlanStatus?.isLoading == true) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(),
            );
          } else {
            if (addPlanStatus?.data != null ||
                addPlanStatus?.errorMessage != null) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          }
          if (addPlanStatus?.errorMessage != null) {
            _showStatusDialog(
              context,
              AppLocalizations.of(context)!.error,
              addPlanStatus!.errorMessage!,
              isError: true,
            );
          }

          if (state.pricingPlansState?.isLoading == true) {
            const Center(child: CircularProgressIndicator());
          } else if (state.pricingPlansState?.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.pricingPlansState!.errorMessage!)),
            );
          } else if (state.pricingPlansState?.data != null) {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          }
        },
      ),
    );
  }

  void _showAddPricingPlanDialog(BuildContext context) {
    final viewModel = getIt<PricingPlansViewModel>();
    viewModel.planNameController.clear();
    viewModel.pricingController.clear();
    viewModel.durationController.clear();
    viewModel.statusController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.addPlan),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _spacing(
                    AppTextField(
                      controller: viewModel.planNameController,
                      label: AppLocale(context).planName,
                      hint: AppLocale(context).planName,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.pricingController,
                      label: AppLocale(context).pricing,
                      hint: AppLocale(context).pricing,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.durationController,
                      label: AppLocale(context).duration,
                      hint: AppLocale(context).duration,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.statusController,
                      label: AppLocale(context).status,
                      hint: AppLocale(context).status,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                AppLocale(context).cancle,
                style: const TextStyle(color: AppColors.grayColor),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final planName = viewModel.planNameController.text;
                final pricingText = viewModel.pricingController.text;
                final duration = viewModel.durationController.text;
                final status = viewModel.statusController.text;

                if (planName.isEmpty ||
                    pricingText.isEmpty ||
                    duration.isEmpty ||
                    status.isEmpty) {
                  _showStatusDialog(
                    context,
                    AppLocalizations.of(context)!.error,
                    'Please fill all fields',
                    isError: true,
                  );
                  return;
                }

                try {
                  final pricing = double.parse(pricingText);
                  final isCreated = await viewModel.addPricingPlan(
                    planName,
                    pricing,
                    duration,
                    status,
                  );
                  if (context.mounted) {
                    Navigator.pop(dialogContext);
                    if (isCreated) {
                      _showStatusDialog(
                        context,
                        AppLocalizations.of(context)!.addPlan,
                        'Pricing plan added successfully',
                      );
                      viewModel.getPricingPlans();
                    } else {
                      _showStatusDialog(
                        context,
                        AppLocalizations.of(context)!.addPlan,
                        'Failed to add pricing plan',
                        isError: true,
                      );
                    }
                  }
                } on FormatException {
                  _showStatusDialog(
                    context,
                    AppLocalizations.of(context)!.error,
                    'Please enter a valid price',
                    isError: true,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                AppLocale(context).ok,
                style: const TextStyle(color: AppColors.secondaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showStatusDialog(
    BuildContext context,
    String title,
    String message, {
    bool isError = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: isError ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocale(context).ok),
          ),
        ],
      ),
    );
  }

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);

  List<PrimaryTableColumn<PricingPlansEntity>> _buildColumns(
    BuildContext context,
  ) {
    return [
      _column(
        AppLocalizations.of(context)!.planName,
        (item) => item.planName.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.pricing,
        (item) => item.pricing.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.duration,
        (item) => item.duration.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.status,
        (item) => item.status.toString(),
      ),
    ];
  }

  PrimaryTableColumn<PricingPlansEntity> _column(
    String title,
    String Function(PricingPlansEntity item) mapper,
  ) {
    return PrimaryTableColumn<PricingPlansEntity>(
      title: title,
      cellBuilder: (item) => Text(
        mapper(item),
        style: const TextStyle(fontSize: 16, color: Color(0xFF222222)),
      ),
    );
  }
}
