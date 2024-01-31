part of 'log_usuario_bloc.dart';

@immutable
abstract class LogUsuarioState{
  final LogUsuario? logUsuario;

  const LogUsuarioState({
    this.logUsuario 
    });
}

class LogUsuarioInitialState extends LogUsuarioState{
  const LogUsuarioInitialState(): super(logUsuario: null);
}

class LogUsuarioSetState extends LogUsuarioState{
  final LogUsuario logUsuarioNew;
  const LogUsuarioSetState(this.logUsuarioNew): super(logUsuario: logUsuarioNew);
}
