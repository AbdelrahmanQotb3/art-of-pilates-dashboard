import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_state.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_view_model.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String id;
  final viewModel = getIt<ServicesViewModel>();

  ServiceDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServicesViewModel>(
      create: (context) => viewModel..getOneService(id),
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: _buildAppBar(context),
        body: BlocConsumer<ServicesViewModel, ServicesState>(
          listener: (context, state) {},
          builder: (context, state) {
            final data = state.serviceState?.data;
            if (state.serviceState?.isLoading == true && data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (data == null) return Center(child: Text(AppLocalizations.of(context)!.noData));

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildDetailedInfoCard(context, data),
                  const SizedBox(height: 24),
                  _buildActionButtons(context, data),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailedInfoCard(BuildContext context, ServiceEntity data) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _detailRow(Icons.title, "Name", data.name),
            _divider(),
            _detailRow(Icons.timer_outlined, "Buffer Time", data.bufferTime?.split('T')[0] ?? "Not Set"),
            _divider(),
            _detailRow(Icons.payments_outlined, "Payment Type", data.paymentType?.replaceAll('_', ' ')),
            _divider(),
            _detailRow(Icons.sell_outlined, "Price Type", data.paymentPriceType?.replaceAll('_', ' ')),
            if (data.paymentPriceType == "FIXED_PRICE") ...[
              _divider(),
              _detailRow(Icons.money, "Payment Amount", "${data.paymentAmount} ${data.currency ?? 'SAR'}"),
            ],
            _divider(),
            _detailRow(Icons.receipt_long_outlined, "Payment Preference", data.paymentPref?.replaceAll('_', ' ')),
            _divider(),
            _detailRow(Icons.location_on_outlined, "Location", data.location),
            _divider(),
            _detailRow(Icons.policy_outlined, "Booking Policy", data.bookingPolicy?.replaceAll('_', ' ')),
          ],
        ),
      ),
    );
  }
  void _showEditDialog(BuildContext context, ServiceEntity currentData) {
    DateTime? selectedBuffer = currentData.bufferTime != null ? DateTime.parse(currentData.bufferTime!) : null;
    String selectedPaymentType = currentData.paymentType ?? 'PER_SESSION';
    String selectedPriceType = currentData.paymentPriceType ?? 'FIXED_PRICE';
    String selectedPaymentPref = currentData.paymentPref ?? 'ENTIRE_AMOUNT_IN_PERSON';
    String selectedPolicy = currentData.bookingPolicy ?? 'DEFAULT_POLICY';

    viewModel.nameController.text = currentData.name ?? '';
    viewModel.locationController.text = currentData.location ?? "Art Of Pilates Studio";
    viewModel.paymentAmountController.text = currentData.paymentAmount?.toString() ?? '';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(AppLocale(context).edit),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          initialDate: selectedBuffer ?? DateTime.now(),
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
                final success = await viewModel.updateService(
                  id: id,
                  name: viewModel.nameController.text,
                  bufferTime: selectedBuffer,
                  paymentType: selectedPaymentType,
                  paymentPriceType: selectedPriceType,
                  paymentAmount: double.tryParse(viewModel.paymentAmountController.text),
                  paymentPref: selectedPaymentPref,
                  location: viewModel.locationController.text,
                  bookingPolicy: selectedPolicy,
                );
                if (context.mounted) {
                  Navigator.pop(context);
                  _showStatusDialog(
                    context, 
                    title: success ? AppLocalizations.of(context)!.success : "Error",
                    message: success ? "Updated successfully" : "Update failed",
                    isSuccess: success,
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[700]),
              child: Text(AppLocale(context).ok, style: const TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

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

  Widget _detailRow(IconData icon, String label, dynamic value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: Colors.blue[700], size: 20),
        ),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(value?.toString() ?? "N/A", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ]),
      ],
    );
  }

  Widget _divider() => const Padding(padding: EdgeInsets.symmetric(vertical: 8.0), child: Divider());

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
    title: Text("Service Details", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), 
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
  );

  Widget _buildActionButtons(BuildContext context, ServiceEntity data) {
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              final confirm = await _showDeleteConfirmation(context);
              if (confirm == true) {
                final success = await viewModel.deleteService(data.id!);
                if (success && context.mounted) {
                   _showStatusDialog(context, title: "Deleted", message: "Service deleted successfully", isSuccess: true);
                }
              }
            },
            icon: const Icon(Icons.delete_outline, size: 18),
            label: Text(AppLocale(context).delete),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red[700],
              side: BorderSide(color: Colors.red.shade200),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }

  void _showStatusDialog(BuildContext context, {required String title, required String message, required bool isSuccess}) {
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

  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.delete),
        content: Text(AppLocalizations.of(context)!.areYouSure),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(AppLocale(context).cancle)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(AppLocale(context).ok, style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  Widget _spacing(Widget child) => Padding(padding: const EdgeInsets.only(bottom: 16), child: child);
}