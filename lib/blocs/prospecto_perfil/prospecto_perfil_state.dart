part of 'prospecto_perfil_bloc.dart';

@immutable
abstract class ProspectoObtenerPerfilState{
  final ProspectoObtenerPerfil? prospectoPerfil;

  const ProspectoObtenerPerfilState({
    this.prospectoPerfil 
    });
}

class ProspectoObtenerPerfilInitialState extends ProspectoObtenerPerfilState{
  const ProspectoObtenerPerfilInitialState(): super(prospectoPerfil: null);
}

class ProspectoObtenerPerfilSetState extends ProspectoObtenerPerfilState{
  final ProspectoObtenerPerfil prospectoPerfilNew;
  const ProspectoObtenerPerfilSetState(this.prospectoPerfilNew): super(prospectoPerfil: prospectoPerfilNew);
}
