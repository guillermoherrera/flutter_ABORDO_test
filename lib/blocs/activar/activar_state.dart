part of 'activar_cubit.dart';

class ActivarState extends Equatable {
  final Usuario usuario;
  final Telefono telefono;
  final Codigo codigo;
  final bool loading;
  final bool isValid;
  final bool isCodeSend;
  final bool isCodeValid;
  
  const ActivarState({this.usuario = const Usuario.pure(), this.telefono = const Telefono.pure(), this.loading = false, this.isValid= false, this.codigo = const Codigo.pure(), this.isCodeSend = false, this.isCodeValid = false});

  ActivarState copyWith({
    Usuario? usuario,
    Telefono? telefono,
    Codigo? codigo,
    bool? loading,
    bool? isValid,
    bool? isCodeSend,
    bool? isCodeValid,
  }) => ActivarState(
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

final class ActivarInitial extends ActivarState {}
