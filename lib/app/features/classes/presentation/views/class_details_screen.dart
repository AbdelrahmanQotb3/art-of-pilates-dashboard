import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/view_model/classes_states.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/view_model/classes_view_model.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/loading_dialog.dart';

class ClassDetailsScreen extends StatelessWidget {
  final viewModel = getIt<ClassesViewModel>();
  final String? classId;

  ClassDetailsScreen({super.key, this.classId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClassesViewModel>(
      create: (context) {
        if (classId != null) {
          viewModel.getOneClass(classId!);
        }
        return viewModel;
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: _buildAppBar(context),
        body: BlocConsumer<ClassesViewModel, ClassesStates>(
          listener: (context, state) {
            if (state.updateClassState?.isLoading == true ||
                state.deleteClassState?.isLoading == true) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoadingDialog(),
              );
            } else {
              if (Navigator.of(context, rootNavigator: true).canPop() &&
                  (state.updateClassState?.isLoading == false ||
                      state.deleteClassState?.isLoading == false)) {
              }
            }

            if (state.oneClassState?.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.oneClassState!.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final data = state.oneClassState?.data;

            if (state.oneClassState?.isLoading == true && data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, data),
                  const SizedBox(height: 32),
                  _buildActionButtons(context, data),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, ClassEntity? data) {
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
              icon: Icons.class_outlined,
              label: AppLocale(context).className,
              value: data?.name,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.label_outline,
              label: AppLocale(context).tagLine,
              value: data?.tagLine,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.payments_outlined,
              label: AppLocale(context).price,
              value: data?.price != null ? "${data!.price} SAR" : null,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.location_on_outlined,
              label: AppLocale(context).location,
              value: data?.location,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.groups_outlined,
              label: AppLocale(context).capacity,
              value: data?.maxParticipations,
            ),
            const Divider(height: 32),
            _buildDetailItem(
              icon: Icons.description_outlined,
              label: "Description",
              value: data?.description,
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

  Widget _buildActionButtons(BuildContext context, ClassEntity? data) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _showEditClassDialog(context, data),
            icon: const Icon(Icons.edit, size: 18),
            label: Text(AppLocale(context).edit),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              if (data?.id == null) return;
              final isDeleted = await viewModel.deleteClass(
                id: data!.id.toString(),
              );
              if (isDeleted && context.mounted) {
                _showStatusDialog(
                  context,
                  title: "Deleted",
                  message: "Class deleted successfully.",
                  isSuccess: true,
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

  void _showEditClassDialog(BuildContext context, ClassEntity? data) {
    if (data == null) return;

    viewModel.nameController.text = data.name ;
    viewModel.priceController.text = data.price?.toString() ?? "";
    viewModel.tagLineController.text = data.tagLine ?? "";
    viewModel.locationController.text = data.location ?? "";
    viewModel.capacityController.text =
        data.maxParticipations?.toString() ?? "";
    viewModel.descriptionController.text = data.description ?? "";

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text("${AppLocale(context).edit} ${data.name}"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: viewModel.nameController,
                  label: AppLocale(context).className,
                  hint: data.name,
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: viewModel.priceController,
                  label: AppLocale(context).price,
                  keyboardType: TextInputType.number,
                  hint: data.price.toString(),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: viewModel.capacityController,
                  label: AppLocale(context).capacity,
                  keyboardType: TextInputType.number,
                  hint: data.maxParticipations.toString(),
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: viewModel.tagLineController,
                  label: AppLocale(context).tagLine,
                  hint: data.tagLine ?? "Enter Tag Line",
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: viewModel.locationController,
                  label: AppLocale(context).location,
                  hint: data.location ?? "Enter Location",
                ),
                const SizedBox(height: 12),
                AppTextField(
                  controller: viewModel.descriptionController,
                  label: "Description",
                  hint: data.description ?? "Enter Description",
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("Cancle"),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await viewModel.updateClass(
                id: data.id.toString(),
                name: viewModel.nameController.text,
                price: double.tryParse(viewModel.priceController.text),
                tagLine: viewModel.tagLineController.text,
                location: viewModel.locationController.text,
                maxParticipants: int.tryParse(
                  viewModel.capacityController.text,
                ),
                description: viewModel.descriptionController.text,
              );

              if (success && context.mounted) {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
                viewModel.getOneClass(data.id.toString());
                _showStatusDialog(
                  context,
                  title: "Updated",
                  message: "Class updated successfully",
                  isSuccess: false,
                );
              }
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
      title: const Text(
        "Class Details",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              if (isSuccess)
                Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
