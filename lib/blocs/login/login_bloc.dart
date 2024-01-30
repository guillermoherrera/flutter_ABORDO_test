import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  LoginBloc() : super(const LoginInitialState()){
    on<NewLogin>((event, emit) => emit(LoginSetState(event.login)));
  }
}