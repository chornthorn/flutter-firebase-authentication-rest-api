import 'package:flu_fire_auth/src/authentication/controller/authentication/authentication_cubit.dart';
import 'package:flu_fire_auth/src/authentication/service/authentication_service.dart';
import 'package:flu_fire_auth/src/splash/controller/splash_cubit.dart';
import 'package:get_it/get_it.dart';

/// [sl] = Singleton
/// [sl] is a Global variable!
GetIt sl = GetIt.instance;

Future<void> init() async {
  // Splash Controller
  sl.registerLazySingleton(() => SplashCubit());

  // Authentication module
  sl.registerLazySingleton(() => AuthenticationService());
  sl.registerFactory(() => AuthenticationCubit(sl()));

  // Demo sample service
  sl.registerSingletonAsync(() async => DemoSampleService().init());
}

class DemoSampleService {
  Future<DemoSampleService> init() async {
    await Future.delayed(const Duration(seconds: 5));
    return this;
  }
}
