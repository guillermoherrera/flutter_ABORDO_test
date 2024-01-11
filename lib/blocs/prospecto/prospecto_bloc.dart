import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

part 'prospecto_state.dart';
part 'prospecto_event.dart';

class ProspectoBloc extends Bloc<ProspectoEvent, ProspectoState>{

  ProspectoBloc() : super(const ProspectoInitialState()){
    on<NewProspectoOcr>((event, emit) => emit(ProspectoOcrSetState(event.prospecto)));

    on<ChangeProspectoSexo>((event, emit) {
      if(state.prospecto == null) return;
      emit(ProspectoOcrSetState(state.prospecto!.copyWith(sexo: event.sexo))); 
    });
  }
}