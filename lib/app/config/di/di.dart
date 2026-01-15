import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pilates_dashboard/app/config/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();
