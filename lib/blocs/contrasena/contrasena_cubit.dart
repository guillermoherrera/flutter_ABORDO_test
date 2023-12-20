import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'contrasena_state.dart';

class ContrasenaCubit extends Cubit<ContrasenaState> {
  ContrasenaCubit() : super(const ContrasenaInitial());

  void usuarioChanged(String value){
    emit(state.copyWith(usuario: value));
  }
  void telefonoChanged(String value){
    emit(state.copyWith(telefono: value));
  }
  void codigoChanged(String value){
    emit(state.copyWith(codigo: value));
  }
  void isCodeSendChanged(bool value){
    emit(state.copyWith(isCodeSend: value));
  }
  void loadingChanged(bool value){
    emit(state.copyWith(loading: value));
  }
  void contrasenaChanged(String value){
    emit(state.copyWith(contrasena: value));
  }
  void contrasenaInitial(){
    emit(const ContrasenaInitial());
  }
}
