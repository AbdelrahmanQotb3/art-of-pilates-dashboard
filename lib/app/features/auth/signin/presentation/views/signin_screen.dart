import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
import 'package:pilates_dashboard/app/core/theme/app_theme.dart';
import 'package:pilates_dashboard/app/core/utils/app_validation.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/view_model/signin_events.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/view_model/signin_states.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/view_model/signin_view_model.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class SigninScreen extends StatelessWidget {
  final SigninViewModel viewModel = getIt<SigninViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SigninScreen({super.key});

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
      child: BlocConsumer<SigninViewModel, SigninStates>(
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.signinState?.isLoading == true) {
              _showLoadingDialog(context);
            } else if (state.signinState?.data != null) {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, Routes.homeScreen);
            } else if (state.signinState?.errorMessage != null) {
              if (Navigator.of(context).canPop()) Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.signinState!.errorMessage!)),
              );
            }
          });
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 30),

                        AppTextField(
                          label: AppLocalizations.of(context)!.email,
                          hint: AppLocalizations.of(context)!.enterYourEmail,
                          controller: viewModel.emailController,
                          validator: (v) =>
                              AppValidators.validateEmail(v, context),
                        ),
                        SizedBox(height: 16),

                        AppTextField(
                          label: AppLocalizations.of(context)!.password,
                          hint: AppLocalizations.of(context)!.enterYourPassword,
                          controller: viewModel.passwordController,
                          isPassword: true,
                          validator: (v) =>
                              AppValidators.validatePassword(v, context),
                        ),
                        SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: state.rememberMeChickBox == 1,
                                  onChanged: (value) {
                                    viewModel.doIntent(
                                      RememberMeEvent(),
                                      '',
                                      '',
                                    );
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(context)!.rememberMe,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),

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
                            onPressed: state.signinState?.isLoading == true
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      viewModel.doIntent(
                                        SigninEvent(),
                                        viewModel.emailController.text,
                                        viewModel.passwordController.text,
                                      );
                                    }
                                  },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.dontHaveAnAccount,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(width: 4),
                              InkWell(
                                onTap: () => Navigator.pushReplacementNamed(
                                  context,
                                  Routes.signupScreen,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.signup,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
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

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: 16),
              const Text('Signing in...'),
            ],
          ),
        ),
      ),
    );
  }
}
