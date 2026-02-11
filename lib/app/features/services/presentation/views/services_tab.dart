import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_state.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_view_model.dart';
import 'package:pilates_dashboard/app/features/services/presentation/views/service_details_screen.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<ServicesViewModel>();

    return BlocProvider(
      create: (context) => viewModel..getServices(),
      child: BlocConsumer<ServicesViewModel, ServicesState>(
        listener: (context, state) {
          final addStatus = state.addServiceState;

          // 1. Handle Loading Overlay
          if (addStatus?.isLoading == true) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else {
            // Close loading dialog if it's open
            if (addStatus?.data != null || addStatus?.errorMessage != null) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          }

          // 2. Handle Errors
          if (addStatus?.errorMessage != null) {
            _showStatusDialog(
              context,
              AppLocalizations.of(context)!.error,
              addStatus!.errorMessage!,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final services = state.servicesState?.data?.services ?? [];
          final isLoading = state.servicesState?.isLoading ?? false;

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
                        controller: viewModel.searchController,
                        onChanged: (value) {
                          // Search logic can be added here
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => _showAddServiceDialog(context, viewModel),
                      icon: const Icon(Icons.add, color: AppColors.whiteColor),
                      label: Text(AppLocale(context).addService),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: AppColors.whiteColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
                      : PrimaryTable<ServiceEntity>(
                          columns: _buildColumns(context),
                          rowHeight: 80,
                          items: services,
                          onRowTap: (item) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ServiceDetailsScreen(id: item.id!),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context, ServicesViewModel viewModel) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final currencyController = TextEditingController(text: "SAR");
    bool isVisible = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(AppLocale(context).addService),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: nameController,
                        label: "Service Name",
                        hint: "e.g. Private Pilates Session",
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: priceController,
                        label: "Price",
                        hint: "0.00",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: currencyController,
                        label: "Currency",
                        hint: "SAR",
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text("Visible in App"),
                        value: isVisible,
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) {
                          setDialogState(() => isVisible = value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                  onPressed: () async {
                    if (nameController.text.isEmpty || priceController.text.isEmpty) {
                      return;
                    }

                    final success = await viewModel.addService(
                      name: nameController.text,
                      price: priceController.text,
                      currency: currencyController.text,
                      isVisible: isVisible,
                    );

                    if (success && context.mounted) {
                      Navigator.pop(dialogContext); // Close Add Dialog
                      _showStatusDialog(context, "Success", "Service added successfully");
                      viewModel.getServices(); // Refresh the table
                    }
                  },
                  child: const Text("Add Service", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showStatusDialog(BuildContext context, String title, String message, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: isError ? Colors.red : Colors.green)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }

  List<PrimaryTableColumn<ServiceEntity>> _buildColumns(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return [
      _column(local.service, (item) => item.name ?? "N/A"),
      _column(local.pricing, (item) => "${item.price} ${item.currency}"),
      _column(
        local.visibility,
        (item) => item.isVisible == true ? local.visible : local.hidden,
      ),
      _column(
        local.createdAt,
        (item) => item.createdAt?.toString().split(' ')[0] ?? "N/A",
      ),
    ];
  }

  PrimaryTableColumn<ServiceEntity> _column(String title, String Function(ServiceEntity) mapper) {
    return PrimaryTableColumn<ServiceEntity>(
      title: title,
      cellBuilder: (item) => Text(
        mapper(item),
        style: const TextStyle(fontSize: 18, color: Color(0xFF222222)),
      ),
    );
  }
}