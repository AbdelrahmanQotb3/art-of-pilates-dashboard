import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilates_dashboard/app/core/theme/app_theme.dart';
import 'package:pilates_dashboard/app/core/utils/app_validation.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget? _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Email Field
                  AppTextField(
                    label: AppLocalizations.of(context)!.email,
                    hint: AppLocalizations.of(context)!.enterYourEmail,
                    controller: TextEditingController(), // Placeholder
                    validator: (value) =>
                        AppValidators.validateEmail(value, context),
                  ),
                  SizedBox(height: 12.h),

                  // Password Field
                  AppTextField(
                    label: AppLocalizations.of(context)!.password,
                    hint: AppLocalizations.of(context)!.enterYourPassword,
                    controller: TextEditingController(), // Placeholder
                    isPassword: true,
                    validator: (value) =>
                        AppValidators.validatePassword(value, context),
                  ),

                  // Remember Me & Forgot Password Row
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              Checkbox(
                                value: false, // Default UI state
                                onChanged: (value) {},
                              ),
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!.rememberMe,
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)!.forgotPassword,
                            style: AppTheme.lightTheme.textTheme.bodySmall!
                                .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Login Button
                  Center(
                    child: SizedBox(
                      width: 500,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            AppTheme.lightTheme.colorScheme.primary,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: AppTheme.lightTheme.textTheme.titleMedium!
                              .copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Signup Link
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAnAccount,
                          style: AppTheme.lightTheme.textTheme.bodySmall!
                              .copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(width: 4),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)!.signup,
                            style: AppTheme.lightTheme.textTheme.bodySmall!
                                .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      AppTheme.lightTheme.colorScheme.primary,
                                  color:
                                      AppTheme.lightTheme.colorScheme.primary,
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
  }
}
