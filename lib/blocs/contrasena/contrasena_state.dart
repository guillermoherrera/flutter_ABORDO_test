part of 'contrasena_cubit.dart';

class ContrasenaState extends Equatable {
  final String usuario;
  final String telefono;
  final String codigo;
  final bool isCodeSend;
  final bool loading;
  final String contrasena;
  const ContrasenaState({this.usuario = "", this.telefono = "", this.codigo = "", this.isCodeSend = false, this.loading = false, this.contrasena = ""});

  ContrasenaState copyWith({
    String? usuario,
    String? telefono,
    String? codigo,
    bool? isCodeSend,
    bool? loading,
    String? contrasena,
  }) => ContrasenaState(
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    codigo: codigo ?? this.codigo,
    isCodeSend: isCodeSend ?? this.isCodeSend,
    loading: loading ?? this.loading,
    contrasena: contrasena ?? this.contrasena,
  );

  @override
  List<Object> get props => [usuario, telefono, codigo, isCodeSend, loading, contrasena];
}

final class ContrasenaInitial extends ContrasenaState {
  const ContrasenaInitial(): super(
    usuario: '',
    telefono: '',
    codigo: '',
    isCodeSend: false,
    loading: false,
    contrasena: '',
  );
}
