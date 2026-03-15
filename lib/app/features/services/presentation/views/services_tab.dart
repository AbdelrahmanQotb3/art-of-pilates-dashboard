import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_state.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_view_model.dart';
import 'package:pilates_dashboard/app/features/services/presentation/views/service_details_screen.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
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
          if (addStatus?.isLoading == true) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          } else {
            if (addStatus?.data != null || addStatus?.errorMessage != null) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          }

          if (addStatus?.errorMessage != null) {
            _showStatusDialog(context, title: "Error", message: addStatus!.errorMessage!, isSuccess: false);
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
                        onChanged: (value) {},
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
    DateTime? selectedBuffer;
    String selectedPaymentType = 'PER_SESSION';
    String selectedPriceType = 'FIXED_PRICE';
    String selectedPaymentPref = 'ENTIRE_AMOUNT_IN_PERSON';
    String selectedPolicy = 'DEFAULT_POLICY';
    bool isVisible = true;
    viewModel.nameController.clear();
    viewModel.locationController.text = "Art Of Pilates Studio";
    viewModel.paymentAmountController.clear();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocale(context).addService),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _spacing(
                    AppTextField(controller: viewModel.nameController, label: "Name", hint: "e.g. Reformer Class"),
                  ),
                  _spacing(
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Buffer Time", style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      subtitle: Text(selectedBuffer?.toLocal().toString().split(' ')[0] ?? 'Select Date', 
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
                      trailing: Icon(Icons.calendar_today, color: Colors.blue[700]),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) setState(() => selectedBuffer = picked);
                      },
                    ),
                  ),
                  _spacing(
                    _dropdown("Payment Type", selectedPaymentType, 
                      ['PER_SESSION_WITH_PLAN', 'PER_SESSION'], (val) => setState(() => selectedPaymentType = val!)),
                  ),
                  if (selectedPaymentType == 'PER_SESSION') ...[
                    _spacing(
                      _dropdown("Price Type", selectedPriceType, 
                        ['FIXED_PRICE', 'FREE'], (val) => setState(() => selectedPriceType = val!)),
                    ),
                    if (selectedPriceType == 'FIXED_PRICE')
                      _spacing(
                        AppTextField(controller: viewModel.paymentAmountController, label: "Amount", keyboardType: TextInputType.number, hint: "0.00"),
                      ),
                  ],
                  _spacing(
                    _dropdown("Payment Preference", selectedPaymentPref, 
                      ['ENTIRE_AMOUNT_ONLINE', 'ENTIRE_AMOUNT_IN_PERSON', 'ENTIRE_AMOUNT_EITHER', 'ONLINE_DEPOSIT_REST_IN_PERSON'], 
                      (val) => setState(() => selectedPaymentPref = val!)),
                  ),
                  _spacing(
                    AppTextField(controller: viewModel.locationController, label: "Location", hint: "e.g. Art Of Pilates Studio"),
                  ),
                  _spacing(
                    _dropdown("Booking Policy", selectedPolicy, 
                      ['DEFAULT_POLICY', 'ART_OF_PILATES_POLICY'], (val) => setState(() => selectedPolicy = val!)),
                  ),
                  SwitchListTile(
                    title: const Text("Visible in App"),
                    value: isVisible,
                    activeColor: AppColors.primaryColor,
                    onChanged: (value) => setState(() => isVisible = value),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text(AppLocale(context).cancle, style: const TextStyle(color: Colors.grey))
            ),
            ElevatedButton(
              onPressed: () async {
                if (viewModel.nameController.text.isEmpty) return;

                final success = await viewModel.addService(
                  name: viewModel.nameController.text,
                  price: viewModel.paymentAmountController.text, // Mapping to price
                  currency: "SAR",
                  isVisible: isVisible,
                  bufferTime: selectedBuffer,
                  paymentType: selectedPaymentType,
                  paymentPriceType: selectedPriceType,
                  paymentAmount: double.tryParse(viewModel.paymentAmountController.text),
                  paymentPref: selectedPaymentPref,
                  location: viewModel.locationController.text,
                  bookingPolicy: selectedPolicy,
                );

                if (context.mounted && success) {
                  Navigator.pop(context);
                  _showStatusDialog(context, title: "Success", message: "Service added successfully", isSuccess: true);
                  viewModel.getServices(); // Refresh table
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
              child: Text(AppLocale(context).ok, style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  // --- Consistent Helpers ---

  Widget _dropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label, 
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e.replaceAll('_', ' ')))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _spacing(Widget child) => Padding(padding: const EdgeInsets.only(bottom: 16), child: child);

  void _showStatusDialog(BuildContext context, {required String title, required String message, required bool isSuccess}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: TextStyle(color: isSuccess ? Colors.green : Colors.red)),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocale(context).ok)),
        ],
      ),
    );
  }

  List<PrimaryTableColumn<ServiceEntity>> _buildColumns(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return [
      _column(local.service, (item) => item.name ?? "N/A"),
      _column(local.pricing, (item) => "${item.price ?? item.paymentAmount} ${item.currency ?? 'SAR'}"),
      _column(local.visibility, (item) => item.isVisible == true ? local.visible : local.hidden),
      _column(local.createdAt, (item) => item.createdAt?.toString().split(' ')[0] ?? "N/A"),
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