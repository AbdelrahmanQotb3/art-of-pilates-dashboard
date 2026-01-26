import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presentation/view_models/contact_details_view_model.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presentation/view_models/contacts_states.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';

class ContactDetails extends StatelessWidget {
  final viewModel = getIt<ContactDetailsViewModel>();
  final int? contactId;

  ContactDetails({super.key, this.contactId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactDetailsViewModel>(
      create: (context) {
        if (contactId != null) {
          viewModel.contactId = contactId;
          viewModel.getContact(contactId!);
        }
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: _buildAppBar(context),
        body: BlocConsumer<ContactDetailsViewModel, ContactsStates>(
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
          builder: (context, state) {
            final viewModel = context.read<ContactDetailsViewModel>();
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
                  _buildActionButtons(context, data, viewModel),
                ],
              ),
            );
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

  Widget _buildActionButtons(
    BuildContext context,
    dynamic data,
    ContactDetailsViewModel viewModel,
  ) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showEditDialog(context, data, viewModel),
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
              final isDeleted = await viewModel.deleteContact(contactId!);
              if (isDeleted) {
                _showStatusDialog(
                  context,
                  title: 'Success',
                  message: 'Contact deleted successfully!',
                  isSuccess: true,
                );
              } else {
                _showStatusDialog(
                  context,
                  title: 'Error',
                  message: 'Failed to delete contact.',
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

  void _showEditDialog(
    BuildContext context,
    dynamic currentData,
    ContactDetailsViewModel viewModel,
  ) {
    viewModel.firstNameController.text = currentData?.firstName;
    viewModel.lastNameController.text = currentData?.lastName ?? '';
    viewModel.emailController.text = currentData?.email ?? '';
    viewModel.phoneController.text = currentData?.phoneNumber ?? '';
    viewModel.cityController.text = currentData?.addressCity ?? '';
    viewModel.countryController.text = currentData?.addressCountry ?? '';

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
                      controller: viewModel.phoneController,
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
              onPressed: () => Navigator.pop(context),
              child: Text(
                AppLocale(context).cancle,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (contactId == null) return;
                final bool isUpdate = await viewModel.updateContact(
                  contactId!,
                  viewModel.firstNameController.text,
                  viewModel.lastNameController.text,
                  viewModel.emailController.text,
                  viewModel.phoneController.text,
                  viewModel.cityController.text,
                  viewModel.countryController.text,
                );
                Navigator.pop(context);
                if (isUpdate) {
                  _showStatusDialog(
                    context,
                    title: 'Success',
                    message: 'Contact updated successfully!',
                    isSuccess: true,
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

  Widget _spacing(Widget child) =>
      Padding(padding: const EdgeInsets.only(bottom: 16), child: child);

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      title: Text(
        AppLocale(context).contactDetails,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
