import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/domain/model/contacts_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contacts_states.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contacts_view_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/views/contact_details.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/loading_dialog.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class ContactsTab extends StatelessWidget {
  final ContactsViewModel viewModel = getIt<ContactsViewModel>();

  ContactsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..doIntent(),
      child: BlocConsumer<ContactsViewModel, ContactsStates>(
        builder: (context, state) {
          final contacts = state.contactsState?.data?.contacts ?? [];

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: viewModel.searchController,
                        label: AppLocale(context).search,
                        hint: AppLocale(context).search,
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => _showAddContactDialog(context),
                      icon: const Icon(Icons.add, color: AppColors.whiteColor),
                      label: Text(AppLocalizations.of(context)!.addContact),
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
                  child: PrimaryTable<ContactEntity>(
                    columns: _buildColumns(context),
                    items: contacts,
                    cellPadding: const EdgeInsets.all(8),
                    showBorder: true,
                    isSelectable: true,
                    rowHeight: 80,
                    onRowTap: (item) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactDetails(contactId: item.id),
                        ),
                      );
                      viewModel.getContacts();
                    },
                  ),
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          final contactStatus = state.contactsState;
          if (contactStatus?.isLoading == true) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(),
            );
          } else {
            if (contactStatus?.data != null ||
                contactStatus?.errorMessage != null) {
              if (Navigator.of(context, rootNavigator: true).canPop()) {
                Navigator.of(context, rootNavigator: true).pop();
              }
            }
          }
          if (contactStatus?.errorMessage != null) {
            _showStatusDialog(
              context,
              AppLocalizations.of(context)!.error,
              contactStatus!.errorMessage!,
              isError: true,
            );
          }
        },
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    viewModel.reset();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.addContact),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _spacing(
                    AppTextField(
                      controller: viewModel.firstNameController,
                      label: AppLocale(context).firstName,
                      hint: AppLocale(context).firstName,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.lastNameController,
                      label: AppLocale(context).lastName,
                      hint: AppLocale(context).lastName,
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
                      controller: viewModel.phoneNumberController,
                      label: AppLocale(context).phoneNumber,
                      hint: AppLocale(context).phoneNumber,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.cityController,
                      label: AppLocale(context).city,
                      hint: AppLocale(context).city,
                    ),
                  ),
                  _spacing(
                    AppTextField(
                      controller: viewModel.countryController,
                      label: AppLocale(context).country,
                      hint: AppLocale(context).country,
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
                final isCreated = await viewModel.createContact(
                  viewModel.firstNameController.text,
                  viewModel.lastNameController.text,
                  viewModel.emailController.text,
                  viewModel.phoneNumberController.text,
                  viewModel.cityController.text,
                  viewModel.countryController.text,
                );
                if (context.mounted) {
                  Navigator.pop(dialogContext);
                  if (isCreated) {
                    _showStatusDialog(
                      context,
                      AppLocalizations.of(context)!.addContact,
                      AppLocale(context).addContactSuccess,
                    );
                    viewModel.getContacts();
                  } else {
                    _showStatusDialog(
                      context,
                      AppLocalizations.of(context)!.addContact,
                      AppLocale(context).addContactFail,
                      isError: true,
                    );
                  }
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

  List<PrimaryTableColumn<ContactEntity>> _buildColumns(BuildContext context) {
    return [
      _column(
        AppLocalizations.of(context)!.firstName,
        (item) => item.firstName.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.lastName,
        (item) => item.lastName.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.email,
        (item) => item.email.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.phoneNumber,
        (item) => item.phoneNumber.toString(),
      ),
      _column(
        AppLocalizations.of(context)!.address,
        (item) => item.addressCity.toString(),
      ),
    ];
  }

  PrimaryTableColumn<ContactEntity> _column(
    String title,
    String Function(ContactEntity) mapper,
  ) {
    return PrimaryTableColumn<ContactEntity>(
      title: title,
      cellBuilder: (item) => Text(
        mapper(item),
        style: const TextStyle(fontSize: 16, color: Color(0xFF222222)),
      ),
    );
  }

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);
}
