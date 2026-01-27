import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/staff_tab/domain/model/staff_members_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/view_model/staff_members_states.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/view_model/staff_members_view_model.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/views/staff_member_detail_screen.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/loading_dialog.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class StaffTab extends StatelessWidget {
  const StaffTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<StaffMembersViewModel>();

    return BlocProvider(
      create: (context) => viewModel..doIntent(),
      child: BlocConsumer<StaffMembersViewModel, StaffMembersStates>(
        builder: (context, state) {
          final staffMembers =
              state.staffMembersState?.data?.staffMembers ?? [];

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
                          // TODO: Implement search logic
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => _showAddStaffMemberDialog(context),
                      icon: const Icon(Icons.add, color: AppColors.whiteColor),
                      label: Text(AppLocalizations.of(context)!.addStaff),
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
                  child: PrimaryTable<StaffMemberEntity>(
                    columns: _buildColumns(context),
                    rowHeight: 80,
                    items: staffMembers,
                    onRowTap: (item) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StaffMemberDetailScreen(memberIndex: item.index!),
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
          final addStatus = state.addStaffMemberState;
          if (addStatus?.isLoading == true) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(),
            );
          } else {
            if (addStatus?.data != null || addStatus?.errorMessage != null) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          }
          if (addStatus?.errorMessage != null) {
            _showStatusDialog(
              context,
              AppLocalizations.of(context)!.error,
              addStatus!.errorMessage!,
              isError: true,
            );
          }
        },
      ),
    );
  }

  void _showAddStaffMemberDialog(BuildContext context) {
    final viewModel = getIt<StaffMembersViewModel>();
    viewModel.nameController.clear();
    viewModel.emailController.clear();
    viewModel.phoneController.clear();
    viewModel.customActionController.clear();

    bool isVisible = true;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.addStaffMember),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          label: AppLocalizations.of(context)!.email,
                          hint: AppLocalizations.of(context)!.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      _spacing(
                        AppTextField(
                          controller: viewModel.phoneController,
                          label: AppLocalizations.of(context)!.phone,
                          hint: AppLocalizations.of(context)!.phone,
                        ),
                      ),
                      _spacing(
                        AppTextField(
                          controller: viewModel.customActionController,
                          label: AppLocalizations.of(context)!.customAction,
                          hint: AppLocalizations.of(context)!.customAction,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.visibility,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<bool>(
                        focusColor: AppColors.whiteColor,
                        dropdownColor: AppColors.whiteColor,
                        value: isVisible,
                        decoration: InputDecoration(
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
                            child: Text(AppLocalizations.of(context)!.visible),
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
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(
                    AppLocalizations.of(context)!.cancle,
                    style: const TextStyle(color: AppColors.grayColor),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final name = viewModel.nameController.text;
                    final email = viewModel.emailController.text;
                    final phone = viewModel.phoneController.text;
                    final action = viewModel.customActionController.text;

                    if (name.isEmpty || email.isEmpty || action.isEmpty) {
                      _showStatusDialog(
                        context,
                        AppLocalizations.of(context)!.error,
                        "Please fill all required fields",
                        isError: true,
                      );
                      return;
                    }

                    final success = await viewModel.addStaffMember(
                      name,
                      email,
                      phone.isEmpty ? null : phone,
                      action,
                      isVisible,
                    );

                    if (context.mounted) {
                      Navigator.pop(dialogContext);
                      if (success) {
                        _showStatusDialog(
                          context,
                          AppLocalizations.of(context)!.success,
                          "Staff member added successfully",
                        );
                        viewModel.getStaffMembers();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.ok,
                    style: const TextStyle(color: AppColors.secondaryColor),
                  ),
                ),
              ],
            );
          },
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
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  List<PrimaryTableColumn<StaffMemberEntity>> _buildColumns(
    BuildContext context,
  ) {
    final local = AppLocalizations.of(context)!;
    return [
      _column(local.name, (item) => item.name ?? local.notAvailable),
      _column(local.email, (item) => item.email ?? local.notAvailable),
      _column(local.phone, (item) => item.phone ?? local.notAvailable),
      _column(
        local.customAction,
        (item) => item.customAction ?? local.notAvailable,
      ),
      _column(
        local.visibility,
        (item) => item.visibility == true ? local.visible : local.hidden,
      ),
      _column(local.index, (item) => item.index.toString()),
    ];
  }

  PrimaryTableColumn<StaffMemberEntity> _column(
    String title,
    String Function(StaffMemberEntity) mapper,
  ) {
    return PrimaryTableColumn<StaffMemberEntity>(
      title: title,
      cellBuilder: (item) => Text(
        mapper(item),
        style: const TextStyle(fontSize: 18, color: Color(0xFF222222)),
      ),
    );
  }

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);
}
