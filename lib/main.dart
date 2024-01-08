import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  serviceLocatorInit();
  initializeDateFormatting();
  runApp(const BlocsProviders());
}
class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<ActivarCubit>()),
        BlocProvider(create: (context) => getIt<ContrasenaCubit>()),
      ], 
      child: const MyApp() 
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abordo App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'presentation',
      routes: {
        'presentation': (_)=> const PresentationScreen(),
        'login': (_)=> const LoginScreen(),
        'activar': (_)=> const ActivarScreen(),
        'contrasena': (_)=> const ContrasenaScreen(),
        'home': (_)=> const HomeScreen(),
        'notificaciones': (_)=> const NotificationsScreen(),
        'dashProspeccion': (_)=> const DashProspeccionScreen(),
        'formSolicitudProspecto': (_)=> const FormSolicitudProspectoScreen(),
        'dashVerificacion': (_)=> const DashVerificacionScreen(),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor:  const Color.fromRGBO(230, 230, 230, 1)),
    );
  }
}