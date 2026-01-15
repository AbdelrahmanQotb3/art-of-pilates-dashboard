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

import '../../features/auth/signin/api/signin_api_client.dart' as _i996;
import '../dio_module/di_auth_model.dart' as _i229;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final diAuthModel = _$DiAuthModel();
    gh.singleton<_i361.Dio>(() => diAuthModel.dio);
    gh.factory<_i996.SigninApiClient>(
      () => _i996.SigninApiClient(gh<_i361.Dio>(), baseUrl: gh<String>()),
    );
    return this;
  }
}

class _$DiAuthModel extends _i229.DiAuthModel {}
