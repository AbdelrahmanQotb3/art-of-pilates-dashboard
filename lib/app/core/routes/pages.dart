import 'package:flutter/material.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
import 'package:pilates_dashboard/app/features/auth/signin/presentation/views/signin_screen.dart';
import 'package:pilates_dashboard/app/features/auth/signup/presentation/views/signup_screen.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presentation/views/contact_details.dart';
import 'package:pilates_dashboard/app/features/home/presentation/views/home_screen.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/views/pricing_plan_details_screen.dart';
import 'package:pilates_dashboard/app/features/profile/presentation/views/pofile_screen.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/views/staff_member_detail_screen.dart';

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
      case Routes.pricingPlanDetailsScreen:
        return MaterialPageRoute(builder: (_) => PricingPlanDetailsScreen());
      case Routes.staffDetailsScreen:
        return MaterialPageRoute(builder: (_) => StaffMemberDetailScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
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
