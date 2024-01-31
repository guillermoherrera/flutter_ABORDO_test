import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';

part 'info_usuario_event.dart';
part 'info_usuario_state.dart';

class InfoUsuarioBloc extends Bloc<InfoUsuarioEvent, InfoUsuarioState> {

  InfoUsuarioBloc() : super(const InfoUsuarioInitialState()) {
     on<NewInfoUsuario>((event, emit) => emit(InfoUsuarioSetState(event.infoUsuario)));
  }
}
