import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'activar_state.dart';

class ActivarCubit extends Cubit<ActivarState> {
  ActivarCubit() : super(const ActivarInitial());

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
  
}
