import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/view_model/sessions_view_model.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/view_model/sessions_state.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/views/session_details_screen.dart';
import 'package:pilates_dashboard/app/reusable_widgets/primary_table.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class SessionsTab extends StatelessWidget {
  const SessionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<SessionsViewModel>();
    return BlocProvider(
      create: (context) => viewModel..getSessions(),
      child: BlocConsumer<SessionsViewModel, SessionsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final sessions = state.sessionsState?.data?.sessions ?? [];
          final isLoading = state.sessionsState?.isLoading ?? false;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: AppLocale(context).search,
                          hintText: AppLocale(context).search,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : PrimaryTable<SessionEntity>(
                          columns: [
                            PrimaryTableColumn<SessionEntity>(
                              title: AppLocalizations.of(context)!.session,
                              cellBuilder: (s) => Text(s.serviceName ?? s.staffName ?? ''),
                            ),
                            PrimaryTableColumn<SessionEntity>(
                              title: AppLocalizations.of(context)!.name,
                              cellBuilder: (s) => Text(s.staffName ?? ''),
                            ),
                            PrimaryTableColumn<SessionEntity>(
                              title: AppLocalizations.of(context)!.startTime,
                              cellBuilder: (s) => Text(s.startTime ?? ''),
                            ),
                            PrimaryTableColumn<SessionEntity>(
                              title: AppLocalizations.of(context)!.endTime,
                              cellBuilder: (s) => Text(s.endTime ?? ''),
                            ),
                          ],
                          rowHeight: 72,
                          items: sessions,
                          onRowTap: (item) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    SessionDetailsScreen(session: item),
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
}
