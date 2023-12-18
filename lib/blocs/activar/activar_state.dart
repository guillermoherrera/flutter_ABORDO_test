part of 'activar_cubit.dart';

class ActivarState extends Equatable {
  final Usuario usuario;
  final Telefono telefono;
  final Codigo codigo;
  final bool loading;
  final bool isValid;
  final bool isCodeSend;
  final bool isCodeValid;
  final bool focusCode;
  
  const ActivarState({this.usuario = const Usuario.pure(), this.telefono = const Telefono.pure(), this.loading = false, this.isValid= false, this.codigo = const Codigo.pure(), this.isCodeSend = false, this.isCodeValid = false, this.focusCode = false});

  ActivarState copyWith({
    Usuario? usuario,
    Telefono? telefono,
    Codigo? codigo,
    bool? loading,
    bool? isValid,
    bool? isCodeSend,
    bool? isCodeValid,
    bool? focusCode,
  }) => ActivarState(
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    codigo: codigo ?? this.codigo,
    loading: loading ?? this.loading,
    isValid: isValid ?? this.isValid,
    isCodeSend: isCodeSend ?? this.isCodeSend,
    isCodeValid: isCodeValid ?? this.isCodeValid,
    focusCode: focusCode ?? this.focusCode,
  );

  @override
  List<Object> get props => [usuario, telefono, codigo, loading, isValid, isCodeSend, isCodeValid, focusCode];
}

final class ActivarInitial extends ActivarState {
  const ActivarInitial(): super(
    usuario: const Usuario.pure(), 
    telefono: const Telefono.pure(), 
    loading: false,
    isValid: false,
    codigo: const Codigo.pure(),
    isCodeSend: false,
    isCodeValid: false,
    focusCode: false,
  );
}
