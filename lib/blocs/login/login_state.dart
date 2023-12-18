part of 'login_cubit.dart';

class LoginState extends Equatable {
  final String usuario;
  final String contrasena;
  
  const LoginState({this.usuario = "", this.contrasena = ""});

  LoginState copyWith({
    String? usuario,
    String? contrasena,
    bool? loading,
    bool? isValid,
  }) => LoginState(
    usuario: usuario ?? this.usuario,
    contrasena: contrasena ?? this.contrasena,
  );

  @override
  List<Object> get props => [usuario, contrasena];
}

final class LoginInitial extends LoginState {}
