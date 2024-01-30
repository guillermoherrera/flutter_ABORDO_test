part of 'login_bloc.dart';

@immutable
abstract class LoginEvent{}

class NewLogin extends LoginEvent{
  final Login login; 
  NewLogin(this.login);
}
