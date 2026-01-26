import 'package:flutter/material.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/views/signin_screen.dart';
import 'package:pilates_dashboard/app/features/auth/signup/presentation/views/signup_screen.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presentation/views/contact_details.dart';
import 'package:pilates_dashboard/app/features/home/presentation/views/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signinScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.contactDetailsScreen:
        return MaterialPageRoute(builder: (_) => ContactDetails());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: Center(child: Text('No Route Found')),
      ),
    );
  }
}
