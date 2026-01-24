import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
import 'package:pilates_dashboard/app/core/theme/app_theme.dart';
import 'package:pilates_dashboard/app/core/utils/app_validation.dart';
import 'package:pilates_dashboard/app/features/auth/signup/presentation/view_model/signup_states.dart';
import 'package:pilates_dashboard/app/features/auth/signup/presentation/view_model/signup_view_model.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/app/reusable_widgets/loading_dialog.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  final SignupViewModel viewModel = getIt<SignupViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => viewModel,
      child: BlocConsumer<SignupViewModel, SignupStates>(
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.signupState?.isLoading == true) {
              LoadingDialog(message: AppLocalizations.of(context)!.signup);
            } else if (state.signupState?.data != null) {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, Routes.signinScreen);
            } else if (state.signupState?.errorMessage != null) {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.signupState!.errorMessage!)),
              );
            }
          });
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.signup,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                        ),
                        const SizedBox(height: 30),

                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: viewModel.firstNameController,
                                label: AppLocalizations.of(context)!.firstName,
                                hint: AppLocalizations.of(
                                  context,
                                )!.enterYourFirstName,
                                validator: (v) =>
                                    AppValidators.validateFirstName(v, context),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: AppTextField(
                                controller: viewModel.lastNameController,
                                label: AppLocalizations.of(context)!.lastName,
                                hint: AppLocalizations.of(
                                  context,
                                )!.enterYourLastName,
                                validator: (v) =>
                                    AppValidators.validateLastName(v, context),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: viewModel.emailController,
                          label: AppLocalizations.of(context)!.email,
                          hint: AppLocalizations.of(context)!.enterYourEmail,
                          validator: (v) =>
                              AppValidators.validateEmail(v, context),
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: viewModel.passwordController,
                                label: AppLocalizations.of(context)!.password,
                                hint: AppLocalizations.of(
                                  context,
                                )!.enterYourPassword,
                                isPassword: true,
                                validator: (v) =>
                                    AppValidators.validatePassword(v, context),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: AppTextField(
                                controller: viewModel.confirmPasswordController,
                                label: AppLocalizations.of(
                                  context,
                                )!.confirmPassword,
                                hint: AppLocalizations.of(
                                  context,
                                )!.enterYourPassword,
                                isPassword: true,
                                validator: (v) =>
                                    AppValidators.validateConfirmPassword(
                                      v,
                                      viewModel.passwordController.text,
                                      context,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                controller: viewModel.phoneNumberController,
                                label: AppLocalizations.of(
                                  context,
                                )!.phoneNumber,
                                hint: AppLocalizations.of(
                                  context,
                                )!.enterYourPhoneNumber,
                                validator: (v) =>
                                    AppValidators.validateNumberPhone(
                                      v,
                                      context,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: AppTextField(
                                controller: viewModel.roleController,
                                label: AppLocalizations.of(context)!.role,
                                hint: AppLocalizations.of(
                                  context,
                                )!.enterYourRole,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: state.signupState?.isLoading == true
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      viewModel.signup(
                                        viewModel.emailController.text,
                                        viewModel.passwordController.text,
                                        viewModel.firstNameController.text,
                                        viewModel.lastNameController.text,
                                        viewModel.phoneNumberController.text,
                                        viewModel.roleController.text,
                                      );
                                    }
                                  },
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.alreadyHaveAnAccount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.signinScreen,
                                    (route) => false,
                                  ),
                              child: Text(AppLocalizations.of(context)!.login),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
