import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/helpers/validator/validators.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void loadingChanged(){
    emit(state.copyWith(loading: !state.loading));
  }
  void usuarioChanged(String value){
    final usuario = Usuario.dirty(value);
    emit(state.copyWith(usuario: usuario, isValid: Formz.validate([usuario, state.contrasena])));
  }
  void contrasenaChanged(String value){
    final contrasena = Contrasena.dirty(value);
    emit(state.copyWith(contrasena: contrasena, isValid: Formz.validate([contrasena, state.usuario])));
  }

  bool onSubmit(){
    emit(
      state.copyWith(
        usuario: Usuario.dirty(state.usuario.value),
        contrasena: Contrasena.dirty(state.contrasena.value),
        isValid: Formz.validate([state.usuario, state.contrasena])
      )
    );

    return state.isValid;
  }
}
