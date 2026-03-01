// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../core/utils/session_manager.dart' as _i976;
import '../../features/auth/signin/api/api_client/signin_api_client.dart'
    as _i297;
import '../../features/auth/signin/api/data_sorce_impl/signin_data_source_impl.dart'
    as _i682;
import '../../features/auth/signin/data/data_source/signin_data_source_contract.dart'
    as _i519;
import '../../features/auth/signin/data/repo/signin_repo_impl.dart' as _i683;
import '../../features/auth/signin/domain/repo/signin_repo_contract.dart'
    as _i857;
import '../../features/auth/signin/domain/use_cases/signin_use_case.dart'
    as _i620;
import '../../features/auth/signin/presentation/view_model/signin_view_model.dart'
    as _i66;
import '../../features/auth/signout/api/api_client/signout_api_client.dart'
    as _i244;
import '../../features/auth/signout/api/data_source_impl/signout_data_source_impl.dart'
    as _i483;
import '../../features/auth/signout/data/data_source/signout_data_source_contract.dart'
    as _i904;
import '../../features/auth/signout/data/repo/signout_repo_impl.dart' as _i704;
import '../../features/auth/signout/domain/repo/signout_repo_contract.dart'
    as _i343;
import '../../features/auth/signout/domain/use_case/signout_use_case.dart'
    as _i88;
import '../../features/auth/signout/presentation/view_model/signout_view_model.dart'
    as _i364;
import '../../features/auth/signup/api/api_client/signup_api_client.dart'
    as _i557;
import '../../features/auth/signup/api/data_source_impl/signup_data_source_impl.dart'
    as _i119;
import '../../features/auth/signup/data/data_source/signup_data_source_contract.dart'
    as _i573;
import '../../features/auth/signup/data/repo/signup_repo_impl.dart' as _i767;
import '../../features/auth/signup/domain/repo/signup_repo_contract.dart'
    as _i218;
import '../../features/auth/signup/domain/use_cases/signup_usecase.dart'
    as _i469;
import '../../features/auth/signup/presentation/view_model/signup_view_model.dart'
    as _i733;
import '../../features/classes/api/api_client/classes_api_client.dart' as _i267;
import '../../features/classes/api/data_source_impl/classes_data_source_impl.dart'
    as _i240;
import '../../features/classes/data/data_source/classes_data_source_contract.dart'
    as _i638;
import '../../features/classes/data/repo/classes_repo_impl.dart' as _i1066;
import '../../features/classes/domain/repo/classes_repo_contract.dart' as _i293;
import '../../features/classes/domain/use_cases/classes_use_case.dart' as _i258;
import '../../features/classes/presentation/view_model/classes_view_model.dart'
    as _i312;
import '../../features/contacts_tab/api/api_client/contacts_api_client.dart'
    as _i416;
import '../../features/contacts_tab/api/data_source_impl/contacts_data_source_impl.dart'
    as _i931;
import '../../features/contacts_tab/data/data_source/contacts_data_source_contract.dart'
    as _i709;
import '../../features/contacts_tab/data/repo/contacts_repo_impl.dart' as _i188;
import '../../features/contacts_tab/domain/repo/contacts_repo_contract.dart'
    as _i750;
import '../../features/contacts_tab/domain/use_cases/contacts_use_case.dart'
    as _i391;
import '../../features/contacts_tab/presentation/view_models/contact_details_view_model.dart'
    as _i185;
import '../../features/contacts_tab/presentation/view_models/contacts_view_model.dart'
    as _i672;
import '../../features/pricing_plans_tab/api/api_client/pricing_plans_api_client.dart'
    as _i344;
import '../../features/pricing_plans_tab/api/data_source_impl/pricing_plans_data_source_impl.dart'
    as _i1009;
import '../../features/pricing_plans_tab/data/data_source/pricing_plans_data_source_contract.dart'
    as _i723;
import '../../features/pricing_plans_tab/data/repo/pricing_plans_rep_impl.dart'
    as _i252;
import '../../features/pricing_plans_tab/domain/repo/pricing_plans_repo_contract.dart'
    as _i283;
import '../../features/pricing_plans_tab/domain/use_cases/pricing_plans_use_case.dart'
    as _i106;
import '../../features/pricing_plans_tab/presentation/view_model/pricing_plan_details_view_model.dart'
    as _i613;
import '../../features/pricing_plans_tab/presentation/view_model/pricing_plans_view_model.dart'
    as _i529;
import '../../features/profile/api/api_client/user_api_client.dart' as _i372;
import '../../features/profile/api/data_source/user_data_source_impl.dart'
    as _i292;
import '../../features/profile/data/data_source/user_data_source_contract.dart'
    as _i742;
import '../../features/profile/data/repo/user_repo_impl.dart' as _i265;
import '../../features/profile/domain/repo/user_repo_contract.dart' as _i87;
import '../../features/profile/domain/use_cases/user_use_case.dart' as _i446;
import '../../features/profile/presentation/view_model/user_view_model.dart'
    as _i305;
