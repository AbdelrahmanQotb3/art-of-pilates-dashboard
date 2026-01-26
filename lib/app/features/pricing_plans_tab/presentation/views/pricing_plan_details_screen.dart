import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/view_model/pricing_plan_details_view_model.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/view_model/pricing_plans_states.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';

class PricingPlanDetailsScreen extends StatelessWidget {
  final viewModel = getIt<PricingPlanDetailsViewModel>();
  final int? planId;

  PricingPlanDetailsScreen({super.key, this.planId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PricingPlanDetailsViewModel>(
      create: (context) {
        if (planId != null) {
          viewModel.planId = planId;
          viewModel.getPricingPlanDetails(planId!);
        }
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: _buildAppBar(context),
        body: BlocConsumer<PricingPlanDetailsViewModel, PricingPlansStates>(
          listener: (context, state) {
            if (state.pricingPlanDetailsState?.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.pricingPlanDetailsState!.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final data = state.pricingPlanDetailsState?.data;

            if (state.pricingPlanDetailsState?.isLoading == true &&
                data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, data),
                  const SizedBox(height: 32),
                  _buildActionButtons(context, data),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, dynamic data) {
    final locale = AppLocale(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildDetailItem(
              icon: Icons.label_outline,
              label: locale.planName,
              value: data?.planName,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.payments_outlined,
              label: locale.pricing,
              value: data?.pricing != null ? '${data.pricing} SAR' : null,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.timer_outlined,
              label: locale.duration,
              value: data?.duration,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.info_outline,
              label: locale.status,
              value: data?.status,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required dynamic value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[700], size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              value?.toString() ?? 'N/A',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic data) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showEditDialog(context, data),
            icon: const Icon(Icons.edit, size: 18),
            label: Text(AppLocale(context).edit),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final bool isDeleted = await viewModel.deletePricingPlan(data.id);
              if (isDeleted) {
                _showStatusDialog(
                  context,
                  title: "Deleted",
                  message: "Pricing plan deleted successfully.",
                  isSuccess: true,
                );
              } else {
                _showStatusDialog(
                  context,
                  title: "Error",
                  message: "Failed to delete pricing plan.",
                  isSuccess: false,
                );
              }
            },
            icon: const Icon(Icons.delete_outline, size: 18),
            label: Text(AppLocale(context).delete),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red[700],
              side: BorderSide(color: Colors.red.shade200),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      title: Text(
        'Pricing Plan Details',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  void _showStatusDialog(
    BuildContext context, {
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(AppLocale(context).ok),
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, dynamic currentData) {
    viewModel.planNameController.text = currentData?.planName ?? '';
    viewModel.pricingController.text = currentData?.pricing?.toString() ?? '';
    viewModel.durationController.text = currentData?.duration ?? '';
    viewModel.statusController.text = currentData?.status ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocale(context).edit),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
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
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocale(context).cancle,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (planId == null) return;
                try {
                  final pricing = viewModel.pricingController.text.isNotEmpty
                      ? double.parse(viewModel.pricingController.text)
                      : null;
                  final bool isUpdate = await viewModel.updatePricingPlan(
                    planId!,
                    viewModel.planNameController.text,
                    pricing,
                    viewModel.durationController.text,
                    viewModel.statusController.text,
                  );
                  Navigator.pop(context);
                  if (isUpdate) {
                    _showStatusDialog(
                      context,
                      title: 'Success',
                      message: 'Pricing plan updated successfully!',
                      isSuccess: true,
                    );
                    viewModel.getPricingPlanDetails(planId!);
                  } else {
                    _showStatusDialog(
                      context,
                      title: 'Error',
                      message: 'Failed to update pricing plan.',
                      isSuccess: false,
                    );
                  }
                } on FormatException {
                  _showStatusDialog(
                    context,
                    title: 'Error',
                    message: 'Please enter a valid price.',
                    isSuccess: false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
              child: Text(
                AppLocale(context).ok,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);
}
