import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mask_for_camera_view/mask_for_camera_view.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/push_notifications_services.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import '../../ui/ui_files.dart';
import '../../widgets/message.dart';

void main(){
  serviceLocatorInit();
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  MaskForCameraView.initialize();
  PushNotificationService.initializeApp();
  runApp(const BlocsProviders());
}
class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<ActivarCubit>()),
        BlocProvider(create: (context) => getIt<ContrasenaCubit>()),
        BlocProvider(create: (context) => getIt<ProspectoBloc>()),
        BlocProvider(create: (context) => getIt<InfoUsuarioBloc>()),
        BlocProvider(create: (context) => getIt<LogUsuarioBloc>()),
        BlocProvider(create: (context) => getIt<ProspectosObtenerListaBloc>()),
        BlocProvider(create: (context) => getIt<ProspectoObtenerPerfilBloc>()),
      ], 
      child: const MyApp() 
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
        'message': (_)=> const MessageWidget(),
        'notificaciones': (_)=> const NotificationsScreen(),
        'dashProspeccion': (_)=> const DashProspeccionScreen(),
        'ocrSolicitudProspecto': (_)=> const OcrSolicitudProspectoScreen(),
        'formSolicitudProspecto': (_)=> const FormSolicitudProspectoScreen(),
        'formEvaluacionProspecto': (_)=> const FormEvaluacionProspectoScreen(),
        'dashVerificacion': (_)=> const DashVerificacionScreen(),
        'listProspectos': (_)=> const ListProspectosScreen(),
        'perfilProspecto': (_)=> const PerfilProspectoScreen(index: ''),
      },
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor:  ColorPalette.colorTerciario),
    );
  }
}