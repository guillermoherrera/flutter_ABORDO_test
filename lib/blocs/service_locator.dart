import 'package:get_it/get_it.dart';

import 'blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit(){
  getIt.registerSingleton(LoginCubit());
  getIt.registerSingleton(ActivarCubit());
  getIt.registerSingleton(ContrasenaCubit());
}