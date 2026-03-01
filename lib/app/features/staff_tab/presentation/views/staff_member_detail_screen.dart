import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/view_model/sessions_view_model.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/views/session_details_screen.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/view_model/staff_member_view_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/view_model/staff_members_states.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class StaffMemberDetailScreen extends StatelessWidget {
  final viewModel = getIt<StaffMemberViewModel>();
  final int? memberIndex;

  StaffMemberDetailScreen({super.key, this.memberIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StaffMemberViewModel>(
      create: (context) {
        if (memberIndex != null) {
          viewModel.getStaffMember(memberIndex!);
        }
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: _buildAppBar(context),
        body: BlocConsumer<StaffMemberViewModel, StaffMembersStates>(
          listener: (context, state) {
            if (state.staffMemberState?.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.staffMemberState!.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final data = state.staffMemberState?.data;

            if (state.staffMemberState?.isLoading == true && data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, data),
                  const SizedBox(height: 24),
                  if (data?.sessions != null &&
                      (data!.sessions?.isNotEmpty ?? false)) ...[
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
                  _buildActionButtons(context, data!),
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
            final service = s.serviceName ?? '';
            return ListTile(
              title: Text(
                service.isNotEmpty
                    ? service
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
              icon: Icons.person_outline,
              label: locale.name,
              value: data?.name,
              context: context,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.email_outlined,
              label: locale.email,
              value: data?.email,
              context: context,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.phone_android_outlined,
              label: locale.phone,
              value: data?.phone,
              context: context,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.settings_outlined,
              label: AppLocalizations.of(context)!.customAction,
              value: data?.customAction,
              context: context,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.visibility_outlined,
              label: AppLocalizations.of(context)!.visibility,
              value: data?.visibility == true
                  ? AppLocalizations.of(context)!.visible
                  : AppLocalizations.of(context)!.hidden,
              context: context,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.tag_outlined,
              label: AppLocalizations.of(context)!.index,
              value: data?.index.toString(),
              context: context,
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
    required BuildContext context,
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
              value?.toString() ?? AppLocalizations.of(context)!.notAvailable,
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

  Widget _buildActionButtons(BuildContext context, StaffMemberEntity data) {
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
              final isDeleted = await viewModel.deleteStaffMember(
                data.index!,
                data.id!,
              );
              if (isDeleted) {
                _showStatusDialog(
                  context,
                  title: "Deleted",
                  message: "Staff member deleted successfully.",
                  isSuccess: true,
                );
              } else {
                _showStatusDialog(
                  context,
                  title: "Error",
                  message: "Failed to delete staff member.",
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
        AppLocalizations.of(context)!.staffDetails,
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
    viewModel.nameController.text = currentData?.name ?? '';
    viewModel.emailController.text = currentData?.email ?? '';
    viewModel.phoneController.text = currentData?.phone ?? '';
    viewModel.customActionController.text = currentData?.customAction ?? '';

    bool isVisible = currentData?.visibility ?? true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
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
                          label: AppLocalizations.of(context)!.name,
                          hint: AppLocalizations.of(context)!.name,
                        ),
                      ),
                      _spacing(
                        AppTextField(
                          controller: viewModel.emailController,
                          label: AppLocale(context).email,
                          hint: AppLocale(context).email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      _spacing(
                        AppTextField(
                          controller: viewModel.phoneController,
                          label: AppLocalizations.of(context)!.phone,
                          hint: AppLocalizations.of(context)!.phone,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      _spacing(
                        AppTextField(
                          controller: viewModel.customActionController,
                          label: AppLocalizations.of(context)!.customAction,
                          hint: AppLocalizations.of(context)!.customAction,
                        ),
                      ),
                      _spacing(
                        DropdownButtonFormField<bool>(
                          focusColor: AppColors.whiteColor,
                          dropdownColor: AppColors.whiteColor,
                          value: isVisible,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.visibility,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: true,
                              child: Text(
                                AppLocalizations.of(context)!.visible,
                              ),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text(AppLocalizations.of(context)!.hidden),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => isVisible = value);
                            }
                          },
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
                    final success = await viewModel.updateStaffMember(
                      currentData.index,
                      viewModel.nameController.text,
                      viewModel.emailController.text,
                      viewModel.phoneController.text,
                      viewModel.customActionController.text,
                      isVisible,
                    );

                    if (context.mounted) {
                      Navigator.pop(context);
                      _showStatusDialog(
                        context,
                        title: success
                            ? AppLocalizations.of(context)!.success
                            : "Error",
                        message: success
                            ? 'Updated successfully'
                            : 'Update failed',
                        isSuccess: success,
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
      },
    );
  }

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);
}
