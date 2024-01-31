import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

part 'prospectos_lista_state.dart';
part 'prospectos_lista_event.dart';

class ProspectosObtenerListaBloc extends Bloc<ProspectosObtenerListaEvent, ProspectosObtenerListaState>{

  ProspectosObtenerListaBloc() : super(const ProspectosObtenerListaInitialState()){
    on<NewProspectosObtenerLista>((event, emit) => emit(ProspectosObtenerListaSetState(event.prospectosLista)));
  }
}