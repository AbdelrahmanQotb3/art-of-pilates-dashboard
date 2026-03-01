import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/services/domain/model/services_model.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_state.dart';
import 'package:pilates_dashboard/app/features/services/presentation/view_model/services_view_model.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/view_model/sessions_view_model.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/views/session_details_screen.dart';
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
          listener: (context, state) {
            if (state.serviceState?.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.serviceState!.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final data = state.serviceState?.data;

            if (state.serviceState?.isLoading == true && data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (data == null) {
              return Center(child: Text(AppLocalizations.of(context)!.noData));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, data),
                  const SizedBox(height: 24),
                  if (data.sessions != null &&
                      (data.sessions?.isNotEmpty ?? false)) ...[
                    Text(
                      AppLocalizations.of(context)!.sessions,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSessionsList(context, data.sessions!),
                    const SizedBox(height: 24),
                  ],
                  _buildActionButtons(context, data),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSessionsList(BuildContext context, List sessions) {
    final sessionsVm = getIt<SessionsViewModel>();
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: sessions.map<Widget>((s) {
            final start = s.startTime ?? '';
            final end = s.endTime ?? '';
            final staff = s.staffName ?? '';
            return ListTile(
              title: Text(
                staff.isNotEmpty
                    ? staff
                    : AppLocalizations.of(context)!.session,
              ),
              subtitle: Text('$start - $end'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SessionDetailsScreen(session: s),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.delete),
                          content: Text(
                            AppLocalizations.of(context)!.areYouSure,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(AppLocale(context).cancle),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(AppLocale(context).ok),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        final success = await sessionsVm.deleteSession(
                          s.id ?? '',
                        );
                        if (success) {
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)!.success,
                                ),
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.deletedSuccessfully,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(AppLocale(context).ok),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          if (context.mounted)
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)!.error,
                                ),
                                content: const Text('Failed to delete'),
                              ),
                            );
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      title: const Text(
        'Service Details',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, ServiceEntity data) {
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
              icon: Icons.design_services_outlined,
              label: AppLocalizations.of(context)!.serviceName,
              value: data.name,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.price_check_sharp,
              label: AppLocalizations.of(context)!.price,
              value: data.price != null
                  ? "${data.price} ${data.currency ?? ''}"
                  : null,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.date_range_outlined,
              label: AppLocalizations.of(context)!.createdAt,
              value: data.createdAt?.split('T')[0],
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.visibility_outlined,
              label: AppLocalizations.of(context)!.visibility,
              value: data.isVisible == true ? "Visible" : "Hidden",
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
        Expanded(
          child: Column(
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
        ),
      ],
    );
  }

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
              final isDeleted = await viewModel.deleteService(data.id!);
              if (isDeleted) {
                _showStatusDialog(
                  context,
                  title: AppLocalizations.of(context)!.deleted,
                  message: AppLocalizations.of(context)!.deletedSuccessfully,
                  isSuccess: true,
                );
              } else {
                _showStatusDialog(
                  context,
                  title: AppLocalizations.of(context)!.error,
                  message: AppLocalizations.of(context)!.failedToDelete,
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

  void _showEditDialog(BuildContext context, ServiceEntity currentData) {
    // Assuming these controllers exist in your ServicesViewModel
    viewModel.nameController.text = currentData.name ?? '';
    viewModel.priceController.text = currentData.price?.toString() ?? '';
    viewModel.currencyController.text = currentData.currency ?? 'SAR';

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
                      controller: viewModel.nameController,
                      label: AppLocalizations.of(context)!.serviceName,
                      hint: AppLocalizations.of(context)!.enterServiceName,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.priceController,
                      label: AppLocalizations.of(context)!.price,
                      hint: AppLocalizations.of(context)!.enterPrice,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.currencyController,
                      label: AppLocalizations.of(context)!.currency,
                      hint: AppLocalizations.of(context)!.enterCurrency,
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
                try {
                  final price = int.parse(viewModel.priceController.text);
                  final bool isUpdate = await viewModel.updateService(
                    id: id,
                    name: viewModel.nameController.text,
                    price: price,
                    currency: viewModel.currencyController.text,
                    isVisible: currentData.isVisible,
                    index: currentData.index,
                  );

                  Navigator.pop(context); // Close edit dialog

                  if (isUpdate) {
                    _showStatusDialog(
                      context,
                      title: AppLocalizations.of(context)!.success,
                      message: AppLocalizations.of(
                        context,
                      )!.updatedSuccessfully,
                      isSuccess: true,
                    );
                    // Refresh details
                    viewModel.getOneService(id);
                  } else {
                    _showStatusDialog(
                      context,
                      title: AppLocalizations.of(context)!.error,
                      message: AppLocalizations.of(context)!.failedUpdate,
                      isSuccess: false,
                    );
                  }
                } catch (e) {
                  _showStatusDialog(
                    context,
                    title: AppLocalizations.of(context)!.error,
                    message: AppLocalizations.of(context)!.somethingWentWrong,
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

  void _showStatusDialog(
    BuildContext context, {
    required String title,
    required String message,
    required bool isSuccess,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          title,
          style: TextStyle(color: isSuccess ? Colors.green : Colors.red),
        ),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(AppLocale(context).ok),
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess && title == "Deleted") {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);
}
