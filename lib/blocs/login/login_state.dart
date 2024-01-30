part of 'login_bloc.dart';

@immutable
abstract class LoginState{
  final Login? login;

  const LoginState({
    this.login 
    });
}

class LoginInitialState extends LoginState{
  const LoginInitialState(): super(login: null);
}

class LoginSetState extends LoginState{
  final Login loginNew;
  const LoginSetState(this.loginNew): super(login: loginNew);
}
