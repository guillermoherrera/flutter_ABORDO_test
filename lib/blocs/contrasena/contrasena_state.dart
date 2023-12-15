part of 'contrasena_cubit.dart';

class ContrasenaState extends Equatable {
  final Usuario usuario;
  final Telefono telefono;
  final Codigo codigo;
  final bool loading;
  final bool isValid;
  final bool isCodeSend;
  final bool isCodeValid;
  const ContrasenaState({this.usuario = const Usuario.pure(), this.telefono = const Telefono.pure(), this.loading = false, this.isValid= false, this.codigo = const Codigo.pure(), this.isCodeSend = false, this.isCodeValid = false});

  ContrasenaState copyWith({
    Usuario? usuario,
    Telefono? telefono,
    Codigo? codigo,
    bool? loading,
    bool? isValid,
    bool? isCodeSend,
    bool? isCodeValid,
  }) => ContrasenaState(
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    codigo: codigo ?? this.codigo,
    loading: loading ?? this.loading,
    isValid: isValid ?? this.isValid,
    isCodeSend: isCodeSend ?? this.isCodeSend,
    isCodeValid: isCodeValid ?? this.isCodeValid,
  );

  @override
  List<Object> get props => [usuario, telefono, codigo, loading, isValid, isCodeSend, isCodeValid];
}

final class ContrasenaInitial extends ContrasenaState {}
