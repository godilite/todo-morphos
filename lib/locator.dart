

import 'package:crud_firebase/services/firebase_services.dart';
import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => FirebaseService());

}
