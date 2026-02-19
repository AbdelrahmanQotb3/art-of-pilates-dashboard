import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilates_dashboard/app/config/di/di.dart';
import 'package:pilates_dashboard/app/core/colors/app_colors.dart';
import 'package:pilates_dashboard/app/core/routes/routes.dart';
import 'package:pilates_dashboard/app/features/auth/signout/presentation/view_model/signout_state.dart';
import 'package:pilates_dashboard/app/features/auth/signout/presentation/view_model/signout_view_model.dart';
import 'package:pilates_dashboard/app/features/classes/presentation/views/classes_tab.dart';
import 'package:pilates_dashboard/app/features/contacts_tab/presentation/views/contacts_tab.dart';
import 'package:pilates_dashboard/app/features/tabs/discounts_tab.dart';
import 'package:pilates_dashboard/app/features/tabs/invoices_tab.dart';
import 'package:pilates_dashboard/app/features/pricing_plans_tab/presentation/views/pricing_plans_tab.dart';
import 'package:pilates_dashboard/app/features/services/presentation/views/services_tab.dart';
import 'package:pilates_dashboard/app/features/tabs/sessions_tab.dart';
import 'package:pilates_dashboard/app/features/staff_tab/presentation/views/staff_tab.dart';
import 'package:pilates_dashboard/app/features/tabs/subscriptions_tab.dart';
import 'package:pilates_dashboard/app/reusable_widgets/app_text_field.dart';
import 'package:pilates_dashboard/l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  final SignoutViewModel signoutViewModel = getIt<SignoutViewModel>();
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  int currentTabIndex = 0;

  late final List<Widget> sideBarTabs = [
    ClassesTab(),
    const SessionsTab(),
    const SubscriptionsTab(),
    const ServicesTab(),
    const PricingPlansTab(),
    const DiscountsTab(),
    const InvoicesTab(),
    ContactsTab(),
    StaffTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSideBar(context),
          Expanded(
            child: Container(
              color: AppColors.secondaryColor,
              child: sideBarTabs[currentTabIndex],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Text(
            AppLocalizations.of(context)!.artOfPilates,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: SizedBox(
                height: 40,
                child: AppTextField(
                  controller: searchController,
                  label: AppLocalizations.of(context)!.search,
                  hint: AppLocalizations.of(context)!.search,
                  backGroundColor: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.profileScreen);
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.whiteColor,
              child: Icon(Icons.person, color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBar(BuildContext context) {
    final List<String> titles = [
      AppLocalizations.of(context)!.classes,
      AppLocalizations.of(context)!.sessions,
      AppLocalizations.of(context)!.subscriptions,
      AppLocalizations.of(context)!.services,
      AppLocalizations.of(context)!.pricingPlans,
      AppLocalizations.of(context)!.discounts,
      AppLocalizations.of(context)!.invoices,
      AppLocalizations.of(context)!.contacts,
      AppLocalizations.of(context)!.staff,
    ];

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: titles.length,
              itemBuilder: (context, index) {
                return _buildSideBarItem(
                  title: titles[index],
                  index: index,
                  isSelected: currentTabIndex == index,
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocProvider(
              create: (context) => widget.signoutViewModel,
              child: BlocConsumer<SignoutViewModel, SignoutState>(
                listener: (context, state) {
                  if (state.signoutState?.data != null) {
                    Navigator.pushReplacementNamed(context, Routes.signinScreen);
                  }
                  if (state.signoutState?.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.signoutState!.errorMessage!)),
                    );
                  }
                },
                builder: (context, state) {
                  final bool isLoading = state.signoutState?.isLoading ?? false;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () => context.read<SignoutViewModel>().signout(),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBarItem({
    required String title,
    required int index,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() {
            currentTabIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? AppColors.primaryColor
                  : Colors.blueGrey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}