import '../../features/services/api/api_client/services_api_client.dart'
    as _i173;
import '../../features/services/api/data_source_impl.dart/services_data_source_impl.dart'
    as _i161;
import '../../features/services/data/data_sources/services_data_source_contract.dart'
    as _i398;
import '../../features/services/data/repo/services_repo_impl.dart' as _i83;
import '../../features/services/domain/repo/services_repo_contract.dart'
    as _i726;
import '../../features/services/domain/use_case/services_use_case.dart' as _i77;
import '../../features/services/presentation/view_model/services_view_model.dart'
    as _i902;
import '../../features/sessions/api/api_client/sessions_api_client.dart'
    as _i455;
import '../../features/sessions/api/data_source/sessions_data_source_impl.dart'
    as _i136;
import '../../features/sessions/data/data_source/sessions_data_source_contract.dart'
    as _i1013;
import '../../features/sessions/data/repo/sessions_repo_impl.dart' as _i136;
import '../../features/sessions/domain/repo/sessions_repo_contract.dart'
    as _i622;
import '../../features/sessions/domain/use_cases/sessions_use_case.dart'
    as _i1050;
import '../../features/sessions/presentation/view_model/sessions_view_model.dart'
    as _i301;
import '../../features/staff_tab/api/api_client/staff_api_client.dart' as _i867;
import '../../features/staff_tab/api/data_source_impl/staff_data_source_impl.dart'
    as _i329;
import '../../features/staff_tab/data/data_source/staff_data_source_contract.dart'
    as _i683;
import '../../features/staff_tab/data/repo/staff_members_repo_impl.dart'
    as _i272;
import '../../features/staff_tab/domain/repo/staff_members_repo_contract.dart'
    as _i26;
import '../../features/staff_tab/domain/use_cases/staff_members_use_case.dart'
    as _i523;
import '../../features/staff_tab/presentation/view_model/staff_member_view_model.dart'
    as _i847;
import '../../features/staff_tab/presentation/view_model/staff_members_view_model.dart'
    as _i806;
