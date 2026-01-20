import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contact_details_view_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presntation/view_models/contacts_states.dart';

class ContactDetails extends StatelessWidget {
  final int? contactId;
  final ContactDetailsViewModel viewModel = getIt<ContactDetailsViewModel>();

  ContactDetails({super.key, this.contactId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) {
          viewModel.contactId = contactId;
          if (contactId != null) {
            viewModel.getContact(contactId!);
          }
          return viewModel;
        },
        child: BlocConsumer<ContactDetailsViewModel, ContactsStates>(
          builder: (context, state) {
            final data = state.contactState?.data;

            if (state.contactState?.isLoading == true && data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, data),
                  const SizedBox(height: 32),
                  _buildActionButtons(context),
                ],
              ),
            );
          },
          listener: (context, state) {
            if (state.contactState?.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.contactState!.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, dynamic data) {
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
              label: AppLocale(context).firstName,
              value: data?.firstName,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.person_outline,
              label: AppLocale(context).lastName,
              value: data?.lastName,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.email_outlined,
              label: AppLocale(context).email,
              value: data?.email,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.phone_android_outlined,
              label: AppLocale(context).phoneNumber,
              value: data?.phoneNumber,
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

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
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
            onPressed: () {},
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
        AppLocale(context).contactDetails,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: Colors.grey.shade200),
      ),
    );
  }
}
