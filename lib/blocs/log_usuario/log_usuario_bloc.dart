import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

part 'log_usuario_state.dart';
part 'log_usuario_event.dart';

class LogUsuarioBloc extends Bloc<LogUsuarioEvent, LogUsuarioState>{

  LogUsuarioBloc() : super(const LogUsuarioInitialState()){
    on<NewLogUsuario>((event, emit) => emit(LogUsuarioSetState(event.logUsuario)));
  }
}