import '../dio_module/di_model.dart' as _i183;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i361.Dio>(() => dioModule.provideDio());
    gh.factory<_i528.PrettyDioLogger>(() => dioModule.dioLogger());
    gh.lazySingleton<_i976.SessionManager>(() => _i976.SessionManager());
    gh.factory<_i297.SigninApiClient>(
      () => _i297.SigninApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i244.SignoutApiClient>(
      () => _i244.SignoutApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i557.SignupApiClient>(
      () => _i557.SignupApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i267.ClassesApiClient>(
      () => _i267.ClassesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i416.ContactsApiClient>(
      () => _i416.ContactsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i344.PricingPlansApiClient>(
      () => _i344.PricingPlansApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i372.UserApiClient>(() => _i372.UserApiClient(gh<_i361.Dio>()));
    gh.factory<_i173.ServicesApiClient>(
      () => _i173.ServicesApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i455.SessionsApiClient>(
      () => _i455.SessionsApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i867.StaffApiClient>(
      () => _i867.StaffApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i709.ContactsDataSourceContract>(
      () => _i931.ContactsDataSourceImpl(gh<_i416.ContactsApiClient>()),
    );
    gh.factory<_i519.SigninDataSourceContract>(
      () => _i682.SigninDataSourceImpl(gh<_i297.SigninApiClient>()),
    );
    gh.factory<_i750.ContactsRepoContract>(
      () => _i188.ContactsRepoImpl(gh<_i709.ContactsDataSourceContract>()),
    );
    gh.factory<_i1013.SessionsDataSourceContract>(
      () => _i136.SessionsDataSourceImpl(gh<_i455.SessionsApiClient>()),
    );
    gh.factory<_i573.SignupDataSourceContract>(
      () => _i119.SignupDataSourceImpl(gh<_i557.SignupApiClient>()),
    );
    gh.factory<_i857.SigninRepoContract>(
      () => _i683.SigninRepoImpl(gh<_i519.SigninDataSourceContract>()),
    );
    gh.factory<_i398.ServicesDataSourceContract>(
      () => _i161.ServicesDataSourceImpl(gh<_i173.ServicesApiClient>()),
    );
    gh.factory<_i723.PricingPlansDataSourceContract>(
      () =>
          _i1009.PricingPlansDataSourceImpl(gh<_i344.PricingPlansApiClient>()),
    );
    gh.factory<_i904.SignoutDataSourceContract>(
      () => _i483.SignoutDataSourceImpl(gh<_i244.SignoutApiClient>()),
    );
    gh.factory<_i218.SignupRepoContract>(
      () => _i767.SignupRepoImpl(gh<_i573.SignupDataSourceContract>()),
    );
    gh.factory<_i620.SigninUseCase>(
      () => _i620.SigninUseCase(gh<_i857.SigninRepoContract>()),
    );
    gh.factory<_i742.UserDataSourceContract>(
      () => _i292.UserDataSourceImpl(gh<_i372.UserApiClient>()),
    );
    gh.factory<_i638.ClassesDataSourceContract>(
      () => _i240.ClassesDataSourceImpl(gh<_i267.ClassesApiClient>()),
    );
    gh.factory<_i683.StaffDataSourceContract>(
      () => _i329.StaffDataSourceImpl(gh<_i867.StaffApiClient>()),
    );
    gh.factory<_i469.SignupUseCase>(
      () => _i469.SignupUseCase(gh<_i218.SignupRepoContract>()),
    );
    gh.factory<_i283.PricingPlansRepoContract>(
      () =>
          _i252.PricingPlansRepImpl(gh<_i723.PricingPlansDataSourceContract>()),
    );
    gh.factory<_i622.SessionsRepoContract>(
      () => _i136.SessionsRepoImpl(gh<_i1013.SessionsDataSourceContract>()),
    );
    gh.factory<_i343.SignoutRepoContract>(
      () => _i704.SignoutRepoImpl(gh<_i904.SignoutDataSourceContract>()),
    );
    gh.factory<_i87.UserRepoContract>(
      () => _i265.UserRepoImpl(gh<_i742.UserDataSourceContract>()),
    );
    gh.factory<_i106.PricingPlansUseCase>(
      () => _i106.PricingPlansUseCase(gh<_i283.PricingPlansRepoContract>()),
    );
    gh.factory<_i66.SigninViewModel>(
      () => _i66.SigninViewModel(gh<_i620.SigninUseCase>()),
    );
    gh.factory<_i391.ContactsUseCase>(
      () => _i391.ContactsUseCase(gh<_i750.ContactsRepoContract>()),
    );
    gh.factory<_i726.ServicesRepoContract>(
      () => _i83.ServicesRepoImpl(gh<_i398.ServicesDataSourceContract>()),
    );
    gh.lazySingleton<_i672.ContactsViewModel>(
      () => _i672.ContactsViewModel(gh<_i391.ContactsUseCase>()),
    );
    gh.factory<_i185.ContactDetailsViewModel>(
      () => _i185.ContactDetailsViewModel(gh<_i391.ContactsUseCase>()),
    );
    gh.factory<_i77.ServicesUseCase>(
      () => _i77.ServicesUseCase(gh<_i726.ServicesRepoContract>()),
    );
    gh.factory<_i88.SignoutUseCase>(
      () => _i88.SignoutUseCase(gh<_i343.SignoutRepoContract>()),
    );
    gh.factory<_i733.SignupViewModel>(
      () => _i733.SignupViewModel(gh<_i469.SignupUseCase>()),
    );
    gh.factory<_i613.PricingPlanDetailsViewModel>(
      () => _i613.PricingPlanDetailsViewModel(gh<_i106.PricingPlansUseCase>()),
    );
    gh.factory<_i529.PricingPlansViewModel>(
      () => _i529.PricingPlansViewModel(gh<_i106.PricingPlansUseCase>()),
    );
    gh.factory<_i446.UserUseCase>(
      () => _i446.UserUseCase(gh<_i87.UserRepoContract>()),
    );
    gh.factory<_i902.ServicesViewModel>(
      () => _i902.ServicesViewModel(gh<_i77.ServicesUseCase>()),
    );
    gh.factory<_i26.StaffMembersRepoContract>(
      () => _i272.StaffMembersRepoImpl(gh<_i683.StaffDataSourceContract>()),
    );
    gh.factory<_i293.ClassesRepoContract>(
      () => _i1066.ClassesRepoImpl(gh<_i638.ClassesDataSourceContract>()),
    );
    gh.factory<_i523.StaffMembersUseCase>(
      () => _i523.StaffMembersUseCase(gh<_i26.StaffMembersRepoContract>()),
    );
    gh.factory<_i364.SignoutViewModel>(
      () => _i364.SignoutViewModel(gh<_i88.SignoutUseCase>()),
    );
    gh.factory<_i1050.SessionsUseCase>(
      () => _i1050.SessionsUseCase(gh<_i622.SessionsRepoContract>()),
    );
    gh.factory<_i258.ClassesUseCase>(
      () => _i258.ClassesUseCase(gh<_i293.ClassesRepoContract>()),
    );
    gh.factory<_i312.ClassesViewModel>(
      () => _i312.ClassesViewModel(gh<_i258.ClassesUseCase>()),
    );
    gh.factory<_i305.UserViewModel>(
      () => _i305.UserViewModel(
        gh<_i446.UserUseCase>(),
        gh<_i976.SessionManager>(),
      ),
    );
    gh.factory<_i847.StaffMemberViewModel>(
      () => _i847.StaffMemberViewModel(gh<_i523.StaffMembersUseCase>()),
    );
    gh.factory<_i806.StaffMembersViewModel>(
      () => _i806.StaffMembersViewModel(gh<_i523.StaffMembersUseCase>()),
    );
    gh.factory<_i301.SessionsViewModel>(
      () => _i301.SessionsViewModel(gh<_i1050.SessionsUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i183.DioModule {}
