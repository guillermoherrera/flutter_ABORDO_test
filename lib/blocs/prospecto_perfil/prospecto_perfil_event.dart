part of 'prospecto_perfil_bloc.dart';

@immutable
abstract class ProspectoObtenerPerfilEvent{}

class NewProspectoObtenerPerfil extends ProspectoObtenerPerfilEvent{
  final ProspectoObtenerPerfil prospectoPerfil; 
  NewProspectoObtenerPerfil(this.prospectoPerfil);
}
