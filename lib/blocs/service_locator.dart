import 'package:get_it/get_it.dart';

import 'blocs.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit(){
  getIt.registerSingleton(LoginBloc());
  getIt.registerSingleton(ActivarCubit());
  getIt.registerSingleton(ContrasenaCubit());
  getIt.registerSingleton(ProspectoBloc());
  getIt.registerSingleton(InfoUsuarioBloc());
  getIt.registerSingleton(LogUsuarioBloc());
  getIt.registerSingleton(ProspectosObtenerListaBloc());
  getIt.registerSingleton(ProspectoObtenerPerfilBloc());
}