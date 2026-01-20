import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
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
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: PrimaryTable<ContactEntity>(
                    columns: [
                      PrimaryTableColumn<ContactEntity>(
                        title: AppLocalizations.of(context)!.firstName,
                        cellBuilder: (item) => Text(
                          item.firstName.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                      PrimaryTableColumn<ContactEntity>(
                        title: AppLocalizations.of(context)!.lastName,
                        cellBuilder: (item) => Text(
                          item.lastName.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                      PrimaryTableColumn<ContactEntity>(
                        title: AppLocalizations.of(context)!.email,
                        cellBuilder: (item) => Text(
                          item.email.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                      PrimaryTableColumn<ContactEntity>(
                        title: AppLocalizations.of(context)!.phoneNumber,
                        cellBuilder: (item) => Text(
                          item.phoneNumber.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                      PrimaryTableColumn<ContactEntity>(
                        title: AppLocalizations.of(context)!.address,
                        cellBuilder: (item) => Text(
                          item.addressCity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF222222),
                          ),
                        ),
                      ),
                    ],
                    items: contacts,
                    cellPadding: const EdgeInsets.all(8),
                    showBorder: true,
                    isSelectable: true,
                    rowHeight: 80,
                    onRowTap: (item) {
                      viewModel.contactId = item.id!;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ContactDetails(contactId: item.id);
                          },
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(contactStatus!.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
