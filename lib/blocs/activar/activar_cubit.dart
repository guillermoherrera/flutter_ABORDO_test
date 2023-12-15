import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/helpers/validator/validators.dart';
import 'package:formz/formz.dart';

part 'activar_state.dart';

class ActivarCubit extends Cubit<ActivarState> {
  ActivarCubit() : super(ActivarInitial());

  void loadingChanged(){
    emit(state.copyWith(loading: !state.loading));
  }
  void usuarioChanged(String value){
    final usuario = Usuario.dirty(value);
    emit(state.copyWith(usuario: usuario));
  }
  void telefonoChanged(String value){
    final telefono = Telefono.dirty(value);
    emit(state.copyWith(telefono: telefono));
  }
  void codigoChanged(String value){
    final codigo = Codigo.dirty(value);
    emit(state.copyWith(codigo: codigo));
  }
  void codigoSend(){
    emit(state.copyWith(isCodeSend: true));
  }

  bool onSubmitSolicitarActivacion(){
    emit(
      state.copyWith(
        usuario: Usuario.dirty(state.usuario.value),
        telefono: Telefono.dirty(state.telefono.value),
        isValid: Formz.validate([state.usuario, state.telefono])
      )
    );

    return state.isValid;
  }

  bool onSubmitActivacion(){
    emit(
      state.copyWith(
        usuario: Usuario.dirty(state.usuario.value),
        telefono: Telefono.dirty(state.telefono.value),
        codigo: Codigo.dirty(state.codigo.value),
        isCodeValid: Formz.validate([state.usuario, state.telefono, state.codigo])
      )
    );

    return state.isCodeValid;
  }
}
