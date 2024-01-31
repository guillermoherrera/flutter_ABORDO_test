part of 'log_usuario_bloc.dart';

@immutable
abstract class LogUsuarioEvent{}

class NewLogUsuario extends LogUsuarioEvent{
  final LogUsuario logUsuario; 
  NewLogUsuario(this.logUsuario);
}
