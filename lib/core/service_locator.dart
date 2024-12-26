import 'package:apply_at_supono/services/ad_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<AdService>(() => AdServiceImpl());
}
