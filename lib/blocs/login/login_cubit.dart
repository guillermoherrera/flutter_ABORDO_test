import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void loadingChanged(){
    emit(state.copyWith(loading: !state.loading));
  }
  void usuarioChanged(String value){
    emit(state.copyWith(usuario: value));
  }
  void contrasenaChanged(String value){
    emit(state.copyWith(contrasena: value));
  }
}
