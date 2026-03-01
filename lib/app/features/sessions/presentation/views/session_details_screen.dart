import 'package:flutter/material.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/features/sessions/domain/model/sessions_model.dart';
import 'package:pilates_dashboard/app/features/sessions/presentation/view_model/sessions_view_model.dart';
import 'package:pilates_dashboard/app/core/utils/app_locale.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class SessionDetailsScreen extends StatelessWidget {
  final SessionEntity session;
  final viewModel = getIt<SessionsViewModel>();

  SessionDetailsScreen({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    viewModel.startController.text = session.startTime ?? '';
    viewModel.endController.text = session.endTime ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.session)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.session} ID: ${session.id ?? '-'}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context)!.serviceName}: ${session.serviceName ?? '-'}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context)!.name}: ${session.staffName ?? '-'}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context)!.startTime}: ${session.startTime ?? '-'}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context)!.endTime}: ${session.endTime ?? '-'}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: Text(AppLocale(context).edit),
                    onPressed: () => _showEditDialog(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.delete_outline),
                    label: Text(AppLocale(context).delete),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.delete),
                          content: Text(
                            AppLocalizations.of(context)!.areYouSure,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(AppLocale(context).cancle),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(AppLocale(context).ok),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        final success = await viewModel.deleteSession(
                          session.id ?? '',
                        );
                        if (success) {
                          if (context.mounted) Navigator.pop(context);
                        } else {
                          if (context.mounted)
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text(
                                  AppLocalizations.of(context)!.error,
                                ),
                                content: const Text('Failed to delete'),
                              ),
                            );
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(AppLocale(context).edit),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: viewModel.startController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.startTime,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: viewModel.endController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.endTime,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocale(context).cancle),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  final startText = viewModel.startController.text;
                  final endText = viewModel.endController.text;
                  final start = startText.isNotEmpty
                      ? DateTime.parse(startText)
                      : null;
                  final end = endText.isNotEmpty
                      ? DateTime.parse(endText)
                      : null;
                  final updated = await viewModel.updateSession(
                    session.id ?? '',
                    start,
                    end,
                    session.serviceId,
                    session.staffMemberId,
                  );
                  Navigator.pop(context);
                  if (updated) {
                    if (context.mounted)
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.success),
                          content: Text(
                            AppLocalizations.of(context)!.updatedSuccessfully,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppLocale(context).ok),
                            ),
                          ],
                        ),
                      );
                  } else {
                    if (context.mounted)
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(AppLocalizations.of(context)!.error),
                          content: const Text('Update failed'),
                        ),
                      );
                  }
                } catch (e) {
                  if (context.mounted)
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(AppLocalizations.of(context)!.error),
                        content: Text(
                          AppLocalizations.of(context)!.somethingWentWrong,
                        ),
                      ),
                    );
                }
              },
              child: Text(AppLocale(context).ok),
            ),
          ],
        );
      },
    );
  }
}
