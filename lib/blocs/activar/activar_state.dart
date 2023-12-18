part of 'activar_cubit.dart';

class ActivarState extends Equatable {
  final String usuario;
  final String telefono;
  final String codigo;
  final bool isCodeSend;
  final bool loading;
  
  const ActivarState({this.usuario = "", this.telefono = "", this.codigo = "", this.isCodeSend = false, this.loading = false});

  ActivarState copyWith({
    String? usuario,
    String? telefono,
    String? codigo,
    bool? isCodeSend,
    bool? loading,
  }) => ActivarState(
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    codigo: codigo ?? this.codigo,
    isCodeSend: isCodeSend ?? this.isCodeSend,
    loading: loading ?? this.loading,
  );

  @override
  List<Object> get props => [usuario, telefono, codigo, isCodeSend, loading];
}

final class ActivarInitial extends ActivarState {
  const ActivarInitial(): super(
    usuario: "", 
    telefono: "", 
    codigo: "",
    isCodeSend: false,
    loading: false,
  );
}
