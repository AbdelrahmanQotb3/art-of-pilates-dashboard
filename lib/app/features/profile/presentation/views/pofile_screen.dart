import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/features/profile/domain/model/user_model.dart';
import 'package:pilates_dashboard/app/features/profile/presentation/view_model/user_view_model.dart';
import 'package:pilates_dashboard/app/features/profile/presentation/view_model/user_states.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  final UserViewModel userViewModel = getIt<UserViewModel>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userViewModel..getUser(),
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: BlocBuilder<UserViewModel, UserStates>(
          builder: (context, state) {
            final userState = state.userState;

            // Using null-aware operators to prevent crashes if state isn't initialized
            if (userState?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userState?.errorMessage != null) {
              return _buildErrorUI(userState!.errorMessage!, context);
            }

            if (userState?.data != null) {
              return _buildProfileContent(context, userState!.data!);
            }

            return const Center(child: Text("No User Data"));
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.accountSettings,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins",
            ),
          ),
          const SizedBox(height: 32),
          _buildHeaderCard(context, user),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _buildInfoTile(AppLocalizations.of(context)!.email, user.email ?? "N/A", Icons.email_outlined),
              _buildInfoTile(AppLocalizations.of(context)!.role, user.role ?? "User", Icons.admin_panel_settings_outlined),
              _buildInfoTile(AppLocalizations.of(context)!.id, "#${user.id}", Icons.fingerprint),
              _buildInfoTile(AppLocalizations.of(context)!.firstName, user.firstName ?? "N/A", Icons.person_outline),
              _buildInfoTile(AppLocalizations.of(context)!.lastName, user.lastName ?? "N/A", Icons.person_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context, UserModel user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primaryColor.withOpacity(0.1),
            // child: user.profileImage != null ? Image.network(user.profileImage!) : Text(
            //   user.firstName?[0].toUpperCase() ?? "U",
            //   style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            // ),

            child: Text(
              user.firstName?[0].toUpperCase() ?? "U",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${user.firstName ?? ''} ${user.lastName ?? ''}",
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(user.email ?? "", style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => _showEditProfileDialog(context, user),
            icon: const Icon(Icons.edit, size: 18),
            label: Text(AppLocalizations.of(context)!.editProfile),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  // --- EDIT PROFILE DIALOG ---
  void _showEditProfileDialog(BuildContext context, UserModel user) {
    final fNameController = TextEditingController(text: user.firstName);
    final lNameController = TextEditingController(text: user.lastName);
    final emailController = TextEditingController(text: user.email);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: userViewModel, // Pass existing VM to dialog
          child: BlocConsumer<UserViewModel, UserStates>(
            listenWhen: (prev, curr) => prev.editUserState?.isLoading != curr.editUserState?.isLoading,
            listener: (context, state) {
              if (state.editUserState?.data != null && !(state.editUserState?.isLoading ?? true)) {
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated!")));
                userViewModel.getUser(); // Refresh data
              }
            },
            builder: (context, state) {
              final isUpdating = state.editUserState?.isLoading ?? false;
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.editProfile),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDialogField(fNameController, AppLocalizations.of(context)!.firstName),
                      const SizedBox(height: 12),
                      _buildDialogField(lNameController, AppLocalizations.of(context)!.lastName),
                      const SizedBox(height: 12),
                      _buildDialogField(emailController, AppLocalizations.of(context)!.email),
                    ],
                  ),
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("Cancel")),
                  ElevatedButton(
                    onPressed: isUpdating ? null : () {
                      if (formKey.currentState!.validate()) {
                        userViewModel.updateUser(fNameController.text, lNameController.text, emailController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                    child: isUpdating 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDialogField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (val) => val!.isEmpty ? "Required" : null,
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorUI(String error, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(error),
          TextButton(onPressed: () => userViewModel.getUser(), child: const Text("Retry")),
        ],
      ),
    );
  }
}