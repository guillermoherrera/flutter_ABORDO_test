part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Usuario usuario;
  final Contrasena contrasena;
  final bool loading;
  final bool isValid;
  
  const LoginState({this.usuario = const Usuario.pure(), this.contrasena = const Contrasena.pure(), this.loading = false, this.isValid= false});

  LoginState copyWith({
    Usuario? usuario,
    Contrasena? contrasena,
    bool? loading,
    bool? isValid,
  }) => LoginState(
    usuario: usuario ?? this.usuario,
    contrasena: contrasena ?? this.contrasena,
    loading: loading ?? this.loading,
    isValid: isValid ?? this.isValid,
  );

  @override
  List<Object> get props => [usuario, contrasena, loading, isValid];
}

final class LoginInitial extends LoginState {}
