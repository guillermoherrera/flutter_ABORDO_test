part of 'info_usuario_bloc.dart';

@immutable
abstract class InfoUsuarioState {
  final InfoUsuario? infoUsuario;

  const InfoUsuarioState({this.infoUsuario});
  
}

class InfoUsuarioInitialState extends InfoUsuarioState {
  const InfoUsuarioInitialState(): super(infoUsuario: null);
}

class InfoUsuarioSetState extends InfoUsuarioState{
  final InfoUsuario infoUsuarioNew;
  const InfoUsuarioSetState(this.infoUsuarioNew): super(infoUsuario: infoUsuarioNew);
}
