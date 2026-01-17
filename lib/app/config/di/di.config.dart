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
import '../dio_module/di_auth_model.dart' as _i229;

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
    gh.factory<_i297.SigninApiClient>(
      () => _i297.SigninApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i557.SignupApiClient>(
      () => _i557.SignupApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i519.SigninDataSourceContract>(
      () => _i682.SigninDataSourceImpl(gh<_i297.SigninApiClient>()),
    );
    gh.factory<_i573.SignupDataSourceContract>(
      () => _i119.SignupDataSourceImpl(gh<_i557.SignupApiClient>()),
    );
    gh.factory<_i857.SigninRepoContract>(
      () => _i683.SigninRepoImpl(gh<_i519.SigninDataSourceContract>()),
    );
    gh.factory<_i218.SignupRepoContract>(
      () => _i767.SignupRepoImpl(gh<_i573.SignupDataSourceContract>()),
    );
    gh.factory<_i620.SigninUseCase>(
      () => _i620.SigninUseCase(gh<_i857.SigninRepoContract>()),
    );
    gh.factory<_i469.SignupUseCase>(
      () => _i469.SignupUseCase(gh<_i218.SignupRepoContract>()),
    );
    gh.factory<_i66.SigninViewModel>(
      () => _i66.SigninViewModel(gh<_i620.SigninUseCase>()),
    );
    gh.factory<_i733.SignupViewModel>(
      () => _i733.SignupViewModel(gh<_i469.SignupUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i229.DioModule {}
