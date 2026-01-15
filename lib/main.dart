import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pilates_dashboard/app/core/routes/pages.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: Routes.loginScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: child,
      ),
    );
  }
}
