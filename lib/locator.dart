import 'package:get_it/get_it.dart';
import 'services/deep_link_service.dart';
import 'services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DynamicLinkService());
  locator.registerLazySingleton(() => NavigationService());
}
