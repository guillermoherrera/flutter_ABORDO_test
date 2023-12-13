part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String usuario;
  final String contrasena;
  final bool loading;
  
  const LoginState({this.usuario = '', this.contrasena = '', this.loading = false});

  LoginState copyWith({
    String? usuario,
    String? contrasena,
    bool? loading
  }) => LoginState(
    usuario: usuario ?? this.usuario,
    contrasena: usuario ?? this.contrasena,
    loading: loading ?? this.loading,
  );

  @override
  List<Object> get props => [usuario, contrasena, loading];
}

final class LoginInitial extends LoginState {}
