part of 'contrasena_cubit.dart';

class ContrasenaState extends Equatable {
  final String usuario;
  final String telefono;
  final String codigo;
  final bool isCodeSend;
  const ContrasenaState({this.usuario = "", this.telefono = "", this.codigo = "", this.isCodeSend = false});

  ContrasenaState copyWith({
    String? usuario,
    String? telefono,
    String? codigo,
    bool? isCodeSend,
  }) => ContrasenaState(
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    codigo: codigo ?? this.codigo,
    isCodeSend: isCodeSend ?? this.isCodeSend,
  );

  @override
  List<Object> get props => [usuario, telefono, codigo, isCodeSend];
}

final class ContrasenaInitial extends ContrasenaState {}
