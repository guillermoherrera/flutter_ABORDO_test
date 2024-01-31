part of 'info_usuario_bloc.dart';

@immutable
abstract class InfoUsuarioEvent {}

class NewInfoUsuario extends InfoUsuarioEvent{
  final InfoUsuario infoUsuario; 
  NewInfoUsuario(this.infoUsuario);
}