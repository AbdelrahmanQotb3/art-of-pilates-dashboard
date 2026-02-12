import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/base_response/base_response.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/app/features/classes/domain/model/get_classes_model.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/view_model/classes_states.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/view_model/classes_view_model.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/views/class_details_screen.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/loading_dialog.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class ClassesTab extends StatelessWidget {
  final ClassesViewModel viewModel = getIt<ClassesViewModel>();

  ClassesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel..getClasses(),
      child: BlocConsumer<ClassesViewModel, ClassesStates>(
        listener: (context, state) {
          final isGlobalLoading = (state.classesState?.isLoading == true) || 
                                 (state.addClassState?.isLoading == true);

          if (isGlobalLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(),
            );
          } else {
            if (Navigator.of(context, rootNavigator: true).canPop()) {
              Navigator.of(context, rootNavigator: true).pop();
            }
          }
          String? error = state.classesState?.errorMessage ?? state.addClassState?.errorMessage;
          if (error != null) {
            _showStatusDialog(
              context,
              title : AppLocale(context).error,
              message: error,
              isSuccess: false,
            );
          }
        },
        builder: (context, state) {
          final classesList = state.classesState?.data?.classes ?? [];

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
                        onChanged: (value) {},
                        controller: viewModel.searchController,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => _showAddClassDialog(context),
                      icon: const Icon(Icons.add, color: AppColors.whiteColor),
                      label: Text(AppLocalizations.of(context)!.addClass),
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
                  child: PrimaryTable<ClassEntity>(
                    columns: _buildColumns(context),
                    items: classesList,
                    cellPadding: const EdgeInsets.all(8),
                    showBorder: true,
                    isSelectable: true,
                    rowHeight: 80,
                    onRowTap: (item) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ClassDetailsScreen(classId: item.id.toString()),
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

  void _showAddClassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.addClass),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextField(
                        controller: viewModel.nameController,
                        label: AppLocalizations.of(context)!.className,
                        hint: "e.g. Reformer Pilates",
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              controller: viewModel.priceController,
                              label: AppLocalizations.of(context)!.price,
                              hint: "0.00",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppTextField(
                              controller: viewModel.capacityController,
                              label: AppLocalizations.of(context)!.capacity,
                              hint: "10",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: viewModel.tagLineController,
                        label: AppLocalizations.of(context)!.tagLine,
                        hint: "Short subtitle",
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: viewModel.locationController,
                        label: AppLocalizations.of(context)!.location,
                        hint: "Studio Room",
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        controller: viewModel.descriptionController,
                        label: "Description",
                        hint: "Class details...",
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text("Cancle", style: const TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                  onPressed: () async {
                    if (viewModel.nameController.text.isEmpty) return;

                    final response = await viewModel.addClass(
                      name: viewModel.nameController.text,
                      price: double.tryParse(viewModel.priceController.text),
                      tagLine: viewModel.tagLineController.text,
                      location: viewModel.locationController.text,
                      maxParticipants: int.tryParse(viewModel.capacityController.text),
                      description: viewModel.descriptionController.text,
                    );
                    if (response is SuccessResponse) {
                      Navigator.pop(dialogContext);
                      _showStatusDialog(context,isSuccess: true , message: "Class Added Succeffully" , title: "Success");
                      viewModel.getClasses();
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.addClass, style: const TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<PrimaryTableColumn<ClassEntity>> _buildColumns(BuildContext context) {
    return [
      _column(AppLocalizations.of(context)!.className, (item) => item.name),
      _column(AppLocalizations.of(context)!.tagLine, (item) => item.tagLine ?? "--"),
      _column(AppLocalizations.of(context)!.price, (item) => "${item.price ?? 0} SAR"),
      _column(AppLocalizations.of(context)!.location, (item) => item.location ?? ""),
      _column(AppLocalizations.of(context)!.capacity, (item) => item.maxParticipations?.toString() ?? "0"),
    ];
  }

  PrimaryTableColumn<ClassEntity> _column(String title, String Function(ClassEntity) mapper) {
    return PrimaryTableColumn<ClassEntity>(
      title: title,
      cellBuilder: (item) => Text(
        mapper(item),
        style: const TextStyle(fontSize: 16, color: Color(0xFF222222)),
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
  }}