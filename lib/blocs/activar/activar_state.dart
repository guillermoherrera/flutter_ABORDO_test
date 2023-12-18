part of 'activar_cubit.dart';

class ActivarState extends Equatable {
  final String usuario;
  final String telefono;
  final String codigo;
  final bool isCodeSend;
  
  const ActivarState({this.usuario = "", this.telefono = "", this.codigo = "", this.isCodeSend = false});

  ActivarState copyWith({
    String? usuario,
    String? telefono,
    String? codigo,
    bool? isCodeSend,
  }) => ActivarState(
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    codigo: codigo ?? this.codigo,
    isCodeSend: isCodeSend ?? this.isCodeSend,
  );

  @override
  List<Object> get props => [usuario, telefono, codigo, isCodeSend];
}

final class ActivarInitial extends ActivarState {
  const ActivarInitial(): super(
    usuario: "", 
    telefono: "", 
    codigo: "",
    isCodeSend: false,
  );
}
