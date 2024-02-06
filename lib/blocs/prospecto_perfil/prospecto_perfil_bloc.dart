import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

part 'prospecto_perfil_state.dart';
part 'prospecto_perfil_event.dart';

class ProspectoObtenerPerfilBloc extends Bloc<ProspectoObtenerPerfilEvent, ProspectoObtenerPerfilState>{

  ProspectoObtenerPerfilBloc() : super(const ProspectoObtenerPerfilInitialState()){
    on<NewProspectoObtenerPerfil>((event, emit) => emit(ProspectoObtenerPerfilSetState(event.prospectoPerfil)));
  }
}